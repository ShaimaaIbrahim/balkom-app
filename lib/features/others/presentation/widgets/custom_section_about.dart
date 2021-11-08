import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';

class CustomSectionAbout extends StatelessWidget {
  final String svg;
  final String? title;
  final String? description;

  const CustomSectionAbout({required this.svg, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    double widthC = globalSize.setWidthPercentage(100, context);
    return Container(
      width: widthC,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(
                  top: EdgeMargin.small,
                  left: EdgeMargin.min,
                  right: EdgeMargin.min,
                  bottom: EdgeMargin.subSubMin),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    svg,
                    width: ScreenUtil().setHeight(15),
                    color: globalColor.primaryColor,
                  ),
                  SizedBox(
                    width: widthC * .02,
                  ),
                  Text(
                    title ?? '',
                    style: textStyle.middleTSBasic
                        .copyWith(color: globalColor.primaryColor),
                  ),
                ],
              )),
          Container(
            color: globalColor.backgroundGreyLight,
            width: widthC,
            child: Container(
                margin: const EdgeInsets.only(
                    top: EdgeMargin.small,
                    left: EdgeMargin.small,
                    right: EdgeMargin.small,
                    bottom: EdgeMargin.min),
                child: Wrap(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          description ?? '',
                          style: textStyle.smallTSBasic
                              .copyWith(color: globalColor.black),
                        ),
                      ],
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
