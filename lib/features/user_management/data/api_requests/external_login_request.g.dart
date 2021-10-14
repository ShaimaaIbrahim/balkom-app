// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'external_login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExternalLoginRequest _$ExternalLoginRequestFromJson(Map<String, dynamic> json) {
  return ExternalLoginRequest(
    provider: json['provider'] as int,
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$ExternalLoginRequestToJson(
        ExternalLoginRequest instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'token': instance.token,
    };
