import 'package:flutter/material.dart';
import 'package:ojos_app/core/localization/translations.dart';

import 'base_validator.dart';

class RequiredValidator extends BaseValidator {
  bool? isFromVerificationPage;
  RequiredValidator({this.isFromVerificationPage});
  @override
  String getMessage(BuildContext context) {
    if (isFromVerificationPage ?? false) return '*';
    return Translations.of(context).translate('v_required');
  }

  @override
  bool validate(String value) {
    return value != null && value.isNotEmpty;
  }
}
