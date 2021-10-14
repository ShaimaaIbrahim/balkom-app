import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFDADADA),
      height: ScreenUtil().setHeight(1),
      width: ScreenUtil().setWidth(200),
    );
  }
}
