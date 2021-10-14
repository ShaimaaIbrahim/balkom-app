import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';

PopupMenuEntry<dynamic> menuGeneralItem(
    {required String title, required Function() onClick}) {
  return PopupMenuItem(
    height: ScreenUtil().setHeight(40),
    child: InkWell(
        splashColor: Colors.white,
        highlightColor: Colors.white,
        onTap: onClick,
        child: Container(
          height: ScreenUtil().setHeight(40),
          child: Row(
            children: <Widget>[
              SizedBox(width: 4),
              Container(
                child: Text(title,
                    style: textStyle.smallTSBasic
                        .copyWith(color: globalColor.white)),
              ),
            ],
          ),
        )),
  );
}
