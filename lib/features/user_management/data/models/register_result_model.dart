import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/user_management/domain/entities/register_result.dart';

part 'register_result_model.g.dart';

@JsonSerializable()
class RegisterResultModel extends BaseModel<RegisterResult> {
  final int id;
  final String name;
  final String email;
  final String photo;
  @JsonKey(name: 'otp_code')
  final int otpCode;
  final String address;
  final String phone;
  @JsonKey(name: 'about_me')
  final String aboutMe;
  @JsonKey(name: 'access_token')
  final String accessToken;
  final bool status;
  @JsonKey(name: 'token_type')
  final String tokenType;
  @JsonKey(name: 'expires_at')
  final String expiresAt;
  final String credit;
  final String debit;
  final String balance;

  RegisterResultModel({
    required this.name,
    required this.id,
    required this.tokenType,
    required this.balance,
    required this.credit,
    required this.debit,
    required this.expiresAt,
    required this.otpCode,
    required this.photo,
    required this.status,
    required this.phone,
    required this.aboutMe,
    required this.address,
    required this.accessToken,
    required this.email,
  });

  factory RegisterResultModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResultModelFromJson(json);

  @override
  RegisterResult toEntity() => RegisterResult(
        photo: this.photo,
        otpCode: this.otpCode,
        accessToken: this.accessToken,
        debit: this.debit,
        credit: this.credit,
        balance: this.balance,
        expiresAt: this.expiresAt,
        name: this.name,
        id: this.id,
        status: this.status,
        phone: this.phone,
        aboutMe: this.aboutMe,
        address: this.address,
        tokenType: this.tokenType,
        email: this.email,
      );
}
