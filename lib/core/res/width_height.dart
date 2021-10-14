import 'package:flutter/material.dart';

class CoreStyle {
  double setWidthPercentage(percentage, context) {
    if (percentage <= 100 || percentage > 0)
      return MediaQuery.of(context).size.width * (percentage / 100);
    else
      return MediaQuery.of(context).size.width;
  }

  double setHeightPercentage(percentage, context) {
    if (percentage <= 100 || percentage > 0)
      return MediaQuery.of(context).size.height * (percentage / 100);
    else
      return MediaQuery.of(context).size.height;
  }
}

CoreStyle globalSize = CoreStyle();
