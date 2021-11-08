import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/items_shimmer/item_general_shimmer.dart';
import 'package:ojos_app/core/ui/widget/network/network_grid.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_favorite_entity.dart';
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';
import 'package:ojos_app/features/product/domin/usecases/get_products_fav.dart';
import 'package:ojos_app/features/product/presentation/widgets/item_product_home_widget.dart';

import '../../../main.dart';

class BuildGridProductFavWidget extends StatefulWidget {
  final void Function(List<ProductEntity>)? getProducts;

  final Map<String, String> params;

  final CancelToken cancelToken;

  final double? listWidth;
  final double? listHeight;

  final double? itemWidth;
  final double? itemHeight;

  final bool isScrollList;

  final bool isEnableRefresh;
  final bool isEnablePagination;

  //final bool isFromLearningPage;
  final Axis listScrollDirection;

  //final bool isAuth;
  final SliverGridDelegate? gridDelegate;

  const BuildGridProductFavWidget({
    required this.params,
    this.getProducts,
    required this.cancelToken,
    this.listWidth = 100,
    this.listHeight = 100,
    this.itemHeight,
    this.itemWidth,
    this.isScrollList = true,
    this.isEnableRefresh = false,
    this.isEnablePagination = false,
    //  this.isFromLearningPage = false,
    this.listScrollDirection = Axis.vertical,
    this.gridDelegate,
    // this.isAuth = true,
  });

  @override
  State<StatefulWidget> createState() {
    return _BuildGridProductFavWidgetState();
  }
}

class _BuildGridProductFavWidgetState extends State<BuildGridProductFavWidget>
    with AutomaticKeepAliveClientMixin<BuildGridProductFavWidget> {
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
      child: NetworkGrid<ProductFavoriteEntity>(
        enablePagination: widget.isEnablePagination,
        enableRefresh: widget.isEnableRefresh,
        isScroll: widget.isScrollList,
        sliverGridDelegate: widget.gridDelegate ??
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: globalSize.setWidthPercentage(60, context) /
                  globalSize.setWidthPercentage(47, context),
            ),
        placeHolder: (context) {
          return Center(
            child: Text(
              Translations.of(context).translate('no_product'),
              style: textStyle.smallTSBasic.copyWith(color: globalColor.black),
              textAlign: TextAlign.center,
            ),
          );
        },
        itemBuilder: (context, subject) {
          return getDesiredSubjectItem(
              subject.product, widget.itemWidth, widget.itemHeight);
        },
        loader: (pageSize, pageIndex) {
          return GetProductFav(locator<ProductRepository>())(
            GetProductFavParams(
              page: pageIndex,
              pagesize: pageSize,
              filterParams: widget.params,
              cancelToken: widget.cancelToken,
            ),
          );
        },
        loadingWidgetBuilder: (context) {
          return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              shrinkWrap: true,
              gridDelegate: widget.gridDelegate ??
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio:
                        globalSize.setWidthPercentage(60, context) /
                            globalSize.setWidthPercentage(47, context),
                  ),
              itemBuilder: (BuildContext context, int index) {
                return ItemGeneralShimmer(
                  height: widget.itemHeight ??
                      globalSize.setWidthPercentage(60, context),
                  width: widget.itemWidth ??
                      globalSize.setWidthPercentage(47, context),
                );
              });
          // return ListView.builder(
          //     physics: NeverScrollableScrollPhysics(),
          //     itemCount: 10,
          //     shrinkWrap: true,
          //     scrollDirection: widget.listScrollDirection,
          //     itemBuilder: (required BuildContext context,  int index) {
          //       return ItemGeneralShimmer(
          //         height: globalSize.setWidthPercentage(60, context),
          //         width: globalSize.setWidthPercentage(47, context),
          //       );
          //     });
        },
      ),
    );
  }

  Widget getDesiredSubjectItem(
      ProductEntity? product, double? itemWidth, double? itemHeight) {
    // if (widget.isFavoritePage)
    //   return ItemProductFavoriteWidget(
    //     product: product,
    //     height:itemHeight?? globalSize.setWidthPercentage(60, context),
    //     width:itemWidth?? globalSize.setWidthPercentage(47, context),
    //   );
    //

    return ItemProductHomeWidget(
      product: product!,
      height: itemHeight ?? globalSize.setWidthPercentage(60, context),
      width: itemWidth ?? globalSize.setWidthPercentage(47, context),
    );
    // if (widget.isFromLearningPage)
    //   return ItemSubjectLearn(
    //     cancelToken: widget.cancelToken,
    //     subject: subject,
    //     widthOfCard: 95,
    //   );
    // return !widget.isFavoritePage
    //     ? ItemWithRate(
    //         subject: subject,
    //         cancelToken: widget.cancelToken,
    //         isAuth: widget.isAuth,
    //       )
    //     : ItemWithRateFav(
    //         subject: subject,
    //         cancelToken: widget.cancelToken,
    //       );
  }

  @override
  bool get wantKeepAlive => true;
}
