import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
   @JsonKey(name: 'name')
  final String name;
   final String phone;
  final String email;
  final String password;
  final String device_token;

  RegisterRequest({
    required this.phone,
    required this.name,
    required this.password,
    required this.email,
    required this.device_token,
  });

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
