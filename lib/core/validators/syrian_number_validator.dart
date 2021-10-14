import 'package:flutter/material.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/validators/base_validator.dart';

class SyrianNumberValidator extends BaseValidator {
  @override
  String getMessage(BuildContext context) {
    return Translations.of(context).translate('v_invalid_number');
  }

  @override
  bool validate(String value) {
    return value != null &&
        value.isNotEmpty &&
//        ((value.startsWith('09') && value.length == 10) ||
//            (value.startsWith('009639') && value.length == 14) ||
//            (value.startsWith('+9639') && value.length == 13));
        (value.startsWith('09') && value.length == 10);
  }
}
