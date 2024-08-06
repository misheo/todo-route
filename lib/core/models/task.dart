import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  String id ; 
  @JsonKey(name: 'user_id')
  String userId ; 
  String title ;
  String description ;
  @JsonKey(name: 'date')
  DateTime date; 

  @JsonKey(name: 'is_completed')
  bool isCompleted ;



  Task( this.id, this.userId, this.title, this.description, this.date, this.isCompleted);

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}