// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordRequest _$ResetPasswordRequestFromJson(Map<String, dynamic> json) {
  return ResetPasswordRequest(
    mobile: json['phone'] as String,
    otp_code: json['otp_code'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$ResetPasswordRequestToJson(
        ResetPasswordRequest instance) =>
    <String, dynamic>{
      'phone': instance.mobile,
      'password': instance.password,
      'otp_code': instance.otp_code,
    };
