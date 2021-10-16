import 'package:flutter/material.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';

class LensSelectSizeWidget extends StatefulWidget {
  final Function(LensesSelectedEnum)? onSelected;
  final double? width;
  final double? height;
  final LensesSelectedEnum? defaultValue;

  const LensSelectSizeWidget(
      {this.height, this.width, this.onSelected, this.defaultValue});
  @override
  _LensSelectSizeWidgetState createState() => _LensSelectSizeWidgetState();
}

class _LensSelectSizeWidgetState extends State<LensSelectSizeWidget> {
  LensesSelectedEnum? _selected;

  @override
  void initState() {
    super.initState();
    if (widget.defaultValue != null) {
      _selected = widget.defaultValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _buildItem(
                context: context,
                title: 'AXIS',
                isSelected: _selected == LensesSelectedEnum.AXIS,
                selected: LensesSelectedEnum.AXIS),
          ),
          HorizontalPadding(
            percentage: 1.0,
          ),
          Expanded(
            child: _buildItem(
                context: context,
                title: 'CYI',
                isSelected: _selected == LensesSelectedEnum.CYI,
                selected: LensesSelectedEnum.CYI),
          ),
          HorizontalPadding(
            percentage: 1.0,
          ),
          Expanded(
            child: _buildItem(
                context: context,
                title: 'CPH',
                isSelected: _selected == LensesSelectedEnum.CPH,
                selected: LensesSelectedEnum.CPH),
          ),
        ],
      ),
    );
  }

  _buildItem(
      {required String title,
      required bool isSelected,
      double? width,
      double? height,
      required BuildContext context,
      LensesSelectedEnum? selected}) {
    return InkWell(
      onTap: () {
        if (mounted)
          setState(() {
            _selected = selected!;
          });
        if (widget.onSelected != null) {
          widget.onSelected!(_selected!);
        }
      },
      highlightColor: globalColor.transparent,
      splashColor: globalColor.transparent,
      hoverColor: globalColor.transparent,
      child: Container(
        child: Column(
          children: [
            isSelected
                ? Container(
                    height: 15.h,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 15.h,
                    ),
                  )
                : Container(
                    height: 15.h,
                  ),
            Container(
                decoration: BoxDecoration(
                    color: globalColor.white,
                    borderRadius: BorderRadius.circular(12.0.w),
                    border: Border.all(
                        color: isSelected
                            ? globalColor.primaryColor
                            : globalColor.grey.withOpacity(0.3),
                        width: 0.5)),
                alignment: AlignmentDirectional.center,
                height: 40.h,
                child: Text(
                  title,
                  style: textStyle.middleTSBasic.copyWith(
                      fontWeight: FontWeight.w500, color: globalColor.grey),
                )),
          ],
        ),
      ),
    );
  }
}

enum LensesSelectedEnum { CPH, CYI, AXIS }
