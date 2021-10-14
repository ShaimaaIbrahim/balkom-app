import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/user_management/domain/entities/register_result.dart';

part 'register_result_model.g.dart';

@JsonSerializable()
class RegisterResultModel extends BaseModel<RegisterResult> {
  final String? name;
  final String? phone;
  @JsonKey(name: 'api_token')
  final String? apiToken;
  @JsonKey(name: 'otp_code')
  final int? otpCode;
  @JsonKey(name: 'mobile_active')
  final String? mobileActive;
  @JsonKey(name: 'device_type')
  final String? deviceType;
  final String? photo;
  final int? id;
  final int? credit;
  final int? debit;
  final String? balance;

  // final String msg;

  RegisterResultModel({
    required this.phone,
    required this.name,
    required this.id,
    required this.apiToken,
    required this.balance,
    required this.credit,
    required this.debit,
    required this.deviceType,
    required this.mobileActive,
    required this.otpCode,
    required this.photo,
  });

  factory RegisterResultModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResultModelFromJson(json);

  @override
  RegisterResult toEntity() => RegisterResult(
      id: this.id,
      name: this.name,
      apiToken: this.apiToken,
      // balance: this.balance,
      credit: this.credit,
      debit: this.debit,
      deviceType: this.deviceType,
      mobile: this.phone,
      mobileActive: this.mobileActive,
      otpCode: this.otpCode,
      photo: this.photo);
}
