import 'package:flutter/material.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_size.dart';
import 'package:ojos_app/core/res/text_style.dart';

abstract class GlobalDecorations {
  static InputDecoration get kNormalFieldInputDecoration => InputDecoration(
      labelStyle: textStyle.smallTSBasic.copyWith(color: globalColor.textLabel),
      errorStyle: textStyle.smallTSBasic.copyWith(
        color: Colors.red,
        fontSize: textSize.subMin,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: globalColor.enabledBorder),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: globalColor.focusedBorder),
      ));

  static InputDecoration get normalFieldUerManagementNInputDecoration =>
      InputDecoration(
        hintStyle: TextStyle(color: globalColor.grey),
        alignLabelWithHint: true,
        fillColor: globalColor.white,
        filled: true,
        labelStyle:
            textStyle.smallTSBasic.copyWith(color: globalColor.textLabel),
        errorStyle: textStyle.smallTSBasic.copyWith(
          color: Colors.red,
          fontSize: textSize.subMin,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      );

  static InputDecoration get kBorderFieldInputDecoration => InputDecoration(
        alignLabelWithHint: false,
        labelStyle: textStyle.normalTSBasic,
        errorStyle: textStyle.smallTSBasic.copyWith(
          color: Colors.red,
          fontSize: textSize.subMin,
        ),
        filled: false,
      );

  static InputDecoration get underLineVerificationCOdeFieldInputDecoration =>
      InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: globalColor.primaryColor, width: 4),
          borderRadius: BorderRadius.only(),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: globalColor.primaryColor, width: 4),
          borderRadius: BorderRadius.only(),
        ),
        filled: false,
        errorStyle: textStyle.smallTSBasic.copyWith(
          color: Colors.red,
          fontSize: textSize.middle,
        ),
      );
}
