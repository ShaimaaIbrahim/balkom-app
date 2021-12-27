import 'package:flutter/material.dart';
import 'package:ojos_app/core/entities/offer_item_entity.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/presentation/args/product_details_args.dart';
import 'package:ojos_app/features/product/presentation/pages/lenses_details_page.dart';
import 'package:ojos_app/features/product/presentation/pages/product_details_page.dart';

class ItemOfferMiddle1Widget extends StatelessWidget {
  final OfferItemEntity? offerItem;
  final double? width;
  final double? height;
  const ItemOfferMiddle1Widget({this.offerItem, this.width, this.height});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
          Get.Get.toNamed(ProductDetailsPage.routeName,
              preventDuplicates: false,
              arguments: ProductDetailsArguments(
                  product: ProductEntity(
                categoryId: 1,
                name: offerItem!.name,
                id: offerItem!.productId == 0 ? 1 : offerItem!.productId,
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
        padding: const EdgeInsets.fromLTRB(EdgeMargin.small, EdgeMargin.verySub,
            EdgeMargin.small, EdgeMargin.verySub),
        child: Container(
          width: width,
          height: 90.h,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(width! * .04)),
            child: Stack(
              children: [
                Container(
                  width: width,
                  height: height! * .25,
                  child: ImageCacheWidget(
                    imageUrl: offerItem!.image!,
                    imageWidth: width!,
                    imageHeight: 90.h,
                    boxFit: BoxFit.cover,
                    imageBorderRadius: 0.0,
                  ),
                ),
                // Align(
                //   alignment: AlignmentDirectional.centerEnd,
                //   child: Diagonal(
                //     clipHeight: 70.0,
                //     axis: Axis.vertical,
                //     position: DiagonalPosition.TOP_RIGHT,
                //     child: Container(
                //       width: 154.86.w,
                //       height: height * .25,
                //       color: globalColor.primaryColor,
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.end,
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(
                //                 left: 20, right: 10, top: 5),
                //             child: Text(
                //               Translations.of(context).translate('discount'),
                //               style: textStyle.lagerTSBasic
                //                   .copyWith(color: globalColor.white),
                //             ),
                //           ),
                //           offerItem.discountTypeInt!=null && offerItem.discountTypeInt ==1 ?
                //           Container(
                //             padding: const EdgeInsets.only(left: 20),
                //             child: RichText(
                //               text: new TextSpan(
                //                 text: '99',
                //                 style: textStyle.lagerTSBasic.copyWith(
                //                     fontWeight: FontWeight.bold,
                //                     height: .8,
                //                     color: globalColor.goldColor),
                //                 children: <TextSpan>[
                //                   new TextSpan(
                //                       text: Translations.of(context)
                //                           .translate('rail'),
                //                       style: textStyle.smallTSBasic
                //                           .copyWith(color: globalColor.white)),
                //                 ],
                //               ),
                //             ),
                //           ) :
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
                //                     text:'${offerItem.discountPrice??''}',
                //                     style: textStyle
                //                         .lagerTSBasic
                //                         .copyWith(
                //                         fontWeight:
                //                         FontWeight
                //                             .bold,
                //                         height: .8,
                //                         color: globalColor
                //                             .goldColor),)
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
