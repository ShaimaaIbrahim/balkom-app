import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Avatar extends StatelessWidget {
  final double radius;
  final String imageUrl;
  final bool hasShadow;

  const Avatar({
    Key? key,
    required this.imageUrl,
    this.radius = 20,
    this.hasShadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10.0, // has the effect of softening the shadow
                  spreadRadius: 3,
                  offset:
                      Offset(0, 3), // has the effect of extending the shadow
                ),
              ]
            : null,
      ),
      child: CircleAvatar(
        radius: ScreenUtil().setWidth(radius),
        backgroundColor: Colors.grey.withOpacity(0.5),
        backgroundImage: NetworkImage(imageUrl),
      ),
    );
  }
}
