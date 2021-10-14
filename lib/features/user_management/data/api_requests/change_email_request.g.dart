// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_email_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeEmailRequest _$ChangeEmailRequestFromJson(Map<String, dynamic> json) {
  return ChangeEmailRequest(
    newEmail: json['newEmail'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$ChangeEmailRequestToJson(ChangeEmailRequest instance) =>
    <String, dynamic>{
      'newEmail': instance.newEmail,
      'password': instance.password,
    };
