import 'package:flutter/foundation.dart';

import '../model/kanban_task.dart';

class KanbanViewModel extends ChangeNotifier {
  final List<KanbanTask> _tasks = [];
  int _idCounter = 0;

  KanbanViewModel() {
    _seedMockData();
  }

  List<KanbanTask> get tasks => List.unmodifiable(_tasks);

  List<KanbanTask> tasksByStatus(KanbanStatus status) {
    return _tasks.where((t) => t.status == status).toList();
  }

  void moveTask(String taskId, KanbanStatus newStatus) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index == -1) return;
    _tasks[index] = _tasks[index].copyWith(status: newStatus);
    notifyListeners();
  }

  void addTask({
    required String title,
    String? description,
    required KanbanStatus status,
    String? priority,
  }) {
    final task = KanbanTask(
      id: 'task_${_idCounter++}',
      title: title,
      description: description,
      status: status,
      createdAt: DateTime.now(),
      priority: priority,
    );
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(KanbanTask updated) {
    final index = _tasks.indexWhere((t) => t.id == updated.id);
    if (index == -1) return;
    _tasks[index] = updated;
    notifyListeners();
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((t) => t.id == taskId);
    notifyListeners();
  }

  void _seedMockData() {
    addTask(
      title: 'Design product schema',
      description: 'Define product attributes and validation rules.',
      status: KanbanStatus.todo,
      priority: 'High',
    );
    addTask(
      title: 'Implement product API',
      description: 'Create CRUD endpoints for products.',
      status: KanbanStatus.inProgress,
      priority: 'Medium',
    );
    addTask(
      title: 'QA test product filters',
      description: 'Verify search and filter behavior.',
      status: KanbanStatus.review,
      priority: 'Low',
    );
    addTask(
      title: 'Deploy initial product module',
      description: 'Deploy to staging environment.',
      status: KanbanStatus.done,
      priority: 'High',
    );
  }
}
