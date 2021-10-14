import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_email_request.g.dart';

@JsonSerializable()
class ChangeEmailRequest {
  final String newEmail;
  final String password;

  ChangeEmailRequest({
    required this.newEmail,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$ChangeEmailRequestToJson(this);
}
