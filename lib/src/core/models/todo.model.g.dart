// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      userId: json['userId'] as String,
      title: json['title'] as String,
      done: json['done'] as bool? ?? false,
      schedule: DateTime.parse(json['schedule'] as String),
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'title': instance.title,
      'userId': instance.userId,
      'done': instance.done,
      'schedule': instance.schedule.toIso8601String(),
    };
