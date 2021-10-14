import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/entities/base_entity.dart';

class ForgetResult extends BaseEntity {
  final String? otp_code;

  // final String msg;

  ForgetResult({
    required this.otp_code,
  });

  @override
  List<Object> get props => [
        otp_code!,
      ];
}
