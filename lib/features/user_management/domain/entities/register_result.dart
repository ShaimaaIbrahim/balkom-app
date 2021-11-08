import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';

class RegisterResult extends BaseEntity {
  final int? id;
  final String? name;
  final String? email;
  final String? photo;
  final bool? status;

  final int? otpCode;
  final String? address;
  final String? phone;

  final String? aboutMe;

  final String? accessToken;
  final String? tokenType;
  final String? expiresAt;
  final String? credit;
  final String? debit;
  final String? balance;

  RegisterResult({
    required this.name,
    required this.id,
    required this.accessToken,
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
    required this.tokenType,
    required this.email,
  });

  @override
  List<Object> get props => [
        name ?? '',
        id ?? 0,
        accessToken ?? '',
        balance ?? '',
        credit ?? 0,
        debit ?? 0,
        expiresAt ?? '',
        otpCode ?? '',
        photo ?? '',
        status ?? '',
        phone ?? '',
        aboutMe ?? '',
        address ?? '',
        tokenType ?? '',
      ];
}
