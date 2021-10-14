import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/items_shimmer/base_shimmer.dart';
import 'package:ojos_app/core/ui/widget/network/network_list.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';
import 'package:ojos_app/features/reviews/domain/usecase/get_my_products.dart';
import 'package:ojos_app/features/reviews/presentation/widgets/item_review_widget.dart';

import '../../../main.dart';

class BuildListMyProductWidget extends StatefulWidget {
  final void Function(List<ProductEntity>)? getProducts;

  final Map<String, String> params;

  final CancelToken cancelToken;

  final double? listWidth;
  final double? listHeight;

  final double itemWidth;
  final double? itemHeight;

  final bool isScrollList;

  final bool isEnableRefresh;
  final bool isEnablePagination;

  //final bool isFromLearningPage;
  final Axis listScrollDirection;

  //final bool isAuth;
  final SliverGridDelegate? gridDelegate;

  const BuildListMyProductWidget({
    required this.params,
    this.getProducts,
    required this.cancelToken,
    this.listWidth = 100,
    this.listHeight = 100,
    this.itemHeight,
    required this.itemWidth,
    this.isScrollList = true,
    this.isEnableRefresh = true,
    this.isEnablePagination = true,
    //  this.isFromLearningPage = false,
    this.listScrollDirection = Axis.vertical,
    this.gridDelegate,
    // this.isAuth = true,
  }) : assert(cancelToken != null);

  @override
  State<StatefulWidget> createState() {
    return _BuildGridProductWidgetState();
  }
}

class _BuildGridProductWidgetState extends State<BuildListMyProductWidget>
    with AutomaticKeepAliveClientMixin<BuildListMyProductWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    double widthC =
        globalSize.setWidthPercentage(widget.listWidth ?? 100, context);
    double heightC =
        globalSize.setHeightPercentage(widget.listHeight ?? 100, context);

    return Container(
      width: widthC,
      height: heightC,
      child: NetworkList<ProductEntity>(
        listScrollDirection: widget.listScrollDirection,
        enablePagination: widget.isEnablePagination,
        enableRefresh: widget.isEnableRefresh,
        isScroll: widget.isScrollList,
        placeHolder: (context) {
          return Center(
            child: Text(
              Translations.of(context).translate('no_product'),
              style: textStyle.smallTSBasic.copyWith(color: globalColor.black),
              textAlign: TextAlign.center,
            ),
          );
        },
        itemBuilder: (context, subject, index) {
          return ItemReviewWidget(
            width: widget.itemWidth,
            review: subject,
          );
        },
        getItems: (subjects) {
          if (widget.getProducts != null) widget.getProducts!(subjects);
        },
        loader: (pageSize, pageIndex) {
          return GetMyProducts(locator<ProductRepository>())(
            GetMyProductsParams(
              filterParams: widget.params,
              cancelToken: widget.cancelToken,
            ),
          );
        },
        loadingWidgetBuilder: (context) {
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              shrinkWrap: true,
              scrollDirection: widget.listScrollDirection,
              itemBuilder: (BuildContext context, int index) {
                return _itemShimmer(width: widget.itemWidth);
              });
        },
      ),
    );
  }

  _itemShimmer({required double width}) {
    return Container(
      width: width,
      padding:
          EdgeInsets.only(left: EdgeMargin.subMin, right: EdgeMargin.subMin),
      child: Card(
        color: globalColor.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0.w))),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12.0.w)),
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: EdgeMargin.subMin,
                      right: EdgeMargin.subMin,
                      bottom: EdgeMargin.subMin,
                      top: EdgeMargin.subMin),
                  width: width,
                  child: Column(
                    children: [
                      Container(
                        height: 144.h,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 144.h,
                                    child: BaseShimmerWidget(
                                      child: Container(
                                        width: 10.w,
                                        height: 144.h,
                                        decoration: BoxDecoration(
                                          color: globalColor.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.w)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    BaseShimmerWidget(
                                      child: Container(
                                        width: 60,
                                        height: 6,
                                        color: Colors.white,
                                      ),
                                    ),
                                    VerticalPadding(
                                      percentage: 1.0,
                                    ),
                                    Container(
                                      child: BaseShimmerWidget(
                                        child: Container(
                                          width: 35,
                                          height: 6,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                              alignment: AlignmentDirectional.centerEnd,
                              padding: const EdgeInsets.fromLTRB(
                                  EdgeMargin.verySub,
                                  EdgeMargin.sub,
                                  EdgeMargin.verySub,
                                  EdgeMargin.sub),
                              child: FittedBox(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4.0, right: 4.0),
                                        child: BaseShimmerWidget(
                                          child: Container(
                                            width: 16,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                color: globalColor.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.w)),
                                                border: Border.all(
                                                    color: globalColor.grey
                                                        .withOpacity(0.3),
                                                    width: 0.5)),
                                            constraints: BoxConstraints(
                                                minWidth: width * .1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: BaseShimmerWidget(
                                        child: Container(
                                          width: 20,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: globalColor.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.w)),
                                              border: Border.all(
                                                  color: globalColor.grey
                                                      .withOpacity(0.3),
                                                  width: 0.5)),
                                          padding: const EdgeInsets.fromLTRB(
                                              EdgeMargin.subSubMin,
                                              EdgeMargin.verySub,
                                              EdgeMargin.subSubMin,
                                              EdgeMargin.verySub),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: globalColor.backgroundLightPrim,
                  height: 2.0,
                ),
                // Container(
                //   //padding: const EdgeInsets.all(EdgeMargin.subMin),
                //   height: 41.h,
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //
                //       Row(
                //         children: [
                //           HorizontalPadding(percentage: 3,),
                //           BaseShimmerWidget(
                //             child: Container(
                //               width: 80,
                //               height: 10,
                //               color: Colors.white,
                //
                //             ),
                //           ),
                //         ],
                //       ),
                //       Container(
                //         //margin: const EdgeInsets.only(left:EdgeMargin.min,right: EdgeMargin.min),
                //         width: 148.w,
                //         height: 41.h,
                //         color: globalColor.scaffoldBackGroundGreyColor,
                //         child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Container(
                //
                //               child: BaseShimmerWidget(
                //                 child: Container(
                //                   decoration: BoxDecoration(
                //                       color: globalColor.white,
                //                       shape: BoxShape.circle,
                //                       border: Border.all(
                //                           color: globalColor.grey.withOpacity(0.2),
                //                           width: 1.0)),
                //                   width: 12.w,
                //                   height: 12.w,
                //
                //                 ),
                //               ),
                //             ),
                //             HorizontalPadding(
                //               percentage: 1,
                //             ),
                //             BaseShimmerWidget(
                //               child: Container(
                //                 width: 16,
                //                 height: 6,
                //                 color: Colors.white,
                //
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //
                //
                //     ],
                //   ),
                // ),
                //
                // Divider(
                //   color: globalColor.backgroundLightPrim,
                //   height: 2.0,
                // ),

                Container(
                  //padding: const EdgeInsets.all(EdgeMargin.subMin),
                  height: 41.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          HorizontalPadding(
                            percentage: 3,
                          ),
                          BaseShimmerWidget(
                            child: Container(
                              width: 60,
                              height: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //margin: const EdgeInsets.only(left:EdgeMargin.min,right: EdgeMargin.min),
                        width: 148.w,
                        height: 41.h,
                        color: globalColor.scaffoldBackGroundGreyColor,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HorizontalPadding(
                              percentage: 1,
                            ),
                            BaseShimmerWidget(
                              child: Container(
                                width: 40,
                                height: 6,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
