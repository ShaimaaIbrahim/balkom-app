import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_size.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/utils.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/features/cart/presentation/pages/order_products.dart';
import 'package:ojos_app/features/cart/presentation/pages/retrieve_page.dart';
import 'package:ojos_app/features/order/domain/entities/order_item_entity.dart';
import 'package:ojos_app/features/order/domain/entities/pop_result.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/presentation/pages/lenses_details_page.dart';
import 'package:ojos_app/features/product/presentation/pages/product_details_page.dart';
import 'package:ojos_app/features/product/presentation/args/product_details_args.dart';
import 'dart:math' as math;

class ItemProductOrderWidget extends StatefulWidget {
  final OrderItemEntity? product;
  final int? orderId;
  final double? width;
  final double? height;

  // final double height;
  const ItemProductOrderWidget({this.product, this.width, required this.height, required this.orderId});

  @override
  _ItemProductOrderWidgetState createState() => _ItemProductOrderWidgetState();
}

class _ItemProductOrderWidgetState extends State<ItemProductOrderWidget> {
  @override
  Widget build(BuildContext context) {
    double width = widget.width ?? globalSize.setWidthPercentage(43, context);
    double height =
        widget.height ?? globalSize.setHeightPercentage(60, context);

    double discountPrice =
        (widget.product!.product!.price ?? 0.0) - (widget.product!.product!.discountPrice ?? 0.0);

    return Container(
      // width: width,
      // height: height,
      // color: globalColor.red,
      padding: EdgeInsets.only(
          left: utils.getLang() == 'ar' ? 0.0 : EdgeMargin.verySub,
          right: utils.getLang() == 'ar' ? EdgeMargin.verySub : 0.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(
            PopWithResults(
              fromPage: OrderProducts.routeName,
              toPage: RetrievePage.routeName,
              results: {"product_id": widget.product!.id, "order_id" : widget.orderId},

            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0.w))),
          child: Container(
              decoration: BoxDecoration(
                color: globalColor.white,
                borderRadius: BorderRadius.circular(12.0.w),
              ),
              //   padding: const EdgeInsets.all(1.0),
              width: width,
              height: height,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(EdgeMargin.verySub),
                            child: ClipRRect(
                              borderRadius:
                              BorderRadius.all(Radius.circular(12.0.w)),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ImageCacheWidget(
                                    imageUrl: widget.product!.product!.image ?? '',
                                    boxFit: BoxFit.fill,
                                    imageHeight: 100,
                                    imageWidth: 100,
                                  ),
                                  Positioned(
                                    bottom: 0.0,
                                    right: 4.0,
                                    child: widget.product!.product!.isNew != null &&
                                        widget.product!.product!.isNew!
                                        ? Container(
                                      decoration: BoxDecoration(
                                        color: globalColor.primaryColor,
                                        borderRadius:
                                        BorderRadius.circular(12.0.w),
                                      ),
                                      height: 22.h,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: EdgeMargin.sub,
                                            right: EdgeMargin.sub),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            SvgPicture.asset(
                                              AppAssets.newww,
                                              width: 12.w,
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            Text(
                                              '${Translations.of(context).translate('new')}',
                                              style: textStyle
                                                  .smallTSBasic
                                                  .copyWith(
                                                  color: globalColor
                                                      .white),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(
                                      child: Text(''),
                                    ),
                                  ),
                                  // Positioned(
                                  //   bottom: 0.0,
                                  //   left: 4.0,
                                  //   child: widget.product!.product!.type != 1
                                  //       ? Container(
                                  //     decoration: BoxDecoration(
                                  //         color: globalColor.white,
                                  //         borderRadius:
                                  //         BorderRadius.circular(
                                  //             12.0.w),
                                  //         border: Border.all(
                                  //             color: globalColor.grey
                                  //                 .withOpacity(0.3),
                                  //             width: 0.5)),
                                  //     padding: const EdgeInsets.fromLTRB(
                                  //         EdgeMargin.verySub,
                                  //         EdgeMargin.verySub,
                                  //         EdgeMargin.verySub,
                                  //         EdgeMargin.verySub),
                                  //     constraints: BoxConstraints(
                                  //         maxWidth: width * .5),
                                  //     child: Text(
                                  //       widget.product.product!.isGlasses !=
                                  //           null &&
                                  //           (widget.product.product!.isGlasses ??
                                  //               false)
                                  //           ? '${Translations.of(context).translate('medical_glasses')}'
                                  //           : '${Translations.of(context).translate('medical_lenses')}',
                                  //       style: textStyle.minTSBasic
                                  //           .copyWith(
                                  //           color: globalColor.black),
                                  //     ),
                                  //   )
                                  //       : Container(),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(EdgeMargin.sub),
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Container(
                                    width: width,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        _buildPriceWidget(
                                            width: width,
                                            price: widget.product!.product!.price,
                                            discountPrice:
                                            discountPrice.toString()),
                                        VerticalPadding(
                                          percentage: 0.5,
                                        ),
                                        Container(
                                          child: RichText(
                                            overflow: TextOverflow.ellipsis,
                                            strutStyle: StrutStyle(
                                                fontSize: textSize.middle),
                                            maxLines: 2,
                                            text: TextSpan(
                                                style: textStyle.smallTSBasic
                                                    .copyWith(
                                                  color: globalColor.black,
                                                ),
                                                text:
                                                widget.product!.product!.name ?? ''),
                                          ),
                                        ),

                                        // Container(
                                        //   child: FittedBox(
                                        //     child: Row(
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.center,
                                        //       children: [
                                        //         Container(
                                        //           width: 12.w,
                                        //           height: 12.w,
                                        //           decoration: BoxDecoration(
                                        //               color: globalColor.goldColor,
                                        //               shape: BoxShape.circle,
                                        //               border: Border.all(
                                        //                   width: 1.0,
                                        //                   color: globalColor
                                        //                       .primaryColor)),
                                        //           child: Icon(
                                        //             MaterialIcons.check,
                                        //             color: globalColor.black,
                                        //             size: 10.w,
                                        //           ),
                                        //         ),
                                        //         Container(
                                        //           padding: const EdgeInsets.only(
                                        //               left: EdgeMargin.sub,
                                        //               right: EdgeMargin.sub),
                                        //           child: RichText(
                                        //             text: TextSpan(
                                        //               text: appConfig
                                        //                       .notNullOrEmpty(widget
                                        //                           .product
                                        //                           .colorInfo
                                        //                           ?.length
                                        //                           .toString())
                                        //                   ? widget
                                        //                       .product
                                        //                       .colorInfo
                                        //                       ?.length
                                        //                       .toString()
                                        //                   : '-',
                                        //               style: textStyle.minTSBasic
                                        //                   .copyWith(
                                        //                       fontWeight:
                                        //                           FontWeight.bold,
                                        //                       color: globalColor
                                        //                           .primaryColor),
                                        //               children: <TextSpan>[
                                        //                 new TextSpan(
                                        //                     text:
                                        //                         ' ${Translations.of(context).translate('colors_available')}',
                                        //                     style: textStyle
                                        //                         .minTSBasic
                                        //                         .copyWith(
                                        //                             color:
                                        //                                 globalColor
                                        //                                     .grey)),
                                        //               ],
                                        //             ),
                                        //           ),
                                        //         )
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  // HorizontalPadding(
                                  //   percentage: 1.0,
                                  // ),
                                  // _buildPriceWidget(
                                  //     width: width * 0.35,
                                  //     price: widget.product.price,
                                  //     discountPrice:
                                  //         widget.product.priceAfterDiscount)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Column(
                  //   children: [
                  //     Expanded(
                  //       flex:7,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.end,
                  //         crossAxisAlignment: CrossAxisAlignment.end,
                  //         children: [
                  //           widget.product.type!=1 ?
                  //           Container(
                  //             decoration: BoxDecoration(
                  //               color: globalColor.white,
                  //               borderRadius: BorderRadius.circular(12.0.w),
                  //             ),
                  //             padding: const EdgeInsets.fromLTRB(EdgeMargin.verySub, EdgeMargin.verySub, EdgeMargin.verySub, EdgeMargin.verySub),
                  //             constraints: BoxConstraints(maxWidth: width*.5),
                  //             child: Text('عدسات طبية',style: textStyle.minTSBasic.copyWith(
                  //               color: globalColor.black
                  //             ),),
                  //           ) : Container(),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(flex:6,child: Container(),)
                  //   ],
                  // )
                ],
              )),
        ),
      ),
    );
  }

  _buildPriceWidget(
      {required double? price,
        required String? discountPrice,
        required double width}) {
    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          discountPrice != null
              ? Container(
              child: Flexible(
                child: RichText(
                  text: TextSpan(
                    text: '${price.toString()}',
                    style: textStyle.smallTSBasic.copyWith(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                        color: globalColor.grey),
                    children: <TextSpan>[
                      new TextSpan(
                          text:
                          ' ${Translations.of(context).translate('rail')}',
                          style: textStyle.subMinTSBasic
                              .copyWith(color: globalColor.grey)),
                    ],
                  ),
                ),
              ))
              : Container(
              child: Flexible(
                child: RichText(
                  text: TextSpan(
                    text: price.toString(),
                    style: textStyle.smallTSBasic.copyWith(
                        fontWeight: FontWeight.bold,
                        color: globalColor.primaryColor),
                    children: <TextSpan>[
                      new TextSpan(
                          text:
                          ' ${Translations.of(context).translate('rail')}',
                          style: textStyle.subMinTSBasic
                              .copyWith(color: globalColor.black)),
                    ],
                  ),
                ),
              )),
          discountPrice != null && discountPrice.isNotEmpty
              ? Container(
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      discountPrice,
                      style: textStyle.smallTSBasic.copyWith(
                          fontWeight: FontWeight.bold,
                          color: globalColor.primaryColor),
                    ),
                    Text(' ${Translations.of(context).translate('rail')}',
                        style: textStyle.subMinTSBasic
                            .copyWith(color: globalColor.primaryColor)),
                    // RichText(
                    //   text: TextSpan(
                    //     text: discountPrice ?? '',
                    //     style: textStyle.smallTSBasic.copyWith(
                    //         fontWeight: FontWeight.bold,
                    //         color: globalColor.primaryColor),
                    //     children: <TextSpan>[
                    //       new TextSpan(
                    //           text:
                    //               ' ${Translations.of(context).translate('rail')}',
                    //           style: textStyle.subMinTSBasic
                    //               .copyWith(color: globalColor.primaryColor)),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ))
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
