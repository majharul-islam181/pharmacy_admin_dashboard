import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../model/kanban_task.dart';
import '../../view_model/kanban_view_model.dart';
import 'kanban_task_card.dart';

class KanbanColumn extends StatelessWidget {
  final String title;
  final KanbanStatus status;
  final List<KanbanTask> tasks;
  final VoidCallback onAddTask;
  final ValueChanged<KanbanTask> onEditTask;

  const KanbanColumn({
    super.key,
    required this.title,
    required this.status,
    required this.tasks,
    required this.onAddTask,
    required this.onEditTask,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<KanbanViewModel>();

    return DragTarget<KanbanTask>(
      onWillAcceptWithDetails: (details) => details.data.status != status,
      onAcceptWithDetails: (details) {
        viewModel.moveTask(details.data.id, status);
      },
      builder: (context, candidate, rejected) {
        final isHighlighted = candidate.isNotEmpty;

        return Container(
          decoration: BoxDecoration(
            color: isHighlighted
                ? AppColors.primary.withOpacity(0.06)
                : const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            border: Border.all(
              color:
                  isHighlighted ? AppColors.primary : const Color(0xFFE5E7EB),
            ),
          ),
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      tasks.length.toString(),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      size: 18,
                    ),
                    onPressed: onAddTask,
                    tooltip: 'Add task',
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.paddingSmall),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Draggable<KanbanTask>(
                      data: task,
                      feedback: Material(
                        color: Colors.transparent,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 260),
                          child: Opacity(
                            opacity: 0.85,
                            child: KanbanTaskCard(
                              task: task,
                              onTap: () {},
                            ),
                          ),
                        ),
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.3,
                        child: KanbanTaskCard(
                          task: task,
                          onTap: () {},
                        ),
                      ),
                      child: KanbanTaskCard(
                        task: task,
                        onTap: () => onEditTask(task),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
