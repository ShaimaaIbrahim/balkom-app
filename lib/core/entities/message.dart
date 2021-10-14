import 'package:ojos_app/core/models/message_model.dart';

import 'base_entity.dart';

class Message extends BaseEntity {
  final MessageType? type;
  final String? content;
  final int? code;

  Message({
    this.type,
    this.content,
    this.code,
  });

  @override
  List<Object> get props => [
        this.type ?? 'type null',
        this.code ?? 'code null',
        this.content ?? 'content null',
      ];
}
