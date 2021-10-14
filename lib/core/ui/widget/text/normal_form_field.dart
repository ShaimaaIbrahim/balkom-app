import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_size.dart';
import 'package:ojos_app/core/res/text_style.dart';

import 'global_decorations.dart';

class NormalFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormat;
  final String? label;
  final TextInputType? keyboardType;

  const NormalFormField({
    Key? key,
    this.validator,
    this.inputFormat,
    this.label,
    this.keyboardType,
    this.onChanged,
    this.focusNode,
    this.nextNode,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: textStyle.smallTSBasic.copyWith(color: globalColor.primaryColor),
        cursorColor: globalColor.primaryColor,
        decoration: GlobalDecorations.kNormalFieldInputDecoration
            .copyWith(labelText: label),
        validator: validator,
        inputFormatters: inputFormat,
        keyboardType: keyboardType,
        onChanged: onChanged,
        focusNode: focusNode,
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, focusNode, nextNode);
        });
  }

  _fieldFocusChange(
      BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
    if (currentFocus != null && nextFocus != null) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}

class BorderFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormat;
  final TextInputType? keyboardType;
  final double borderRadius;
  final String? hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final bool? isEnableFocusOnTextField;
  final bool readOnly;
  final bool? filled;
  final TextAlign? textAlign;
  final Function()? onTap;
  final Widget? prefixIcon;
  final Color borderColor;
  final ValueChanged<String>? onFieldSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;

  final InputCounterWidgetBuilder? buildCounter;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Color? fillColor;

  const BorderFormField(
      {Key? key,
      this.validator,
      this.isEnableFocusOnTextField = true,
      this.inputFormat,
      this.controller,
      this.keyboardType,
      this.onChanged,
      this.focusNode,
      this.nextNode,
      this.textInputAction,
      this.onTap,
      this.readOnly = false,
      this.filled = true,
      this.maxLines = 1,
      this.onFieldSubmitted,
      this.fillColor,
      this.prefixIcon,
      required this.borderColor,
      this.style,
      this.hintStyle,
      this.contentPadding,
      this.maxLength,
      this.textAlign,
      this.buildCounter,
      required this.hintText,
      this.borderRadius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        style: style ??
            textStyle.middleTSBasic.copyWith(
                color: borderColor,
                decorationThickness: 0,
                height: ScreenUtil().setHeight(1)),
        cursorColor: borderColor,
        cursorWidth: 1.5,
        buildCounter: buildCounter ?? null,
        maxLength: maxLength ?? null,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: InputDecoration(
            errorStyle: textStyle.smallTSBasic.copyWith(
              color: Colors.red,
              fontSize: textSize.subMin,
            ),
            counterStyle:
                textStyle.smallTSBasic.copyWith(color: globalColor.black),
            contentPadding: contentPadding ??
                EdgeInsets.only(
                    left: EdgeMargin.lager, right: EdgeMargin.lager),
            focusedBorder: generalBoarder(
                borderRadius: borderRadius, borderColor: borderColor),
            enabledBorder: generalBoarder(
                borderRadius: borderRadius, borderColor: borderColor),
            errorBorder: generalBoarder(
                isError: true,
                borderRadius: borderRadius,
                borderColor: borderColor),
            border: generalBoarder(
                borderRadius: borderRadius, borderColor: borderColor),
            focusedErrorBorder: generalBoarder(
                isError: true,
                borderRadius: borderRadius,
                borderColor: borderColor),
            hintText: hintText,
            prefixIcon: prefixIcon ?? null,
            hintStyle: hintStyle ??
                textStyle.smallTSBasic.copyWith(color: globalColor.grey),
            alignLabelWithHint: false,
            labelStyle: textStyle.normalTSBasic,
            fillColor: fillColor ?? globalColor.primaryColor.withOpacity(0.4),
            filled: filled),
        validator: validator,
        enabled: isEnableFocusOnTextField,
        inputFormatters: inputFormat,
        keyboardType: keyboardType,
        onChanged: onChanged,
        focusNode: focusNode,
        maxLines: maxLines,
        readOnly: readOnly,
        textAlign: textAlign ?? TextAlign.start,
        onTap: onTap,
        onFieldSubmitted: onFieldSubmitted != null
            ? onFieldSubmitted
            : (term) {
                _fieldFocusChange(context, focusNode, nextNode);
              });
  }

  // InputBorder generalBoarder({bool isError=false}) {
  //   return OutlineInputBorder(
  //     borderSide: BorderSide(
  //       color: globalColor.blue,
  //       style: BorderStyle.solid,
  //       width: isError? 3.sp: 1.sp,
  //     ),
  //     borderRadius: BorderRadius.all(Radius.circular(
  //         this.borderRadius) //         <--- border radius here
  //     ),
  //   );
  // }

  _fieldFocusChange(
      BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
    if (currentFocus != null && nextFocus != null) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}

class BorderPasswordFormField extends StatefulWidget {
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormat;
  final TextInputType? keyboardType;
  final double borderRadius;
  final String? hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final bool? isEnableFocusOnTextField;
  final bool readOnly;
  final bool? filled;
  final TextAlign? textAlign;
  final Function()? onTap;
  final Widget? prefixIcon;
  final Color borderColor;
  final ValueChanged<String>? onFieldSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;

  final InputCounterWidgetBuilder? buildCounter;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Color? fillColor;

  final Color? iconVisibilityColor;

  const BorderPasswordFormField({
    Key? key,
    this.validator,
    this.isEnableFocusOnTextField = true,
    this.inputFormat,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.focusNode,
    this.nextNode,
    this.textInputAction,
    this.onTap,
    this.readOnly = false,
    this.filled = true,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.fillColor,
    this.prefixIcon,
    required this.borderColor,
    this.style,
    this.hintStyle,
    this.contentPadding,
    this.maxLength,
    this.textAlign,
    this.buildCounter,
    required this.hintText,
    this.borderRadius = 0,
    this.iconVisibilityColor,
  }) : super(key: key);

  @override
  _BorderPasswordFormFieldState createState() =>
      _BorderPasswordFormFieldState();
}

class _BorderPasswordFormFieldState extends State<BorderPasswordFormField> {
  bool _isSecure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        style: widget.style ??
            textStyle.middleTSBasic.copyWith(
                color: widget.borderColor,
                decorationThickness: 0,
                height: ScreenUtil().setHeight(1)),
        cursorColor: widget.borderColor,
        cursorWidth: 1.5,
        maxLength: widget.maxLength ?? null,
        buildCounter: widget.buildCounter ?? null,
        // cursorRadius: Radius.circular(12),

        decoration: InputDecoration(
            errorStyle: textStyle.smallTSBasic.copyWith(
              color: Colors.red,
              fontSize: textSize.subMin,
            ),
            //counter: Text('600 characters left',style: textStyle.smallTSBasic.copyWith(color: globalColor.black),),
            // counterText: 'characters left',
            counterStyle:
                textStyle.smallTSBasic.copyWith(color: globalColor.black),
            contentPadding: widget.contentPadding ??
                EdgeInsets.only(
                    left: EdgeMargin.lager, right: EdgeMargin.lager),
            focusedBorder: generalBoarder(
                borderRadius: widget.borderRadius,
                borderColor: widget.borderColor),
            enabledBorder: generalBoarder(
                borderRadius: widget.borderRadius,
                borderColor: widget.borderColor),
            errorBorder: generalBoarder(
                isError: true,
                borderRadius: widget.borderRadius,
                borderColor: widget.borderColor),
            border: generalBoarder(
                borderRadius: widget.borderRadius,
                borderColor: widget.borderColor),
            focusedErrorBorder: generalBoarder(
                isError: true,
                borderRadius: widget.borderRadius,
                borderColor: widget.borderColor),
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon ?? null,
            suffixIcon: IconButton(
              color: globalColor.textLabel,
              icon: Icon(
                _isSecure ? Icons.visibility : Icons.visibility_off,
                color: widget.iconVisibilityColor ?? globalColor.white,
                size: 15.w,
              ),
              onPressed: () {
                setState(() {
                  _isSecure = !_isSecure;
                });
              },
            ),
            hintStyle: textStyle.smallTSBasic.copyWith(color: globalColor.grey),
            alignLabelWithHint: false,
            labelStyle: textStyle.normalTSBasic,
            fillColor:
                widget.fillColor ?? globalColor.primaryColor.withOpacity(0.4),
            filled: widget.filled),
        validator: widget.validator,
        enabled: widget.isEnableFocusOnTextField,
        inputFormatters: widget.inputFormat,
        obscureText: _isSecure,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
        maxLines: widget.maxLines,
        readOnly: widget.readOnly,
        onTap: widget.onTap != null ? widget.onTap : () {},
        onFieldSubmitted: widget.onFieldSubmitted != null
            ? widget.onFieldSubmitted
            : (term) {
                _fieldFocusChange(context, widget.focusNode, widget.nextNode);
              });
  }

  _fieldFocusChange(
      BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
    if (currentFocus != null && nextFocus != null) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}

InputBorder generalBoarder(
    {bool isError = false, double borderRadius = 15, Color? borderColor}) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: borderColor ?? globalColor.black,
      style: BorderStyle.solid,
      width: isError ? 1.5.sp : 0.5.sp,
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(borderRadius) //         <--- border radius here
        ),
  );
}

class CustomFormField extends StatefulWidget {
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? label;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPasswordField;
  final bool? isNeedPadding;
  final String? initialValue;

  const CustomFormField({
    Key? key,
    this.validator,
    this.initialValue,
    this.inputFormatters,
    required this.isPasswordField,
    this.label,
    this.keyboardType,
    this.onChanged,
    this.textInputAction,
    this.isNeedPadding = true,
    this.focusNode,
    this.nextNode,
  }) : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _isSecure = true;

  @override
  Widget build(BuildContext context) {
    if (!widget.isPasswordField) {
      return Wrap(
        runAlignment: WrapAlignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                child: Container(
//              height: 95,
                  margin: widget.isNeedPadding != null && widget.isNeedPadding!
                      ? EdgeInsets.symmetric(
                          horizontal: EdgeMargin.normal,
                          vertical: EdgeMargin.normal,
                        )
                      : null,
                  child: TextFormField(
                      initialValue: widget.initialValue ?? "",
                      style: textStyle.smallTSBasic,
                      cursorColor: globalColor.primaryColor,
                      focusNode: widget.focusNode,
                      textInputAction: widget.textInputAction,
                      decoration: GlobalDecorations
                          .normalFieldUerManagementNInputDecoration
                          .copyWith(
                        hintText: widget.label,
                      ),
                      validator: widget.validator,
                      inputFormatters: widget.inputFormatters,
                      keyboardType: widget.keyboardType,
                      onChanged: widget.onChanged,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, widget.focusNode, widget.nextNode);
                      }),
                ),
              ),
            ],
          ),
        ],
      );
    }
    return Wrap(
      runAlignment: WrapAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              child: Container(
                //              height: 95,
                child: TextFormField(
                    style: textStyle.smallTSBasic,
                    cursorColor: globalColor.primaryColor,
                    focusNode: widget.focusNode,
                    textInputAction: widget.textInputAction,
                    decoration: GlobalDecorations
                        .normalFieldUerManagementNInputDecoration
                        .copyWith(
                      hintText: widget.label,
                      suffixIcon: IconButton(
                        color: globalColor.black,
                        icon: Icon(
                          _isSecure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isSecure = !_isSecure;
                          });
                        },
                      ),
                    ),
                    validator: widget.validator,
                    inputFormatters: widget.inputFormatters,
                    keyboardType: widget.keyboardType,
                    onChanged: widget.onChanged,
                    obscureText: _isSecure,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, widget.focusNode, widget.nextNode);
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
    if (currentFocus != null && nextFocus != null) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}
