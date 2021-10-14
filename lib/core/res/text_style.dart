import 'package:flutter/material.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_size.dart';

class GlobalTextStyle {
  final hugeTSBasic = TextStyle(
    fontSize: textSize.huge,
    fontWeight: FontWeight.w900,
    color: globalColor.textColor,
  );

  final lagerTSBasic = TextStyle(
    fontSize: textSize.lager,
    color: globalColor.textColor,
  );

  final bigTSBasic = TextStyle(
    fontSize: textSize.big,
  );

  //========================subBig======================================

  final subBigTSBasic = TextStyle(
    fontSize: textSize.subBig,
  );

  //========================normal======================================

  final normalTSBasic = TextStyle(
    fontSize: textSize.normal,
  );

//=========================middle======================================

  final middleTSBasic = TextStyle(
    fontSize: textSize.middle,
  );

  //=========================small======================================

  final smallTSBasic = TextStyle(
    fontSize: textSize.small,
  );

  //========================min======================================
  final minTSBasic = TextStyle(
    fontSize: textSize.min,
  );

  //========================sub-min======================================

  final subMinTSBasic = TextStyle(
    fontSize: textSize.subMin,
  );

  //========================sub-2-min======================================

  final sub2MinTSBasic = TextStyle(
    fontSize: textSize.sub2Min,
  );

//================================================================================//

}

GlobalTextStyle textStyle = GlobalTextStyle();
