import 'package:flutter/material.dart';

import '../localization/translations.dart';
import 'base_validator.dart';

class MinLengthValidator extends BaseValidator {
  final int minLength;

  MinLengthValidator({required this.minLength, this.isFromVerificationPage});

  bool? isFromVerificationPage;

  @override
  String getMessage(BuildContext context) {
    if (isFromVerificationPage ?? false) return '*';
    return '${Translations.of(context).translate('v_min_length_1')} '
        '$minLength '
        '${Translations.of(context).translate('v_min_length_2')}';
  }

  @override
  bool validate(String value) {
    return value.length >= minLength;
  }
}
