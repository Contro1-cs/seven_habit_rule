// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatModelImpl _$$ChatModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatModelImpl(
      author: json['author'] as String? ?? "",
      message: json['message'] as String? ?? "",
      time: json['time'] as String? ?? "",
      chatType: json['chatType'] as String? ?? "",
    );

Map<String, dynamic> _$$ChatModelImplToJson(_$ChatModelImpl instance) =>
    <String, dynamic>{
      'author': instance.author,
      'message': instance.message,
      'time': instance.time,
      'chatType': instance.chatType,
    };
