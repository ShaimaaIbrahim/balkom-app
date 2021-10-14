import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/items_shimmer/item_general_shimmer.dart';
import 'package:ojos_app/core/ui/widget/network/network_list.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';
import 'package:ojos_app/features/product/domin/usecases/get_products.dart';
import 'package:ojos_app/features/product/presentation/widgets/item_product_home_widget.dart';
import 'package:ojos_app/features/product/presentation/widgets/item_product_widget.dart';

import '../../../main.dart';
import '../../constants.dart';

class BuildListProductWidget extends StatefulWidget {
  final void Function(List<ProductEntity>)? getProducts;

  final Map<String, dynamic> params;

  final CancelToken cancelToken;

  final double? listWidth;
  final double? listHeight;

  final bool isScrollList;

  //final bool isFavoritePage;
  final bool isEnableRefresh;
  final bool isEnablePagination;

  //final bool isFromLearningPage;
  final Axis listScrollDirection;
  final bool isFromHomePage;

  //final bool isAuth;

  const BuildListProductWidget({
    required this.params,
    this.getProducts,
    required this.cancelToken,
    this.isFromHomePage = false,
    this.listWidth = 100,
    this.listHeight = 100,
    this.isScrollList = true,
    // this.isFavoritePage = false,
    this.isEnableRefresh = true,
    this.isEnablePagination = true,
    //  this.isFromLearningPage = false,
    this.listScrollDirection = Axis.vertical,
    // this.isAuth = true,
  }) : assert(cancelToken != null);

  @override
  State<StatefulWidget> createState() {
    return _BuildListProductWidgetState();
  }
}

class _BuildListProductWidgetState extends State<BuildListProductWidget>
    with AutomaticKeepAliveClientMixin<BuildListProductWidget> {
  List<ProductEntity> list = [];

  @override
  void initState() {
    super.initState();
    /* var r = GetProduct(locator<ProductRepository>())(
      GetProductParams(
        page: 0,
        pagesize: 100,
        filterParams: widget.params,
        cancelToken: widget.cancelToken,
      ),
    );
    r.then((value) => {
          list = value.data!
          print(
              'list products******************************${value.data!.length}')
        });*/
  }

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
          return !widget.isFromHomePage
              ? Center(
                  child: Text(
                    Translations.of(context).translate('no_product'),
                    style: textStyle.smallTSBasic
                        .copyWith(color: globalColor.black),
                    textAlign: TextAlign.center,
                  ),
                )
              : SizedBox();
        },
        itemBuilder: (context, subject, index) {
          print(
              'description products******************************${subject.description}');

          return getDesiredSubjectItem(subject);
        },
        getItems: (subjects) {
          if (widget.getProducts != null) widget.getProducts!(subjects);
        },
        loader: (pageSize, pageIndex) {
          var r = GetProduct(locator<ProductRepository>())(
            GetProductParams(
              page: 0,
              pagesize: 100,
              filterParams: widget.params,
              cancelToken: widget.cancelToken,
            ),
          );
          r.then((value) => {this.list = value.data!});

          return r;
        },
        loadingWidgetBuilder: (context) {
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              shrinkWrap: true,
              scrollDirection: widget.listScrollDirection,
              itemBuilder: (BuildContext context, int index) {
                return ItemGeneralShimmer(
                  height: globalSize.setWidthPercentage(60, context),
                  width: globalSize.setWidthPercentage(47, context),
                  isFromHome: widget.isFromHomePage,
                );
              });
        },
      ),
    );
  }

  Widget getDesiredSubjectItem(ProductEntity? product) {
    if (widget.isFromHomePage)
      return ItemProductHomeWidget(
        product: product,
        height: globalSize.setWidthPercentage(60, context),
        width: globalSize.setWidthPercentage(47, context),
      );
    return ItemProductWidget(
      product: product,
      height: globalSize.setWidthPercentage(60, context),
      width: globalSize.setWidthPercentage(47, context),
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
