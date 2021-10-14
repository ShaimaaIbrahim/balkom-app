import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';

class RegisterResult extends BaseEntity {
  final String? name;
  final String? mobile;
  final String? apiToken;
  final int? otpCode;
  final String? mobileActive;
  final String? deviceType;
  final String? photo;
  final int? id;
  final int? credit;
  final int? debit;
  //final int? balance;

  // final String msg;

  RegisterResult({
    required this.mobile,
    required this.name,
    required this.id,
    required this.apiToken,
    // required this.balance,
    required this.credit,
    required this.debit,
    required this.deviceType,
    required this.mobileActive,
    required this.otpCode,
    required this.photo,
  });

  @override
  List<Object> get props => [
        mobile ?? '',
        name ?? '',
        id ?? '',
        apiToken ?? '',
        //balance ?? '',
        credit ?? '',
        debit ?? '',
        deviceType ?? '',
        mobileActive ?? '',
        otpCode ?? '',
        photo ?? '',
      ];
}
