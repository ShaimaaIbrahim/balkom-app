import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/res/global_color.dart';

class RoundedButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final Widget child;
  final Color? color;
  final Function()? onPressed;

  const RoundedButton(
      {Key? key,
      required this.child,
      this.color,
      this.height,
      this.width,
      this.borderRadius = 0.0,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: this.width ?? 200.w,
      height: height ?? 45.h,
      child: RaisedButton(
          padding: const EdgeInsets.all(8.0),
          color: color ?? globalColor.white,
          onPressed: onPressed ?? () {},
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          child: child),
    );
  }
}
