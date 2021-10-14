import 'package:flutter/foundation.dart';

class ForgetArgs {
  final String mobile;
  final int code;

  ForgetArgs({required this.code, required this.mobile})
      : assert(mobile != null);
}
