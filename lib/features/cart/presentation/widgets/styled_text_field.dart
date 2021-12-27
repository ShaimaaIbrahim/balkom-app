import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class StyledTextField extends StatelessWidget {
  final keyboardType;
  final isPassword;
  final hint;
  final controller;
  final validator;
  final textAlign;
  final Color? fillColor;
  // final double? borderRadius;
  final double? borderPadding;
  final Widget? suffixWidget;
  final Function? onIconPressed;
  final Function? onChange;
  final hintStyle;
  final int? maxLines;
  final bool? editable;
  final Function? onChanged;
  final BorderRadius? borderRadius;

  StyledTextField({
    this.onChanged,
    this.hintStyle,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.hint,
    this.validator,
    this.onChange,
    this.borderPadding,
    this.textAlign = TextAlign.start,
    this.fillColor,
    this.borderRadius,
    this.suffixWidget,
    this.onIconPressed,
    this.maxLines,
    this.editable = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textAlign,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      //style: textFieldTextStyle,
     // onChanged: onChanged!,
      maxLines: isPassword ? 1 : maxLines,
      decoration: InputDecoration(
        contentPadding:
        EdgeInsets.symmetric(horizontal: borderPadding ?? 10.w, vertical: 5.h),
        hintText: hint,
        enabled: editable!,
        filled: true,
        fillColor: fillColor,
        hintStyle:  hintStyle,
        border: OutlineInputBorder(
          //  borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
       //   borderRadius: borderRadius!,
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        suffixIcon: suffixWidget,
        suffixIconConstraints: BoxConstraints(
          maxHeight: 19.h,
          maxWidth: 19.w,
        ),
      ),
      validator: validator,
    );
  }
}