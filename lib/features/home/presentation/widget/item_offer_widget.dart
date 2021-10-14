import 'package:flutter/material.dart';
import 'package:ojos_app/core/entities/offer_item_entity.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/presentation/args/product_details_args.dart';
import 'package:ojos_app/features/product/presentation/pages/lenses_details_page.dart';
import 'package:ojos_app/features/product/presentation/pages/product_details_page.dart';

class ItemOfferWidget extends StatelessWidget {
  final OfferItemEntity? offerItem;
  final double? width;
  const ItemOfferWidget({this.offerItem, this.width});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (offerItem!.is_glasses != null)
          Get.Get.toNamed(ProductDetailsPage.routeName,
              preventDuplicates: false,
              arguments: ProductDetailsArguments(
                  product: ProductEntity(
                categoryId: null,
                name: offerItem!.name,
                id: offerItem!.productId,
                gender: null,
                discountPrice: offerItem!.discountPrice!.toDouble(),
                discountTypeInt: offerItem!.discountTypeInt,
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
                image: offerItem!.image,
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
        else
          Get.Get.toNamed(LensesDetailsPage.routeName,
              preventDuplicates: false,
              arguments: ProductDetailsArguments(
                  product: ProductEntity(
                categoryId: null,
                name: offerItem!.name,
                id: offerItem!.productId,
                gender: null,
                discountPrice: offerItem!.discountPrice!.toDouble(),
                discountTypeInt: offerItem!.discountTypeInt,
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
                image: offerItem!.image,
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
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
            child: Stack(
              children: [
                Container(
                  width: width,
                  height: 184.h,
                  child: ImageCacheWidget(
                    imageUrl: offerItem!.image!,
                    imageWidth: width!,
                    imageHeight: 184.h,
                    boxFit: BoxFit.fill,
                    imageBorderRadius: 0.0,
                  ),
                ),
                // Align(
                //   alignment:
                //   AlignmentDirectional.centerEnd,
                //   child: Diagonal(
                //     clipHeight: 45.0,
                //     axis: Axis.vertical,
                //     position: DiagonalPosition.TOP_RIGHT,
                //     child: Container(
                //       width: width * .3,
                //       height: 184.h,
                //       color: globalColor.primaryColor,
                //       child: Column(
                //         crossAxisAlignment:
                //         CrossAxisAlignment.end,
                //         children: [
                //           Padding(
                //             padding:
                //             const EdgeInsets.only(
                //                 left: 20,
                //                 right: 10,
                //                 top: 5),
                //             child: Text(
                //               Translations.of(context)
                //                   .translate('discount'),
                //               style: textStyle
                //                   .lagerTSBasic
                //                   .copyWith(
                //                   color: globalColor
                //                       .white),
                //             ),
                //           ),
                //           offerItem.discountTypeInt!=null && offerItem.discountTypeInt ==1 ?
                //           Container(
                //             padding:
                //             const EdgeInsets.only(
                //                 left: 20),
                //             child: RichText(
                //               text: TextSpan(
                //                 text: '${offerItem.discountPrice??''}',
                //                 style: textStyle
                //                     .lagerTSBasic
                //                     .copyWith(
                //                     fontWeight:
                //                     FontWeight
                //                         .bold,
                //                     height: .8,
                //                     color: globalColor
                //                         .goldColor),
                //                 children: <TextSpan>[
                //                   new TextSpan(
                //                       text:
                //                       Translations.of(
                //                           context)
                //                           .translate(
                //                           'rail'),
                //                       style: textStyle
                //                           .smallTSBasic
                //                           .copyWith(
                //                           color: globalColor
                //                               .white)),
                //                 ],
                //               ),
                //             ),
                //           )
                //               :
                //           Container(
                //             padding:
                //             const EdgeInsets.only(
                //                 left: 20),
                //             child: RichText(
                //               text: TextSpan(
                //                 text: '%',
                //                 style: textStyle
                //                     .smallTSBasic
                //                     .copyWith(
                //                     color: globalColor
                //                         .white),
                //                 children: <TextSpan>[
                //                   new TextSpan(
                //                       text:'${offerItem.discountPrice??''}',
                //                       style: textStyle
                //                           .lagerTSBasic
                //                           .copyWith(
                //                           fontWeight:
                //                           FontWeight
                //                               .bold,
                //                           height: .8,
                //                           color: globalColor
                //                               .goldColor),)
                //                 ],
                //               ),
                //             ),
                //           )
                //           ,
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
