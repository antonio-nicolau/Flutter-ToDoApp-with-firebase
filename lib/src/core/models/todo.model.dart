import 'package:json_annotation/json_annotation.dart';
part 'todo.model.g.dart';

@JsonSerializable()
class Todo {
  final String title;
  final String userId;
  final bool done;
  final DateTime schedule;

  Todo({
    required this.userId,
    required this.title,
    this.done = false,
    required this.schedule,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  Todo copyWith({String? userId, String? title, DateTime? schedule, bool? done}) {
    return Todo(
      userId: userId ?? this.userId,
      title: title ?? this.title,
      done: done ?? this.done,
      schedule: schedule ?? this.schedule,
    );
  }
}
