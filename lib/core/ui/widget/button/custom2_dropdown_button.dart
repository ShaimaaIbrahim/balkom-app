import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';

class Custom2Dropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final bool isEnabled;
  final String hint;
  final DropdownButtonBuilder selectedItemBuilder;
  final double borderRadius;
  final bool hideBorder;
  final bool hideIcon;
  final bool isExpanded;
  final TextStyle? labelStyle;
  final Color? backgroundColor;

  Custom2Dropdown({
    Key? key,
    required this.dropdownMenuItemList,
    required this.onChanged,
    required this.value,
    required this.selectedItemBuilder,
    this.isEnabled = true,
    this.hideBorder = false,
    this.hideIcon = false,
    this.isExpanded = true,
    this.borderRadius = 0.0,
    this.labelStyle,
    this.backgroundColor,
    this.hint = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child: Container(
        // padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        //     border: !hideBorder ? Border.all(
        //       color: globalColor.black,
        //       style: BorderStyle.solid,
        //       width: 1.sp,
        //     ) : null,
        //     color: isEnabled ? Colors.white : Colors.grey.withAlpha(100)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: isExpanded,
            dropdownColor: globalColor.white,
            // itemHeight: 50.0,

            style: labelStyle ??
                textStyle.smallTSBasic.copyWith(
                    color: globalColor.black,
                    decorationThickness: 0,
                    height: ScreenUtil().setHeight(1)),
            icon: !hideIcon
                ? Icon(
                    Icons.keyboard_arrow_down,
                    color: globalColor.globalDarkGrey,
                  )
                : Container(),
            items: dropdownMenuItemList,
            onChanged: onChanged,
            iconSize: hideIcon ? 0 : 15,
            selectedItemBuilder: selectedItemBuilder,
            elevation: 2,
            hint: Container(
              padding: EdgeInsets.only(
                  left: EdgeMargin.small, right: EdgeMargin.small),
              child: Center(
                child: Text(
                  '$hint',
                  style:
                      textStyle.smallTSBasic.copyWith(color: globalColor.grey),
                ),
              ),
            ),

            value: value,
          ),
        ),
      ),
    );
  }
}
