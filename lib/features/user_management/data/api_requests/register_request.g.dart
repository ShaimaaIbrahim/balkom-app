// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) {
  return RegisterRequest(
    name: json['name'] as String,
    password: json['password'] as String,
    email: json['email'] as String,
    device_token: json['device_token'] as String,
    phone: json['phone'] as String,
  );
}

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.email,
      'email':instance.email,
      'password': instance.password,
      'device_token': instance.device_token,
    };
