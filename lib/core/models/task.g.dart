// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      json['id'] as String,
      json['user_id'] as String,
      json['title'] as String,
      json['description'] as String,
      DateTime.parse(json['date'] as String),
      json['is_completed'] as bool,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'is_completed': instance.isCompleted,
    };
