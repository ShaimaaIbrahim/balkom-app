import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  final String mobile;
  final String password;
  final String otp_code;

  ResetPasswordRequest({
    required this.mobile,
    required this.otp_code,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
