import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/utils.dart';

class TitleWithViewAllWidget extends StatelessWidget {
  final double width;
  final String title;
  final String strViewAll;
  final Function() onClickView;
  final TextStyle? style;
  final bool hideSeeAll;

  const TitleWithViewAllWidget(
      {required this.title,
      required this.width,
      required this.onClickView,
      required this.strViewAll,
      this.style,
      this.hideSeeAll = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              title,
              style: style ??
                  textStyle.middleTSBasic.copyWith(
                    color: globalColor.black,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          hideSeeAll
              ? Container()
              : InkWell(
                  onTap: onClickView,
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          Translations.of(context).translate("view_all"),
                          style: textStyle.smallTSBasic.copyWith(
                              color: globalColor.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          utils.getLang() == 'ar'
                              ? Icons.keyboard_arrow_left
                              : Icons.keyboard_arrow_right,
                          color: globalColor.black,
                          size: 17.w,
                        )
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
