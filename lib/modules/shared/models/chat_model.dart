import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
abstract class ChatModel with _$ChatModel {
  const factory ChatModel({
    @Default("") String author,
    @Default("") String message,
    @Default("") String time,
    @Default("") String chatType,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
