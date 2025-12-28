import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_dimensions.dart';
import '../model/kanban_task.dart';
import '../view_model/kanban_view_model.dart';
import 'widgets/kanban_column.dart';

class KanbanBoardView extends StatelessWidget {
  const KanbanBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<KanbanViewModel>();
    final screenWidth = MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 800;
    final isTablet = screenWidth >= 800 && screenWidth < 1200;
    final columnWidth = isTablet ? 280.0 : 320.0;

    final columns = [
      const _KanbanColumnConfig(
        title: 'Todo',
        status: KanbanStatus.todo,
      ),
      const _KanbanColumnConfig(
        title: 'In Progress',
        status: KanbanStatus.inProgress,
      ),
      const _KanbanColumnConfig(
        title: 'Review',
        status: KanbanStatus.review,
      ),
      const _KanbanColumnConfig(
        title: 'Done',
        status: KanbanStatus.done,
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kanban Board',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          const Text(
            'Track product-related tasks across Todo, In Progress, Review and Done.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final config in columns) ...[
                  KanbanColumn(
                    title: config.title,
                    status: config.status,
                    tasks: viewModel.tasksByStatus(config.status),
                    onAddTask: () => _showTaskDialog(
                      context,
                      initialStatus: config.status,
                    ),
                    onEditTask: (task) => _showTaskDialog(
                      context,
                      task: task,
                      initialStatus: task.status,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingLarge),
                ],
              ],
            )
          else
            SizedBox(
              height: isTablet ? 520 : 560,
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final config in columns) ...[
                        SizedBox(
                          width: columnWidth,
                          child: KanbanColumn(
                            title: config.title,
                            status: config.status,
                            tasks: viewModel.tasksByStatus(config.status),
                            onAddTask: () => _showTaskDialog(
                              context,
                              initialStatus: config.status,
                            ),
                            onEditTask: (task) => _showTaskDialog(
                              context,
                              task: task,
                              initialStatus: task.status,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppDimensions.paddingLarge),
                      ],
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _showTaskDialog(
    BuildContext context, {
    KanbanTask? task,
    required KanbanStatus initialStatus,
  }) async {
    final isEditing = task != null;
    final titleController = TextEditingController(text: task?.title ?? '');
    final descriptionController =
        TextEditingController(text: task?.description ?? '');
    KanbanStatus status = task?.status ?? initialStatus;
    String? priority = task?.priority;

    final viewModel = context.read<KanbanViewModel>();

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Task' : 'Add Task'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<KanbanStatus>(
                  value: status,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: const [
                    DropdownMenuItem(
                      value: KanbanStatus.todo,
                      child: Text('Todo'),
                    ),
                    DropdownMenuItem(
                      value: KanbanStatus.inProgress,
                      child: Text('In Progress'),
                    ),
                    DropdownMenuItem(
                      value: KanbanStatus.review,
                      child: Text('Review'),
                    ),
                    DropdownMenuItem(
                      value: KanbanStatus.done,
                      child: Text('Done'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      status = value;
                    }
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: priority,
                  decoration: const InputDecoration(labelText: 'Priority'),
                  items: const [
                    DropdownMenuItem(value: 'High', child: Text('High')),
                    DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                    DropdownMenuItem(value: 'Low', child: Text('Low')),
                  ],
                  onChanged: (value) {
                    priority = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            if (isEditing)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _confirmDelete(context, task.id);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                final description = descriptionController.text.trim();
                if (title.isEmpty) return;

                if (isEditing) {
                  viewModel.updateTask(
                    task.copyWith(
                      title: title,
                      description: description.isEmpty ? null : description,
                      status: status,
                      priority: priority,
                    ),
                  );
                } else {
                  viewModel.addTask(
                    title: title,
                    description: description.isEmpty ? null : description,
                    status: status,
                    priority: priority,
                  );
                }

                Navigator.of(context).pop();
              },
              child: Text(isEditing ? 'Save' : 'Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmDelete(BuildContext context, String taskId) async {
    final viewModel = context.read<KanbanViewModel>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      viewModel.deleteTask(taskId);
    }
  }
}

class _KanbanColumnConfig {
  final String title;
  final KanbanStatus status;

  const _KanbanColumnConfig({
    required this.title,
    required this.status,
  });
}
