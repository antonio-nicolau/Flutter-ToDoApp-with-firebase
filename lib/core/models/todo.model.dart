class Todo {
  final String title;

  final bool done;
  final DateTime schedule;

  Todo({
    required this.title,
    this.done = false,
    required this.schedule,
  });

  factory Todo.fromMap(Map<String, dynamic> data) {
    return Todo(
      title: data['title'],
      done: data['done'] ?? false,
      schedule: DateTime.tryParse(data['schedule'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'done': done,
      'schedule': schedule.toIso8601String(),
    };
  }

  Todo copyWith({String? title, DateTime? schedule, bool? done}) {
    return Todo(
      title: title ?? this.title,
      done: done ?? this.done,
      schedule: schedule ?? this.schedule,
    );
  }
}
