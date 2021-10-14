import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ojos_app/core/entities/category_entity.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/items_shimmer/item_category_shimmer.dart';
import 'package:ojos_app/core/ui/widget/network/network_grid.dart';
import 'package:ojos_app/core/usecases/get_categories.dart';
import 'package:ojos_app/features/section/presentation/widgets/item_section.dart';

import '../../../main.dart';

class BuildListCategoryWidget extends StatefulWidget {
  final CancelToken cancelToken;
  final Map<String, String>? params;
  final SliverGridDelegate? gridDelegate;

  const BuildListCategoryWidget({
    required this.cancelToken,
    this.params,
    this.gridDelegate,
  });

  @override
  State<StatefulWidget> createState() {
    return _BuildListCategoryWidgetState();
  }
}

class _BuildListCategoryWidgetState extends State<BuildListCategoryWidget>
    with AutomaticKeepAliveClientMixin<BuildListCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    double widthC = globalSize.setWidthPercentage(100, context);
    double heightC = globalSize.setHeightPercentage(100, context);

    return Container(
      width: widthC,
      height: heightC,
      padding: EdgeInsets.only(top: EdgeMargin.subSubMin),
      child: NetworkGrid<CategoryEntity>(
        enablePagination: true,
        enableRefresh: true,
        crossCount: 2,
        sliverGridDelegate: widget.gridDelegate ??
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
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
          return ItemSection(
            category: category,
            height: globalSize.setWidthPercentage(40, context),
            width: globalSize.setWidthPercentage(40, context),
          );
        },
        loader: (pageSize, pageIndex) async {
          //     return Future.delayed(Duration(seconds: 200));
          return GetCategories(locator<CoreRepository>())(
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
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio:
                        globalSize.setWidthPercentage(40, context) /
                            globalSize.setWidthPercentage(40, context),
                  ),
              itemBuilder: (BuildContext context, int index) {
                return ItemCategoryShimmer(
                  height: globalSize.setWidthPercentage(40, context),
                  width: globalSize.setWidthPercentage(40, context),
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
