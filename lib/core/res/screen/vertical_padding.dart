import 'package:flutter/material.dart';

import 'screen_helper.dart';

class VerticalPadding extends StatelessWidget {
  final double percentage;

  const VerticalPadding({Key? key, this.percentage = 1.5}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: ScreensHelper.fromHeight(percentage));
  }
}
