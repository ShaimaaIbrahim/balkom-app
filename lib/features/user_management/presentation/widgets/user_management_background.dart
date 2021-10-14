import 'package:flutter/material.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/global_color.dart';

class UserManagementBackground extends StatelessWidget {
  final double? width;
  final double? height;
  final String? image;

  const UserManagementBackground({this.height, this.width, this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            child: Image.asset(
              image ?? AppAssets.backgroundSignIn,
              fit: BoxFit.fill,
              width: width,
              height: height,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                  globalColor.primaryColor.withOpacity(0.5),
                  globalColor.primaryColor.withOpacity(0.5),
                ],
                    begin: AlignmentDirectional.topCenter,
                    end: AlignmentDirectional.bottomCenter)),
          ),
        ],
      ),
    );
  }
}
