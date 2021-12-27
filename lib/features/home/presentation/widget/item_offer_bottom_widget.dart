import 'package:flutter/material.dart';
import 'package:ojos_app/core/entities/offer_item_entity.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_size.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/presentation/args/product_details_args.dart';
import 'package:ojos_app/features/product/presentation/pages/lenses_details_page.dart';
import 'package:ojos_app/features/product/presentation/pages/product_details_page.dart';

class ItemOfferBottomWidget extends StatelessWidget {
  final OfferItemEntity? offerItem;
  final double? width;
  final double? height;

  const ItemOfferBottomWidget({this.offerItem, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

          Get.Get.toNamed(ProductDetailsPage.routeName,
              preventDuplicates: false,
              arguments: ProductDetailsArguments(
                  product: ProductEntity(
                categoryId: null,
                name: offerItem!.name,
                id: offerItem!.productId,
                gender: null,
                discountPrice: null,
                discountTypeInt: null,
                discountType: null,
                type: null,
                frameShape: null,
                price: null,
                description: null,
                availability: null,
                brandId: null,
                productReviews: null,
                brandInfo: null,
                featured: null,
                genderId: null,
                isReview: null,
                hasCouponCode: null,
                isNew: false,
                lensesFree: null,
                image: null,
                colorInfo: null,
                rate: null,
                isGlasses: null,
                sizeModeInfo: null,
                sizeFaceInfo: null,
                shapeFaceInfo: null,
                shapeframeinfo: null,
                shopId: null,
                shopInfo: null,
                typeProduct: null,
                photoInfo: null,
                isFavorite: null,
              )));
      },
      child: Container(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(
            EdgeMargin.small, EdgeMargin.sub, EdgeMargin.small, EdgeMargin.sub),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12.0.w)),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0.w),
              ),
              height: 90.h,
              child: ImageCacheWidget(
                imageUrl: offerItem!.image ?? '',
                imageWidth: width!,
                imageHeight: 90.h,
                boxFit: BoxFit.fill,
                imageBorderRadius: 0.0,
              )),
        ),
      )),
    );
  }
}

class ItemOfferBottomWidget2 extends StatelessWidget {
  final OfferItemEntity? offerItem;
  final double? width;
  final double? height;

  const ItemOfferBottomWidget2({this.offerItem, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    _buildPriceWidget({double? price, String? discountPrice}) {
      return Container(
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              discountPrice != null && discountPrice.isNotEmpty
                  ? Container(
                      child: FittedBox(
                      child: RichText(
                        text: TextSpan(
                          text: " خصم ${discountPrice}",
                          style: textStyle.middleTSBasic.copyWith(
                              fontWeight: FontWeight.bold,
                              color: globalColor.primaryColor),
                          children: <TextSpan>[
                            new TextSpan(
                                text:
                                    ' ${Translations.of(context).translate('rail')}',
                                style: textStyle.smallTSBasic
                                    .copyWith(color: globalColor.black)),
                          ],
                        ),
                      ),
                    ))
                  : Container(),
            ],
          ),
        ),
      );
    }

    return InkWell(
      onTap: () {
          Get.Get.toNamed(ProductDetailsPage.routeName,
              preventDuplicates: false,
              arguments: ProductDetailsArguments(
                  product: ProductEntity(
                categoryId: null,
                name: offerItem!.name,
                id: offerItem!.productId,
                gender: null,
                discountPrice: null,
                discountTypeInt: null,
                discountType: null,
                type: null,
                frameShape: null,
                price: null,
                description: null,
                availability: null,
                brandId: null,
                productReviews: null,
                brandInfo: null,
                featured: null,
                genderId: null,
                isReview: null,
                hasCouponCode: null,
                isNew: false,
                lensesFree: null,
                image: null,
                colorInfo: null,
                rate: null,
                isGlasses: null,
                sizeModeInfo: null,
                sizeFaceInfo: null,
                shapeFaceInfo: null,
                shapeframeinfo: null,
                shopId: null,
                shopInfo: null,
                typeProduct: null,
                photoInfo: null,
                isFavorite: null,
              )));
      },
      child: Container(
          child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12.0.w)),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0.w),
            ),
            height: 90.h,
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
                                padding:
                                    const EdgeInsets.all(EdgeMargin.verySub),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0.w)),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ImageCacheWidget(
                                        imageUrl: offerItem!.image ?? '',
                                        boxFit: BoxFit.fill,
                                        imageHeight: 100,
                                        imageWidth: 100,
                                      ),
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
                                                price: offerItem!.discountPrice!
                                                    .toDouble(),
                                                discountPrice: offerItem!
                                                    .discountPrice
                                                    .toString()),

                                            Container(
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                strutStyle: StrutStyle(
                                                    fontSize: textSize.middle),
                                                maxLines: 2,
                                                text: TextSpan(
                                                    style: textStyle
                                                        .smallTSBasic
                                                        .copyWith(
                                                      color: globalColor.black,
                                                    ),
                                                    text:
                                                        offerItem!.name ?? ''),
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
                    ],
                  )),
            )),
      )),
    );
  }
}
