import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/entities/brand_entity.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/widget/network/network_grid.dart';
import 'package:ojos_app/core/usecases/get_brands.dart';
import 'package:ojos_app/features/brand/presentation/widgets/item_brand.dart';

import '../../../main.dart';
import '../items_shimmer/base_shimmer.dart';

class BuildListBrandWidget extends StatefulWidget {
  final CancelToken cancelToken;
  final Map<String, String> params;
  final SliverGridDelegate? gridDelegate;

  const BuildListBrandWidget({
    required this.cancelToken,
    required this.params,
    this.gridDelegate,
  });

  @override
  State<StatefulWidget> createState() {
    return _BuildListCategoryWidgetState();
  }
}

class _BuildListCategoryWidgetState extends State<BuildListBrandWidget>
    with AutomaticKeepAliveClientMixin<BuildListBrandWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    double widthC = globalSize.setWidthPercentage(100, context);
    double heightC = globalSize.setHeightPercentage(100, context);

    return Container(
      width: widthC,
      height: heightC,
      padding: EdgeInsets.only(top: EdgeMargin.subSubMin),
      child: NetworkGrid<BrandEntity>(
        enablePagination: true,
        enableRefresh: true,
        crossCount: 2,
        sliverGridDelegate: widget.gridDelegate ??
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: globalSize.setWidthPercentage(40, context) /
                  globalSize.setWidthPercentage(40, context),
            ),
        placeHolder: (context) {
          return Center(
            child: Text(
              Translations.of(context).translate('no_categories'),
              style: textStyle.smallTSBasic.copyWith(color: globalColor.black),
              textAlign: TextAlign.center,
            ),
          );
        },
        itemBuilder: (context, category) {
          return ItemBrand(
            brand: category,
            height: globalSize.setWidthPercentage(40, context),
            width: globalSize.setWidthPercentage(40, context),
          );
        },
        loader: (pageSize, pageIndex) async {
          //     return Future.delayed(Duration(seconds: 200));
          return GetBrands(locator<CoreRepository>())(
            NoParams(cancelToken: widget.cancelToken),
          );
        },
        loadingWidgetBuilder: (context) {
          return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              shrinkWrap: true,
              gridDelegate: widget.gridDelegate ??
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio:
                        globalSize.setWidthPercentage(40, context) /
                            globalSize.setWidthPercentage(40, context),
                  ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      color: globalColor.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12.w),
                      border: Border.all(
                          width: 0.5,
                          color: globalColor.grey.withOpacity(0.4))),
                  height: globalSize.setWidthPercentage(40, context),
                  width: globalSize.setWidthPercentage(40, context),
                  child: BaseShimmerWidget(
                    child: Container(
                      width: globalSize.setWidthPercentage(40, context),
                      height: globalSize.setWidthPercentage(40, context),
                      color: Colors.white,
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
