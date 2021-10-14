import 'package:flutter/material.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/validators/base_validator.dart';

class VerificationCodeValidator extends BaseValidator {
  @override
  String getMessage(BuildContext context) {
    return Translations.of(context).translate('v_invalid_code');
  }

  @override
  bool validate(String value) {
    return value != null && value.isNotEmpty && value.length == 5;
  }
}
