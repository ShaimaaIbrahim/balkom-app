import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NormalAssetsImage extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final double width;
  final BoxFit? fit;
  final double imageBorderRadius;

  const NormalAssetsImage({
    required this.imageUrl,
    required this.width,
    required this.height,
    this.imageBorderRadius = 0,
    this.fit = BoxFit.fill,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(imageBorderRadius),
        child: Container(
            width: width,
            height: height,
            child: Image.asset(
              imageUrl ?? '',
              width: width,
              height: height,
              fit: fit ?? BoxFit.fill,
            )),
      ),
    );
  }
}
