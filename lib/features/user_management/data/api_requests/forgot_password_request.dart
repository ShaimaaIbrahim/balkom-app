import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request.g.dart';

@JsonSerializable()
class ForgotPasswordRequest {
  final String mobile;
  final String device_token;

  ForgotPasswordRequest({
    required this.mobile,
    required this.device_token,
  });

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);
}
