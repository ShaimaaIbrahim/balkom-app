import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/ui/widget/text/normal_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserManagementTextFieldWidget extends StatelessWidget {
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormat;
  final TextInputType? keyboardType;
  final double? borderRadius;
  final String? hintText;
  final TextEditingController controller;
  final int? maxLines;
  final bool? isEnableFocusOnTextField;
  final bool? readOnly;
  final Function? onTap;
  final Widget? prefixIcon;
  final Color? borderColor;
  final ValueChanged<String>? onFieldSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;
  final InputCounterWidgetBuilder? buildCounter;
  final TextStyle? style;
  final String? label;
  final bool? isPasswordField;
  const UserManagementTextFieldWidget(
      {this.validator,
      this.isEnableFocusOnTextField = true,
      this.inputFormat,
      required this.controller,
      this.keyboardType,
      this.onChanged,
      this.focusNode,
      this.nextNode,
      this.textInputAction,
      this.onTap,
      this.readOnly = false,
      this.maxLines = 1,
      required this.onFieldSubmitted,
      required this.prefixIcon,
      required this.borderColor,
      this.style,
      this.contentPadding,
      this.maxLength,
      this.buildCounter,
      this.isPasswordField = false,
      required this.hintText,
      required this.label,
      this.borderRadius = 0})
      : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(''),
              ),
              Container(
                child: isPasswordField!
                    ? BorderPasswordFormField(
                        filled: true,
                        // style: textStyle.smallTSBasic.copyWith(
                        //     color: globalColor.black,
                        //     fontWeight: FontWeight.bold),
                        // contentPadding: const EdgeInsets.fromLTRB(
                        //   EdgeMargin.small,
                        //   EdgeMargin.middle,
                        //   EdgeMargin.small,
                        //   EdgeMargin.small,
                        // ),
                        fillColor: globalColor.white,
                        // backgroundColor: globalColor.white,
                        // labelBackgroundColor: globalColor.white,
                        // label:  Translations.of(context).translate('phone_number'),
                        // keyboardType: TextInputType.phone,
                        // borderRadius: width * .02,

                        controller: controller,
                        validator: validator,
                        hintText: '',

                        keyboardType: keyboardType,
                        onChanged: onChanged,
                        focusNode: focusNode,
                        maxLines: maxLines,
                        readOnly: readOnly!,
                        onTap: onTap != null ? onTap!() : () {},
                        borderRadius: borderRadius!,
                        borderColor: Colors.grey,
                        textInputAction: TextInputAction.next,
                        inputFormat: inputFormat,
                        prefixIcon: prefixIcon,
                        style: style,
                        maxLength: maxLength,
                        nextNode: nextNode,
                        onFieldSubmitted: onFieldSubmitted,
                        isEnableFocusOnTextField: isEnableFocusOnTextField,
                        contentPadding: contentPadding,
                        buildCounter: buildCounter,
                      )
                    : BorderFormField(
                        filled: true,
                        fillColor: globalColor.white,
                        controller: controller,
                        validator: validator,
                        hintText: '',
                        keyboardType: keyboardType,
                        onChanged: onChanged,
                        focusNode: focusNode,
                        maxLines: maxLines,
                        readOnly: readOnly!,
                        onTap: onTap != null ? onTap!() : () {},
                        borderRadius: borderRadius!,
                        borderColor: Colors.grey,
                        textInputAction: TextInputAction.next,
                        inputFormat: inputFormat,
                        prefixIcon: prefixIcon,
                        style: style,
                        maxLength: maxLength,
                        nextNode: nextNode,
                        onFieldSubmitted: onFieldSubmitted,
                        isEnableFocusOnTextField: isEnableFocusOnTextField,
                        contentPadding: contentPadding,
                        buildCounter: buildCounter,
                      ),
              ),
            ],
          ),
          Positioned(
            top: 4.h,
            child: Row(
              children: [
                HorizontalPadding(
                  percentage: 4.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.w)),
                      border: Border.all(
                        color: globalColor.grey,
                        width: 0.3,
                      ),
                      color: globalColor.white),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: EdgeMargin.small,
                      right: EdgeMargin.small,
                    ),
                    child: Text(
                      label!,
                      style: textStyle.smallTSBasic
                          .copyWith(color: globalColor.black),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NormalOjosTextFieldWidget extends StatelessWidget {
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormat;
  final TextInputType? keyboardType;
  final double? borderRadius;
  final String? hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final bool? isEnableFocusOnTextField;
  final bool? readOnly;
  final bool? withShadow;
  final bool? filled;
  final Function? onTap;
  final Widget? prefixIcon;
  final Color? borderColor;
  final Color? labelBackgroundColor;
  final Color? backgroundColor;
  final Color? fillColor;
  final Color? iconVisibilityColor;
  final ValueChanged<String>? onFieldSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;
  final InputCounterWidgetBuilder? buildCounter;
  final TextStyle? style;
  final String? label;
  final bool? isPasswordField;

  const NormalOjosTextFieldWidget(
      {this.validator,
      this.isEnableFocusOnTextField = true,
      this.inputFormat,
      this.controller,
      this.keyboardType,
      this.onChanged,
      this.focusNode,
      this.backgroundColor,
      this.labelBackgroundColor,
      this.nextNode,
      this.textInputAction,
      this.onTap,
      this.readOnly = false,
      this.withShadow = false,
      this.filled = false,
      this.maxLines = 1,
      this.onFieldSubmitted,
      this.prefixIcon,
      this.fillColor,
      this.borderColor,
      this.iconVisibilityColor,
      this.style,
      this.contentPadding,
      this.maxLength,
      this.buildCounter,
      this.isPasswordField = false,
      required this.hintText,
      required this.label,
      this.borderRadius = 0})
      : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              Text(''),
              Container(
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  color: globalColor.white,
                  boxShadow: withShadow!
                      ? [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10.0,
                            // has the effect of softening the shadow
                            spreadRadius: 3,
                            //offset: Offset(0,3), // has the effect of extending the shadow
                          ),
                        ]
                      : null,
                ),
                child: isPasswordField!
                    ? BorderPasswordFormField(
                        controller: controller,
                        validator: validator,
                        hintText: '',
                        iconVisibilityColor: iconVisibilityColor,
                        keyboardType: keyboardType,
                        onChanged: onChanged,
                        focusNode: focusNode,
                        maxLines: maxLines,
                        readOnly: readOnly!,
                        onTap: onTap != null ? onTap!() : () {},
                        borderRadius: borderRadius!,
                        borderColor: borderColor!,
                        textInputAction: TextInputAction.next,
                        inputFormat: inputFormat,
                        prefixIcon: prefixIcon,
                        style: style,
                        maxLength: maxLength,
                        filled: filled,
                        nextNode: nextNode,
                        fillColor: fillColor,
                        onFieldSubmitted: onFieldSubmitted,
                        isEnableFocusOnTextField: isEnableFocusOnTextField,
                        contentPadding: contentPadding,
                        buildCounter: buildCounter,
                      )
                    : BorderFormField(
                        controller: controller,
                        validator: validator,
                        hintText: '',
                        keyboardType: keyboardType,
                        onChanged: onChanged,
                        focusNode: focusNode,
                        maxLines: maxLines,
                        readOnly: readOnly!,
                        onTap: onTap != null ? onTap!() : () {},
                        borderRadius: borderRadius!,
                        borderColor: borderColor!,
                        textInputAction: TextInputAction.next,
                        inputFormat: inputFormat,
                        prefixIcon: prefixIcon,
                        style: style,
                        maxLength: maxLength,
                        filled: filled,
                        nextNode: nextNode,
                        fillColor: fillColor,
                        onFieldSubmitted: onFieldSubmitted,
                        isEnableFocusOnTextField: isEnableFocusOnTextField,
                        contentPadding: contentPadding,
                        buildCounter: buildCounter,
                      ),
              ),
            ],
          ),
          Positioned(
            top: 4.h,
            child: Row(
              children: [
                HorizontalPadding(
                  percentage: 4.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.w)),
                      border: Border.all(
                        color: globalColor.grey.withOpacity(0.3),
                        width: 0.5,
                      ),
                      color: backgroundColor ?? globalColor.goldColor),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: EdgeMargin.small,
                      right: EdgeMargin.small,
                    ),
                    child: Text(
                      label!,
                      style: textStyle.smallTSBasic
                          .copyWith(color: globalColor.black),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
