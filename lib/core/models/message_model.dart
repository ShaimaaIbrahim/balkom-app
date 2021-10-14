import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/entities/message.dart';

import 'base_model.dart';

part 'message_model.g.dart';

enum MessageType { Error, Success }

@JsonSerializable()
class MessageModel extends BaseModel<Message> {
  final MessageType? type;
  final String? content;
  final int? code;

  MessageModel({
    required this.type,
    required this.code,
    required this.content,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  @override
  Message toEntity() {
    return Message(
      type: this.type,
      code: this.code,
      content: this.content,
    );
  }
}
