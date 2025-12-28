enum KanbanStatus { todo, inProgress, review, done }

class KanbanTask {
  final String id;
  final String title;
  final String? description;
  final KanbanStatus status;
  final DateTime createdAt;
  final String? priority;

  KanbanTask({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.createdAt,
    this.priority,
  });

  KanbanTask copyWith({
    String? id,
    String? title,
    String? description,
    KanbanStatus? status,
    DateTime? createdAt,
    String? priority,
  }) {
    return KanbanTask(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      priority: priority ?? this.priority,
    );
  }
}
