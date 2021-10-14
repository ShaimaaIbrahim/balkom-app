import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojos_app/core/entities/extra_glasses_item_entity.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/utils.dart';

class ItemSizeFilter extends StatefulWidget {
  final ExtraGlassesItemEntity? item;
  final double? width;
  final Function(ExtraGlassesItemEntity, bool)? onSelect;
  const ItemSizeFilter({this.item, this.onSelect, this.width});
  @override
  _ItemColorFilterState createState() => _ItemColorFilterState();
}

class _ItemColorFilterState extends State<ItemSizeFilter> {
  bool _isSelect = false;
  @override
  Widget build(BuildContext context) {
    double sizeIcon;
    if (widget.item!.value == '40-48') {
      sizeIcon = 42.w;
    } else if (widget.item!.value == '49-54') {
      sizeIcon = 55.w;
    } else if (widget.item!.value == '55-58') {
      sizeIcon = 65.w;
    } else if (widget.item!.value == 'above 58') {
      sizeIcon = 80.w;
    } else {
      sizeIcon = 42.w;
    }
    return Container(
      padding:
          const EdgeInsets.fromLTRB(EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
      width: widget.width,
      height: 46.h,
      child: InkWell(
        onTap: () {
          if (mounted) {
            setState(() {
              _isSelect = !_isSelect;
              if (widget.onSelect != null) {
                widget.onSelect!(widget.item!, _isSelect);
              }
            });
          }
        },
        child: Container(
          child: Row(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(
                    color: globalColor.white.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        bottomRight: utils.getLang() == 'ar'
                            ? Radius.circular(10.w)
                            : Radius.circular(0.0),
                        topRight: utils.getLang() == 'ar'
                            ? Radius.circular(10.w)
                            : Radius.circular(0.0),
                        bottomLeft: utils.getLang() == 'ar'
                            ? Radius.circular(0.0)
                            : Radius.circular(10.w),
                        topLeft: utils.getLang() == 'ar'
                            ? Radius.circular(0.0)
                            : Radius.circular(10.w)),
                    border: Border.all(
                        color: globalColor.grey.withOpacity(0.3), width: 0.5),
                  ),
                  height: 46.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HorizontalPadding(
                        percentage: 1.0,
                      ),
                      Container(
                        width: 25.w,
                        height: 25.w,
                        decoration: BoxDecoration(
                            color: _isSelect
                                ? globalColor.primaryColor
                                : globalColor.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 0.5,
                                color: _isSelect
                                    ? globalColor.primaryColor.withOpacity(0.3)
                                    : globalColor.grey.withOpacity(0.3))),
                        child: Center(
                          child: CircleAvatar(
                            child: _isSelect
                                ? Icon(
                                    Icons.check,
                                    color: globalColor.black,
                                    size: 12,
                                  )
                                : Container(),
                            radius: _isSelect ? 15.w : 9.w,
                            backgroundColor: _isSelect
                                ? globalColor.goldColor
                                : globalColor.grey.withOpacity(0.3),
                          ),
                        ),
                      ),
                      HorizontalPadding(
                        percentage: 1.0,
                      ),
                      Container(
                        child: Text(
                          widget.item!.name ?? '',
                          style: textStyle.smallTSBasic.copyWith(
                              color: globalColor.black,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: globalColor.white.withOpacity(0.5),
                    border: Border(
                      top: BorderSide(
                          color: globalColor.grey.withOpacity(0.3), width: 0.5),
                      bottom: BorderSide(
                          color: globalColor.grey.withOpacity(0.3), width: 0.5),
                    ),
                  ),
                  height: 46.h,
                  alignment: AlignmentDirectional.center,
                  //color: globalColor.white,
                  child: Text(
                    widget.item!.value ?? '',
                    style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.grey.withOpacity(0.8),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                    color: globalColor.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                        bottomRight: utils.getLang() == 'ar'
                            ? Radius.circular(0.0)
                            : Radius.circular(10.w),
                        topRight: utils.getLang() == 'ar'
                            ? Radius.circular(0.0)
                            : Radius.circular(10.w),
                        bottomLeft: utils.getLang() == 'ar'
                            ? Radius.circular(10.w)
                            : Radius.circular(0.0),
                        topLeft: utils.getLang() == 'ar'
                            ? Radius.circular(10.w)
                            : Radius.circular(0.0)),
                    border: Border.all(
                        color: globalColor.grey.withOpacity(0.3), width: 0.5),
                  ),
                  height: 46.h,
                  child: SvgPicture.asset(
                    AppAssets.glasses_svg,
                    width: sizeIcon,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
