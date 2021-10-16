import 'package:flutter/material.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/ui/dailog/soon_dailog.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:ojos_app/features/cart/domin/entities/payment_method_entity.dart';

class ItemPayWidget extends StatefulWidget {
  final PaymentMethodEntity? item;
  final double? width;
  final bool? isSelect;
  final Function(PaymentMethodEntity)? onSelect;
  const ItemPayWidget({this.item, this.onSelect, this.width, this.isSelect});
  @override
  _ItemPayWidgetState createState() => _ItemPayWidgetState();
}

class _ItemPayWidgetState extends State<ItemPayWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.item!.id != null && widget.item!.id != 8
        ? Container(
            padding: const EdgeInsets.fromLTRB(
                EdgeMargin.min, 4.0, EdgeMargin.min, 4.0),
            width: widget.width,
            height: 65,
            child: InkWell(
              onTap: () {
                /// فقط عند الاستلام شغالة
                /// id ==8  عند الاستلام
                if (widget.item!.id != null && widget.item!.id != 8) {
                  showDialog(
                    context: context,
                    builder: (ctx) => SoonDialog(),
                  );
                } else {
                  if (widget.onSelect != null) {
                    widget.onSelect!(widget.item!);
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: globalColor.white.withOpacity(0.5),
                  borderRadius: BorderRadius.all(Radius.circular(12.w)),
                  border: Border.all(
                      color: globalColor.grey.withOpacity(0.3), width: 0.5),
                ),
                padding: const EdgeInsets.fromLTRB(
                    EdgeMargin.min, 8.0, EdgeMargin.min, 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: globalColor.white,
                                  borderRadius: BorderRadius.circular(12.0.w),
                                  border: Border.all(
                                      width: .5,
                                      color:
                                          globalColor.grey.withOpacity(0.3))),
                              child: Padding(
                                padding: const EdgeInsets.all(EdgeMargin.sub),
                                child: FittedBox(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 2.h,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: widget.isSelect!
                                                ? globalColor.primaryColor
                                                : globalColor.transparent,
                                            borderRadius:
                                                BorderRadius.circular(14.0),
                                            border: Border.all(
                                                width:
                                                    widget.isSelect! ? 0.5 : 0,
                                                color: widget.isSelect!
                                                    ? globalColor.primaryColor
                                                        .withOpacity(0.3)
                                                    : globalColor.transparent)),
                                        child: CircleAvatar(
                                          child: widget.isSelect!
                                              ? Icon(
                                                  Icons.check,
                                                  color: globalColor.black,
                                                  size: 12,
                                                )
                                              : Container(),
                                          radius: 10,
                                          backgroundColor: widget.isSelect!
                                              ? globalColor.goldColor
                                              : globalColor.grey
                                                  .withOpacity(0.3),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.h,
                                      ),
                                      Text(
                                        Translations.of(context)
                                            .translate('choose'),
                                        style: textStyle.minTSBasic
                                            .copyWith(color: globalColor.black),
                                      ),
                                      SizedBox(
                                        width: 5.h,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            HorizontalPadding(
                              percentage: 1.0,
                            ),
                            Container(
                              child: Text(
                                widget.item!.name,
                                style: textStyle.smallTSBasic.copyWith(
                                    color: globalColor.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: ImageCacheWidget(
                        imageUrl: widget.item!.image,
                        imageBorderRadius: 0,
                        boxFit: BoxFit.fill,
                        imageWidth: 55,
                        imageHeight: 46,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
