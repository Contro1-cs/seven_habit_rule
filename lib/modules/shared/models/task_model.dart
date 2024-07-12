import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class TaskModel with _$TaskModel {
  factory TaskModel({
    @Default("") String id,
    @Default("") String userId,
    @Default("") String title,
    @Default(false) bool status,
    @Default("") String description,
    @Default("") String createdAt,
    @Default("") String updatedAt,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}