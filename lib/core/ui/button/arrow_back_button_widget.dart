import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/utils.dart';

class ArrowIconButtonWidget extends StatefulWidget {
  final Color? iconColor;
  final Function()? onTap;

  const ArrowIconButtonWidget({this.iconColor, this.onTap});

  @override
  _ArrowIconButtonWidgetState createState() => _ArrowIconButtonWidgetState();
}

class _ArrowIconButtonWidgetState extends State<ArrowIconButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap ??
          () {
            Get.key.currentState?.maybePop();
          },
      child: Center(
        child: Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: globalColor.white,
              border: Border.all(
                  color: globalColor.grey.withOpacity(0.3), width: 0.5),
              borderRadius: BorderRadius.circular(12.0.w),
            ),
            child: Center(
              child: Icon(
                utils.getLang() == 'ar'
                    ? Icons.keyboard_arrow_right
                    : Icons.keyboard_arrow_left,
                size: 25.w,
                color: widget.iconColor ?? globalColor.black,
              ),
            )),
      ),
    );
  }
}
