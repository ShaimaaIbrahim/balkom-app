import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'external_login_request.g.dart';

@JsonSerializable()
class ExternalLoginRequest {
  final int provider;
  final String token;

  ExternalLoginRequest({required this.provider, required this.token});

  Map<String, dynamic> toJson() => _$ExternalLoginRequestToJson(this);

  @override
  String toString() {
    return 'provider is $provider' + '\n' + 'token is $token' + '\n';
  }
}
