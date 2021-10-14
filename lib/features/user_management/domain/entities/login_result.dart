import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';

class LoginResult extends BaseEntity {
  final int id;
  final String name;
  final String email;
  final String photo;
  final String status;
  final String mobile;
  final int otpCode;
  final bool mobileActive;
  final String address;
  final String phone;
  final String aboutMe;
  final String accessToken;
  final String tokenType;
  final String expiresAt;
  final int credit;
  final int debit;
  final int balance;

  // final String msg;

  LoginResult({
    required this.mobile,
    required this.name,
    required this.id,
    required this.accessToken,
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
    required this.tokenType,
    required this.email,
  });

  @override
  List<Object> get props => [
        mobile,
        name,
        id,
        accessToken,
        balance,
        credit,
        debit,
        expiresAt,
        mobileActive,
        otpCode,
        photo,
        status,
        phone,
        aboutMe,
        address,
        tokenType,
      ];
}
