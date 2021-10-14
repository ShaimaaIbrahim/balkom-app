import 'package:flutter/foundation.dart';

class VerifyPageArgs {
  final String userName;
  final int? otpCode;
  final bool? isNeedVerify;
  final String? verifyUrl;
  final String? resendCodeUrl;
  final int? caseOfResendCode;

  VerifyPageArgs({
    required this.userName,
    this.otpCode,
    this.verifyUrl,
    this.resendCodeUrl,
    this.caseOfResendCode,
    this.isNeedVerify = false,
  });
}
