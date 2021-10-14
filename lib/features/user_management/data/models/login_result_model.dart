import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/user_management/domain/entities/login_result.dart';

part 'login_result_model.g.dart';

@JsonSerializable()
class LoginResultModel extends BaseModel<LoginResult> {
  final int id;
  final String name;
  final String email;
  final String photo;
  final String status;
  final String mobile;
  @JsonKey(name: 'otp_code')
  final int otpCode;
  @JsonKey(name: 'mobile_active')
  final bool mobileActive;
  final String address;
  final String phone;
  @JsonKey(name: 'about_me')
  final String aboutMe;
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'token_type')
  final String tokenType;
  @JsonKey(name: 'expires_at')
  final String expiresAt;
  final int credit;
  final int debit;
  final int balance;

  // final String msg;

  LoginResultModel({
    required this.mobile,
    required this.name,
    required this.id,
    required this.tokenType,
    required this.balance,
    required this.credit,
    required this.debit,
    required this.expiresAt,
    required this.mobileActive,
    required this.otpCode,
    required this.photo,
    required this.status,
    required this.phone,
    required this.aboutMe,
    required this.address,
    required this.accessToken,
    required this.email,
  });

  factory LoginResultModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultModelToJson(this);

  @override
  LoginResult toEntity() => LoginResult(
        photo: this.photo,
        otpCode: this.otpCode,
        mobileActive: this.mobileActive,
        mobile: this.mobile,
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
