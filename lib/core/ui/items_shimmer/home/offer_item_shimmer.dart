import 'package:flutter/material.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/items_shimmer/base_shimmer.dart';

class HomeAdsItemShimmer extends StatelessWidget {
  final double? width;
  final double? height;

  HomeAdsItemShimmer({this.width = 100, this.height});

  @override
  Widget build(BuildContext context) {
    double widthC = width ?? globalSize.setWidthPercentage(100, context);
    double heightC = height ?? globalSize.setWidthPercentage(50, context);

    return BaseShimmerWidget(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: EdgeMargin.sub,
          horizontal: EdgeMargin.sub,
        ),
        width: widthC,
        height: heightC,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widthC * .03),
            topRight: Radius.circular(widthC * .03),
            bottomRight: Radius.circular(widthC * .03),
            bottomLeft: Radius.circular(widthC * .03),
          ),
          //   shape: BoxShape.circle,
        ),
      ),
    );
  }
}
