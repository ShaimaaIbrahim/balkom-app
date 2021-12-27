import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojos_app/core/appConfig.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/utils.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/items_shimmer/base_shimmer.dart';
import 'package:ojos_app/core/ui/items_shimmer/item_general_shimmer.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:ojos_app/core/ui/widget/text/normal_form_field.dart';
import 'package:ojos_app/core/ui/widget/title_with_view_all_widget.dart';
import 'package:ojos_app/core/validators/base_validator.dart';
import 'package:ojos_app/features/product/domin/entities/image_info_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsShimmer extends StatefulWidget {
  final double? width;
  final double? height;
  final ProductEntity? product;

  const ProductDetailsShimmer({
    this.height,
    this.width,
    this.product,
  });

  @override
  _ProductDetailsShimmerState createState() => _ProductDetailsShimmerState();
}

class _ProductDetailsShimmerState extends State<ProductDetailsShimmer> {
  PageController controller =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  var currentPageValue = 0;

  /// frame Height parameters
  bool _frameHeightValidation = false;
  String _frameHeight = '';
  final TextEditingController frameHeightEditingController =
      new TextEditingController();

  /// frame Width parameters
  bool _frameWidthValidation = false;
  String _frameWidth = '';
  final TextEditingController frameWidthEditingController =
      new TextEditingController();

  /// frame Length parameters
  bool _frameLengthValidation = false;
  String _frameLength = '';
  final TextEditingController frameLengthEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = widget.width ?? globalSize.setWidthPercentage(100, context);
    final height =
        widget.height ?? globalSize.setHeightPercentage(100, context);
    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            color: globalColor.white,
            // borderRadius: BorderRadius.all(Radius.circular(12.w))
          ),
          child: Column(
            children: [
              _buildTopWidget(
                  context: context,
                  width: width,
                  height: height,
                  // discountPrice: widget.product!.discountPrice!,
                  // discountType: widget.product!.discountTypeInt!,
                  product: widget.product!),
              _buildTitleAndPriceWidget(
                context: context,
                width: width,
                height: height,
                /*   price: widget.product!.price!,
                  priceAfterDiscount: widget.product!.priceAfterDiscount!,
                  discountPrice: widget.product!.discountPrice!,
                  discountType: widget.product!.discountTypeInt!,
                  name: widget.product!.name,
                  isFree: widget.product!.lensesFree!*/
              ),
              VerticalPadding(
                percentage: 2.0,
              ),
              _divider(),
              _buildSimilarProducts(
                  context: context, width: width, height: height),
              VerticalPadding(
                percentage: 2.5,
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildTopWidget(
      {required BuildContext context,
      required double width,
      required double height,
      // required int discountType,
      // required double? discountPrice,
      required ProductEntity product}) {
    return Container(
      width: width,
      height: 236.h,
      padding: const EdgeInsets.fromLTRB(EdgeMargin.sub, EdgeMargin.verySub,
          EdgeMargin.sub, EdgeMargin.verySub),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        child: Stack(
          children: [
            Stack(
              children: [
                product.photoInfo != null && product.photoInfo!.isNotEmpty
                    ? PageView(
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: product.photoInfo!
                            .map((item) => Stack(
                                  children: [
                                    Container(
                                      width: width,
                                      height: 236.h,
                                      child: ImageCacheWidget(
                                        imageUrl: '',
                                        imageWidth: width,
                                        imageHeight: 236.h,
                                        boxFit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ))
                            .toList(),
                      )
                    : Container(
                        width: width,
                        height: 236.h,
                        child: ImageCacheWidget(
                          imageUrl: product.image ?? '',
                          imageWidth: width,
                          imageHeight: 236.h,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                // Positioned(
                //   bottom: 4.0,
                //   left: 4.0,
                //   child: discountType != null
                //       ? Container(
                //           decoration: BoxDecoration(
                //               color: globalColor.white,
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(12.w)),
                //               border: Border.all(
                //                   color: globalColor.grey.withOpacity(0.3),
                //                   width: 0.5)),
                //           padding: const EdgeInsets.fromLTRB(
                //               EdgeMargin.subSubMin,
                //               EdgeMargin.verySub,
                //               EdgeMargin.subSubMin,
                //               EdgeMargin.verySub),
                //           child: discountType == 1
                //               ? Row(
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   mainAxisSize: MainAxisSize.min,
                //                   children: [
                //                     Text(
                //                       '${discountPrice ?? '-'} ${Translations.of(context).translate('rail')}',
                //                       style: textStyle.smallTSBasic.copyWith(
                //                           fontWeight: FontWeight.bold,
                //                           color: globalColor.primaryColor),
                //                     ),
                //                     Text(
                //                         ' ${Translations.of(context).translate('discount')}',
                //                         style: textStyle.minTSBasic.copyWith(
                //                             color: globalColor.black)),
                //                   ],
                //                 )
                //               : Row(
                //                   mainAxisSize: MainAxisSize.min,
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: [
                //                     Text(
                //                       '${discountPrice ?? '-'} %',
                //                       style: textStyle.smallTSBasic.copyWith(
                //                           fontWeight: FontWeight.bold,
                //                           color: globalColor.primaryColor),
                //                     ),
                //                     Text(
                //                         ' ${Translations.of(context).translate('discount')}',
                //                         style: textStyle.minTSBasic.copyWith(
                //                             color: globalColor.black)),
                //                   ],
                //                 ),
                //         )
                //       : Container(),
                // ),
              ],
            ),
            product.photoInfo != null && product.photoInfo!.isNotEmpty
                ? Positioned(
                    bottom: 10,
                    child: _buildPageIndicator2(
                        width: width, list: product.photoInfo!))
                : Container()
          ],
        ),
      ),
    );
  }

  _buildPageIndicator2(
      {required double width, required List<ImageInfoEntity> list}) {
    return Container(
      alignment: AlignmentDirectional.center,
      width: width,
      child: SmoothPageIndicator(
          controller: controller, //// PageController
          count: list.length,
          effect: WormEffect(
            spacing: 4.0,
            radius: 10.0,
            dotWidth: 10.0,
            dotHeight: 10.0,
            dotColor: Colors.white,
            paintStyle: PaintingStyle.fill,
            strokeWidth: 2,
            activeDotColor: globalColor.primaryColor,
          ), // your preferred effect
          onDotClicked: (index) {}),
    );
  }

  _buildTitleAndPriceWidget({
    required BuildContext context,
    required double width,
    required double height,
    /*    required double price,
      required String priceAfterDiscount,
      required double discountPrice,
      required int discountType,
      required String? name,
      required bool isFree*/
  }) {
    return BaseShimmerWidget(
      child: Container(
        width: width,
        padding:
            const EdgeInsets.fromLTRB(EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  VerticalPadding(
                    percentage: 1.5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: globalColor.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: .5,
                            color: globalColor.grey.withOpacity(0.3))),
                    child: Text(
                      '              ',
                      style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    alignment: AlignmentDirectional.centerStart,
                  ),
                ],
              ),
            ),
            Container(
                //  alignment: AlignmentDirectional.centerEnd,
                padding: const EdgeInsets.fromLTRB(EdgeMargin.verySub,
                    EdgeMargin.sub, EdgeMargin.verySub, EdgeMargin.sub),
                alignment: AlignmentDirectional.centerStart,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: globalColor.white,
                          borderRadius: BorderRadius.all(Radius.circular(12.w)),
                          border: Border.all(
                              color: globalColor.grey.withOpacity(0.3),
                              width: 0.5)),
                      padding: const EdgeInsets.fromLTRB(
                          EdgeMargin.subSubMin,
                          EdgeMargin.verySub,
                          EdgeMargin.subSubMin,
                          EdgeMargin.verySub),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  _buildSimilarProducts(
      {required BuildContext context,
      required double width,
      required double height}) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: EdgeMargin.small, right: EdgeMargin.small),
            child: TitleWithViewAllWidget(
              width: width,
              title: Translations.of(context).translate('similar_products'),
              onClickView: () {},
              strViewAll: Translations.of(context).translate('view_all'),
            ),
          ),
          Container(
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio:
                        globalSize.setWidthPercentage(47, context) /
                            globalSize.setWidthPercentage(60, context),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return ItemGeneralShimmer(
                      height: globalSize.setWidthPercentage(60, context),
                      width: globalSize.setWidthPercentage(47, context),
                    );
                  }))
        ],
      ),
    );
  }

  _divider() {
    return Divider(
      color: globalColor.grey.withOpacity(0.3),
      height: 20.h,
    );
  }

  _buildPriceWidget(
      {required double? price,
      required double? discountPrice,
      required String? priceAfterDiscount}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          discountPrice != null && discountPrice != 0.0
              ? Container(
                  child: FittedBox(
                  child: RichText(
                    text: TextSpan(
                      text: '    ',
                      style: textStyle.middleTSBasic.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                          color: globalColor.grey),
                      children: <TextSpan>[
                        new TextSpan(
                            text:
                                ' ${Translations.of(context).translate('rail')}',
                            style: textStyle.smallTSBasic
                                .copyWith(color: globalColor.grey)),
                      ],
                    ),
                  ),
                ))
              : Container(
                  child: FittedBox(
                  child: RichText(
                    text: TextSpan(
                      text: '    ',
                      style: textStyle.middleTSBasic.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                          color: globalColor.grey),
                      children: <TextSpan>[
                        new TextSpan(
                            text:
                                ' ${Translations.of(context).translate('rail')}',
                            style: textStyle.smallTSBasic
                                .copyWith(color: globalColor.grey)),
                      ],
                    ),
                  ),
                )),
          HorizontalPadding(percentage: 2.5),
          discountPrice != null && discountPrice != 0.0
              ? Container(
                  child: FittedBox(
                  child: RichText(
                    text: TextSpan(
                      text: '       ',
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
    );
  }
}
