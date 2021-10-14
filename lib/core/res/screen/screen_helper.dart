import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreensHelper {
  static late double width;
  static late double height;

  ScreensHelper(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  static fromWidth(double percent) {
    assert(percent >= 0.0 && percent <= 100.0);
    return (percent / 100.0) * width;
  }

  static fromHeight(double percent) {
    assert(percent >= 0.0 && percent <= 100.0);
    return (percent / 100.0) * height;
  }

  static scaleText(double fontSize, {bool? allowFontScalingSelf}) {
    return ScreenUtil().setSp(
      fontSize,
    );
  }
}
