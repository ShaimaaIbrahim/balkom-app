import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ojos_app/core/appConfig.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/providers/cart_provider.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_size.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/features/product/domin/entities/cart_entity.dart';
import 'package:ojos_app/features/product/presentation/widgets/lens_select_ipd_add_widget.dart';
import 'package:ojos_app/features/product/presentation/widgets/lens_select_size_widget.dart';
import 'package:provider/provider.dart';

class ItemProductCartWidget extends StatefulWidget {
  final CartEntity? item;

  const ItemProductCartWidget({this.item});

  @override
  _ItemProductHomeWidgetState createState() => _ItemProductHomeWidgetState();
}

class _ItemProductHomeWidgetState extends State<ItemProductCartWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = globalSize.setWidthPercentage(95, context);
    double height = globalSize.setHeightPercentage(60, context);

    double priceAfterDiscount = (widget.item!.productEntity!.price ?? 0.0) -
        (widget.item!.productEntity!.discountPrice ?? 0.0);

    return Container(
      // width: width,
      // height: height,
      // color: globalColor.red,
      padding:
          EdgeInsets.only(left: EdgeMargin.subMin, right: EdgeMargin.subMin),
      child: InkWell(
        onTap: () {
          print('click');
          // if(widget.product.isGlasses!=null && widget.product.isGlasses)
          //   Get.Get.toNamed(ProductDetailsPage.routeName,preventDuplicates: false,arguments: ProductDetailsArguments(product: widget.product));
          // else
          //   Get.Get.toNamed(LensesDetailsPage.routeName,preventDuplicates: false,arguments: ProductDetailsArguments(product: widget.product));
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
              child: Container(
                width: width,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(EdgeMargin.verySub),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0.w)),
                              child: Container(
                                width: 110.h,
                                height: 135.h,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    ImageCacheWidget(
                                      imageUrl:
                                          widget.item!.productEntity!.image!,
                                      boxFit: BoxFit.fill,
                                      imageHeight: 110.h,
                                      imageWidth: 110.h,
                                    ),
                                    /*   Positioned(
                                      left: 4.0,
                                      top: 4.0,
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: globalColor.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0.w),
                                                border: Border.all(
                                                    color: globalColor.grey
                                                        .withOpacity(0.3),
                                                    width: 0.5)),
                                            height: 20.h,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: EdgeMargin.sub,
                                                  right: EdgeMargin.sub),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  Text(
                                                    '${appConfig.notNullOrEmpty(widget.item!.productEntity!.rate) ? widget.item!.productEntity!.rate : '-'}',
                                                    style: textStyle.minTSBasic
                                                        .copyWith(
                                                            color: globalColor
                                                                .black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          // Container(
                                          //   decoration: BoxDecoration(
                                          //     color: globalColor.white,
                                          //     borderRadius: BorderRadius.circular(12.0.w),
                                          //     border: Border.all(
                                          //       color: globalColor.grey.withOpacity(0.3),
                                          //       width: 0.5
                                          //     )
                                          //   ),
                                          //   height: 20.h,
                                          //
                                          //   child: Padding(
                                          //     padding:
                                          //     const EdgeInsets.only(left: EdgeMargin.sub, right:EdgeMargin.sub),
                                          //     child: Row(
                                          //       mainAxisAlignment: MainAxisAlignment.center,
                                          //       children: [
                                          //         SizedBox(
                                          //           width: 2.w,
                                          //         ),
                                          //         Text(
                                          //           '${widget.product.price.toString()??'-'}',
                                          //           style: textStyle.minTSBasic.copyWith(
                                          //               color: globalColor.primaryColor,
                                          //               fontWeight: FontWeight.bold),
                                          //         ),Text(
                                          //           '${Translations.of(context).translate('rail')}',
                                          //           style: textStyle.minTSBasic.copyWith(
                                          //               color: globalColor.black,
                                          //               fontWeight: FontWeight.bold),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 4.0,
                                      right: 4.0,
                                      child: widget
                                                  .item!.productEntity!.isNew ??
                                              false
                                          ? Container(
                                              decoration: BoxDecoration(
                                                color: globalColor.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0.w),
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
                                                      width: 1.w,
                                                    ),
                                                    SvgPicture.asset(
                                                      AppAssets.newww,
                                                      width: 10.w,
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Text(
                                                      '${Translations.of(context).translate('new')}',
                                                      style: textStyle
                                                          .minTSBasic
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
                                    ),*/
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(EdgeMargin.sub),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 7,
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  strutStyle: StrutStyle(
                                                      fontSize:
                                                          textSize.middle),
                                                  text: TextSpan(
                                                      style: textStyle
                                                          .smallTSBasic
                                                          .copyWith(
                                                        color:
                                                            globalColor.black,
                                                      ),
                                                      text:
                                                          '${widget.item!.productEntity!.name}'),
                                                ),
                                              ),
                                              VerticalPadding(
                                                percentage: 0.5,
                                              ),
                                              // Container(
                                              //   child: Row(
                                              //     crossAxisAlignment: CrossAxisAlignment.center,
                                              //     children: [
                                              //       Container(
                                              //         width:10.w,
                                              //         height: 10.w,
                                              //         decoration: BoxDecoration(
                                              //             color: globalColor
                                              //                 .goldColor ,
                                              //             shape: BoxShape.circle,
                                              //             border: Border.all(
                                              //                 width: 1.0 ,
                                              //                 color:globalColor
                                              //                     .primaryColor
                                              //             )),
                                              //         child: Icon(
                                              //           MaterialIcons.check,
                                              //           color: globalColor.black,
                                              //           size: 7.w,
                                              //         ),
                                              //       ),
                                              //       Container(
                                              //         padding: const EdgeInsets.only(left: EdgeMargin.sub,right: EdgeMargin.sub),
                                              //         child: RichText(
                                              //           text:  TextSpan(
                                              //             text: appConfig.notNullOrEmpty(widget.item.productEntity.colorInfo?.length.toString())?widget.item.productEntity.colorInfo?.length.toString():'-',
                                              //             style: textStyle.minTSBasic.copyWith(
                                              //                 fontWeight:
                                              //                 FontWeight
                                              //                     .bold,
                                              //                 color: globalColor
                                              //                     .primaryColor),
                                              //             children: <
                                              //                 TextSpan>[
                                              //               new TextSpan(
                                              //                   text: ' ${Translations.of(context).translate('colors_available')}',
                                              //                   style: textStyle.minTSBasic.copyWith(
                                              //                       color: globalColor
                                              //                           .grey)),
                                              //             ],
                                              //           ),
                                              //         ),
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        )),
                                    HorizontalPadding(
                                      percentage: 1.0,
                                    ),
                                    Expanded(
                                        flex: 5,
                                        child: _buildPriceWidget(
                                            price: priceAfterDiscount
                                                .toString() /*??
                                              widget.item!.productEntity.price
                                                  .toString()*/
                                            //discountPrice: widget.item.productEntity.priceAfterDiscount
                                            ))
                                  ],
                                ),
                                VerticalPadding(
                                  percentage: 1.0,
                                ),
                                // widget.item.isGlasses
                                //     ?
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                        flex: 1, child: _buildCounterWidget()),
                                  ],
                                ),
                                // : Container(),
                                VerticalPadding(
                                  percentage: .5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // !widget.item.isGlasses ?
                    //     Column(
                    //       children: [
                    //         _buildLensesSizeForRightEyessWidget(
                    //             context: context,
                    //             width: width,
                    //             height: height,
                    //
                    //             title: Translations.of(context)
                    //                 .translate('lens_size_for_right_eye')),
                    //         _buildLensesSizeForLeftEyessWidget(
                    //             context: context,
                    //             width: width,
                    //             height: height,
                    //             title: Translations.of(context)
                    //                 .translate('lens_size_for_left_eye')),
                    //
                    //         // _buildLensesSizeForEyessWidget(
                    //         //     context: context,
                    //         //     width: width,
                    //         //     height: height,
                    //         //     title: 'test'
                    //         // ),
                    //         _buildEnterDimensionsOfLensesWidget(
                    //             context: context, width: width, height: height),
                    //       ],
                    //     ) :
                    //     widget.item.argsForGlasses!=null?  Column(
                    //       children: [
                    //         _buildSelectLensesTypeWidget(
                    //           context: context,
                    //           width: width,
                    //           height: height,
                    //           title: widget.item.argsForGlasses.type ==TypeOfLensesChoose.Medical ?Translations.of(context).translate('Medical'): Translations.of(context).translate('Zenia')
                    //         ),
                    //
                    //
                    //         // _buildSelectCompanyWidget(
                    //         //     context: context,
                    //         //     width: width,
                    //         //     height: 50.h),
                    //         _buildLensCompanyTitleWidget(context: context,
                    //             width: width, height: height ,brandEntity: widget.item.argsForGlasses.companyLenses
                    //         ),
                    //
                    //         _buildLensesColorWidget(
                    //             context: context,
                    //             width: width,
                    //             height: height,
                    //             color: widget.item.argsForGlasses.colorSelect),
                    //         _buildLensesSizeForRightEyessWidget(
                    //             context: context,
                    //             width: width,
                    //             height: height,
                    //
                    //             title: Translations.of(context)
                    //                 .translate('lens_size_for_right_eye')),
                    //         _buildLensesSizeForLeftEyessWidget(
                    //             context: context,
                    //             width: width,
                    //             height: height,
                    //             title: Translations.of(context)
                    //                 .translate('lens_size_for_left_eye')),
                    //         _buildEnterDimensionsOfLensesWidget(
                    //             context: context, width: width, height: height),
                    //       ],
                    //     ):
                    Container(),
                  ],
                ),
              )),
        ),
      ),
    );
  }

/*  _buildSelectLensesTypeWidget(
      {BuildContext context, double width, double height, String title}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        EdgeMargin.small,
        EdgeMargin.verySub,
        EdgeMargin.small,
        EdgeMargin.verySub,
      ),
      child: Container(
        width: width,
        height: 46.h,
        decoration: BoxDecoration(
            color: globalColor.white,
            borderRadius: BorderRadius.all(Radius.circular(12.w)),
            border: Border.all(
                color: globalColor.grey.withOpacity(0.3), width: 0.5)),
        padding: const EdgeInsets.fromLTRB(
            EdgeMargin.min, EdgeMargin.sub, EdgeMargin.min, EdgeMargin.sub),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                Translations.of(context).translate('type_of_lenses'),
                style: textStyle.smallTSBasic.copyWith(
                    fontWeight: FontWeight.w500, color: globalColor.black),
              ),
            ),
            HorizontalPadding(
              percentage: 3,
            ),
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          color: globalColor.goldColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1.0, color: globalColor.primaryColor)),
                      child: Icon(
                        MaterialIcons.check,
                        color: globalColor.black,
                        size: 14,
                      ),
                    ),
                    HorizontalPadding(
                      percentage: 2,
                    ),
                    Container(
                        padding: const EdgeInsets.only(
                            left: EdgeMargin.sub, right: EdgeMargin.sub),
                        child: Text(
                          title ?? '',
                          style: textStyle.minTSBasic.copyWith(
                              fontWeight: FontWeight.w500,
                              color: globalColor.black),
                        )),
                  ],
                ),
              ),
            ),
            Icon(
              utils.getLang() == 'ar'
                  ? MaterialIcons.keyboard_arrow_left
                  : MaterialIcons.keyboard_arrow_right,
              size: 25.w,
              color: globalColor.black,
            ),
          ],
        ),
      ),
    );
  }

  _buildLensCompanyTitleWidget(
      {BuildContext context,
      double width,
      double height,
      BrandEntity brandEntity}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        EdgeMargin.small,
        EdgeMargin.min,
        EdgeMargin.small,
        EdgeMargin.verySub,
      ),
      child: Container(
        width: width,
        height: 46.h,
        decoration: BoxDecoration(
            color: globalColor.white,
            borderRadius: BorderRadius.all(Radius.circular(12.w)),
            border: Border.all(
                color: globalColor.grey.withOpacity(0.3), width: 0.5)),
        padding: const EdgeInsets.fromLTRB(
            EdgeMargin.min, EdgeMargin.sub, EdgeMargin.min, EdgeMargin.sub),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: Text(
                  Translations.of(context).translate('lens_company'),
                  style: textStyle.smallTSBasic.copyWith(
                      fontWeight: FontWeight.w500, color: globalColor.black),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  child: Text(
                    brandEntity?.name ?? '',
                    style: textStyle.smallTSBasic.copyWith(
                        fontWeight: FontWeight.w500, color: globalColor.black),
                  ),
                ),
                Icon(
                  MaterialIcons.keyboard_arrow_down,
                  size: 25.w,
                  color: globalColor.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildLensesColorWidget(
      {BuildContext context,
      double width,
      double height,
      GeneralItemEntity color}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        EdgeMargin.small,
        EdgeMargin.min,
        EdgeMargin.small,
        EdgeMargin.min,
      ),
      child: Container(
        width: width,
        height: 46.h,
        decoration: BoxDecoration(
            color: globalColor.white,
            borderRadius: BorderRadius.all(Radius.circular(12.w)),
            border: Border.all(
                color: globalColor.grey.withOpacity(0.3), width: 0.5)),
        padding: const EdgeInsets.fromLTRB(
            EdgeMargin.min, EdgeMargin.sub, EdgeMargin.min, EdgeMargin.sub),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: Text(
                  Translations.of(context).translate('the_color_of_the_lens'),
                  style: textStyle.smallTSBasic.copyWith(
                      fontWeight: FontWeight.w500, color: globalColor.black),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                  width: width * .4,
                  height: 35.h,
                  child: ItemColorWidget(
                    color: color,
                  )),
            ),
          ],
        ),
      ),
    );
  }*/

  _buildPriceWidget({required String price}) {
    return Container(
      decoration: BoxDecoration(
          color: globalColor.white,
          borderRadius: BorderRadius.circular(16.0.w),
          border:
              Border.all(width: 0.5, color: globalColor.grey.withOpacity(0.3))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: AlignmentDirectional.center,
              height: 30.h,
              child: Text(
                '${Translations.of(context).translate('rail')}',
                style: textStyle.middleTSBasic.copyWith(
                    fontWeight: FontWeight.bold,
                    color: globalColor.primaryColor),
              )),
          Container(
            height: 1.0,
            color: globalColor.grey.withOpacity(0.3),
          ),
          Container(
              padding: const EdgeInsets.only(
                  top: EdgeMargin.subMin, bottom: EdgeMargin.subMin),
              alignment: AlignmentDirectional.center,
              // height: 30.h,
              child: Text(
                '$price',
                style: textStyle.middleTSBasic.copyWith(
                    fontWeight: FontWeight.bold,
                    color: globalColor.primaryColor),
              )

              // RichText(
              //   textAlign: TextAlign.center,
              //   text:  TextSpan(
              //     text: price??'',
              //     style: textStyle.middleTSBasic.copyWith(
              //         fontWeight:
              //         FontWeight
              //             .bold,
              //         color: globalColor
              //             .primaryColor),
              //     children: <
              //         TextSpan>[
              //       new TextSpan(
              //           text: ' ${Translations.of(context).translate('rail')}',
              //           style: textStyle.smallTSBasic.copyWith(
              //               color: globalColor
              //                   .black)),
              //     ],
              //   ),
              // )
              ),
        ],
      ),
    );
  }

  _buildCounterWidget() {
    return Consumer<CartProvider>(builder: (context, cartProvider, child) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Text(
              '${Translations.of(context).translate('number_of_glasses')}',
              style: textStyle.minTSBasic.copyWith(
                  fontWeight: FontWeight.bold, color: globalColor.black),
            )),
            Container(
              decoration: BoxDecoration(
                  color: globalColor.white,
                  borderRadius: BorderRadius.circular(16.0.w),
                  border: Border.all(
                      width: 0.5, color: globalColor.grey.withOpacity(0.3))),
              padding: const EdgeInsets.fromLTRB(
                EdgeMargin.verySub,
                EdgeMargin.subMin,
                EdgeMargin.verySub,
                EdgeMargin.subMin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        cartProvider
                            .decreaseItemCount(widget.item!.productEntity!.id);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: globalColor.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 0.5,
                                  color: globalColor.grey.withOpacity(0.3))),
                          // padding: const EdgeInsets.all(EdgeMargin.min),
                          width: 25.w,
                          height: 25.w,
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              color: globalColor.black,
                              size: 18.w,
                            ),
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          '${widget.item!.count}',
                          style: textStyle.bigTSBasic.copyWith(
                              fontWeight: FontWeight.bold,
                              color: globalColor.black),
                        )),
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        cartProvider
                            .increaseItemCount(widget.item!.productEntity!.id);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: globalColor.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 0.5,
                                  color: globalColor.grey.withOpacity(0.3))),
                          width: 25.w,
                          height: 25.w,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: globalColor.black,
                              size: 18.w,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
/*

  _buildLensesSizeForRightEyessWidget(
      {BuildContext context, double width, double height, String title}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        EdgeMargin.small,
        EdgeMargin.min,
        EdgeMargin.small,
        EdgeMargin.min,
      ),
      child: Container(
        width: width,
        padding:
            const EdgeInsets.fromLTRB(0.0, EdgeMargin.sub, 0.0, EdgeMargin.sub),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                title ?? '',
                style: textStyle.middleTSBasic.copyWith(
                  color: globalColor.black,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            VerticalPadding(
              percentage: 1.0,
            ),
            LensSelectSizeWidget(
              onSelected: (lensesSelected) {
                _selectedForRightEye = lensesSelected;
                if (mounted) {
                  setState(() {});
                }
                print('lensesSelected is $lensesSelected');
              },
              width: width,
              defaultValue: _selectedForRightEye,
            )
          ],
        ),
      ),
    );
  }
*/

  /*_buildLensesSizeForLeftEyessWidget({
    BuildContext context,
    double width,
    double height,
    String title,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        EdgeMargin.small,
        EdgeMargin.min,
        EdgeMargin.small,
        EdgeMargin.min,
      ),
      child: Container(
        width: width,
        padding:
            const EdgeInsets.fromLTRB(0.0, EdgeMargin.sub, 0.0, EdgeMargin.sub),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                title ?? '',
                style: textStyle.middleTSBasic.copyWith(
                  color: globalColor.black,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            VerticalPadding(
              percentage: 1.0,
            ),
            LensSelectSizeWidget(
              onSelected: (lensesSelected) {
                _selectedForLeftEye = lensesSelected;
                if (mounted) {
                  setState(() {});
                }
                print('lensesSelected is $lensesSelected');
              },
              width: width,
              defaultValue: _selectedForLeftEye!,
            )
          ],
        ),
      ),
    );
  }

  _buildEnterDimensionsOfLensesWidget(
      {BuildContext context, double width, double height}) {
    return Container(
      width: width,
      padding:
          const EdgeInsets.fromLTRB(0.0, EdgeMargin.sub, 0.0, EdgeMargin.sub),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(
                EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      Translations.of(context).translate('enter_the_sizes') ??
                          '',
                      style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(
                EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
            child: LensSelectIpdAddWidget(
              onSelected: (lensesSelected) {
                _selectedForAddIPD = lensesSelected;
                if (mounted) {
                  setState(() {});
                }
                print('lensesSelected is $lensesSelected');
              },
              width: width,
            ),
          ),
          // Container(
          //   child: Row(
          //     children: [
          //       Expanded(
          //           flex: 1,
          //           child: Padding(
          //             padding: const EdgeInsets.all(EdgeMargin.subSubMin),
          //             child: Container(
          //               child: BorderFormField(
          //                 controller: addEditingController,
          //                 validator: (value) {
          //                   return BaseValidator.validateValue(
          //                     context,
          //                     value,
          //                     [],
          //                     _addValidation,
          //                   );
          //                 },
          //                 hintText: 'ADD',
          //                 hintStyle: textStyle.smallTSBasic.copyWith(
          //                     color: globalColor.grey,
          //                     fontWeight: FontWeight.bold),
          //                 style: textStyle.smallTSBasic.copyWith(
          //                     color: globalColor.black,
          //                     fontWeight: FontWeight.bold),
          //                 filled: false,
          //                 keyboardType: TextInputType.number,
          //                 borderRadius: 12.w,
          //                 onChanged: (value) {
          //                   setState(() {
          //                     _addValidation = true;
          //                     _add = value;
          //                   });
          //                 },
          //                 textAlign: TextAlign.center,
          //                 borderColor: globalColor.grey.withOpacity(0.3),
          //                 textInputAction: TextInputAction.next,
          //                 onFieldSubmitted: (_) {
          //                   FocusScope.of(context).nextFocus();
          //                 },
          //               ),
          //             ),
          //           )),
          //       HorizontalPadding(
          //         percentage: 0.5,
          //       ),
          //       Expanded(
          //         flex: 1,
          //         child: Padding(
          //           padding: const EdgeInsets.all(EdgeMargin.subSubMin),
          //           child: Container(
          //             child: BorderFormField(
          //               controller: ipdEditingController,
          //               validator: (value) {
          //                 return BaseValidator.validateValue(
          //                   context,
          //                   value,
          //                   [],
          //                   _ipdWidthValidation,
          //                 );
          //               },
          //               hintText: 'IPD',
          //               hintStyle: textStyle.smallTSBasic.copyWith(
          //                   color: globalColor.grey,
          //                   fontWeight: FontWeight.bold),
          //               style: textStyle.smallTSBasic.copyWith(
          //                   color: globalColor.black,
          //                   fontWeight: FontWeight.bold),
          //               filled: false,
          //               keyboardType: TextInputType.number,
          //               borderRadius: 12.w,
          //               onChanged: (value) {
          //                 setState(() {
          //                   _ipdWidthValidation = true;
          //                   _ipd = value;
          //                 });
          //               },
          //               textAlign: TextAlign.center,
          //               borderColor: globalColor.grey.withOpacity(0.3),
          //               textInputAction: TextInputAction.next,
          //               onFieldSubmitted: (_) {
          //                 FocusScope.of(context).nextFocus();
          //               },
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }*/
}
