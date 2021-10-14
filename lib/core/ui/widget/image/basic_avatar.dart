import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicAvatar extends StatelessWidget {
  final double radius;
  final String imageUrl;
  final bool hasShadow;
  final bool hasBorder;

  const BasicAvatar({
    Key? key,
    required this.imageUrl,
    this.radius = 20,
    this.hasShadow = true,
    this.hasBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().setWidth(radius * 2),
      height: ScreenUtil().setWidth(radius * 2),
      child: FittedBox(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border:
                hasBorder ? Border.all(color: Colors.white, width: 1) : null,
            boxShadow: hasShadow
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5, // has the effect of softening the shadow
                      spreadRadius: 0, // has the effect of extending the shadow
                    ),
                  ]
                : null,
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              width: ScreenUtil().setWidth(radius * 2),
              height: ScreenUtil().setWidth(radius * 2),
              fit: BoxFit.cover,
              imageUrl: imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}
