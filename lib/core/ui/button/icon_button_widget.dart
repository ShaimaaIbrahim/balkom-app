import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/res/global_color.dart';

class IconButtonWidget extends StatefulWidget {
  final Widget? icon;
  final Function()? onTap;

  const IconButtonWidget({this.icon, this.onTap});

  @override
  _IconButtonWidgetState createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap ?? () {},
      child: Center(
        child: Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: globalColor.white,
              borderRadius: BorderRadius.circular(12.0.w),
              border: Border.all(
                  color: globalColor.grey.withOpacity(0.3), width: 0.5),
            ),
            child: Center(
              child: widget.icon ?? Container(),
            )),
      ),
    );
  }
}
