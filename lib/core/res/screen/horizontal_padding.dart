import 'package:flutter/material.dart';

import 'screen_helper.dart';

class HorizontalPadding extends StatelessWidget {
  final double percentage;

  const HorizontalPadding({Key? key, required this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: ScreensHelper.fromWidth(percentage));
  }
}
