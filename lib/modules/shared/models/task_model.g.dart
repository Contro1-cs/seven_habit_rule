// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      id: json['id'] as String? ?? "",
      userId: json['userId'] as String? ?? "",
      title: json['title'] as String? ?? "",
      status: json['status'] as bool? ?? false,
      description: json['description'] as String? ?? "",
      createdAt: json['createdAt'] as String? ?? "",
      updatedAt: json['updatedAt'] as String? ?? "",
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'status': instance.status,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
