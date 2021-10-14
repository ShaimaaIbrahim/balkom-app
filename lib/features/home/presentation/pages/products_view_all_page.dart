import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/list/build_grid_product.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/features/home/presentation/args/products_view_all_args.dart';

class ProductsVeiwAllPage extends StatefulWidget {
  static const routeName = '/homw/pages/ProductsVeiwAllPage';

  @override
  _TestResultPageState createState() => _TestResultPageState();
}

class _TestResultPageState extends State<ProductsVeiwAllPage> {
  final args = Get.Get.arguments as ProductsViewAllArgs;
  var _cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //=========================================================================

    AppBar appBar = AppBar(
      backgroundColor: globalColor.appBar,
      brightness: Brightness.light,
      elevation: 0,
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      title: Text(
        Translations.of(context).translate('products'),
        style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
      ),
      centerTitle: true,
    );

    double width = globalSize.setWidthPercentage(100, context);
    double height = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
        appBar: appBar,
        backgroundColor: globalColor.scaffoldBackGroundGreyColor,
        body: Container(
            height: height,
            child: BuildGridProductWidget(
              cancelToken: _cancelToken,
              itemWidth: globalSize.setWidthPercentage(43, context),
              itemHeight: globalSize.setWidthPercentage(60, context),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: globalSize.setWidthPercentage(43, context) /
                    globalSize.setWidthPercentage(60, context),
              ),
              isEnablePagination: true,
              isEnableRefresh: true,
              params: args.params ?? {},
            )));
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }
}
