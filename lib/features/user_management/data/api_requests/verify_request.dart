import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_request.g.dart';

@JsonSerializable()
class VerifyRequest {
  final String mobile;
  @JsonKey(name: 'otp_code')
  final String code;

  VerifyRequest({
    required this.mobile,
    required this.code,
  });

  Map<String, dynamic> toJson() => _$VerifyRequestToJson(this);
}
