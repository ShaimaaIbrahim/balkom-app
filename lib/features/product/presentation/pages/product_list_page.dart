import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/list/build_grid_product.dart';
import 'package:get/get.dart' as Get;
import '../args/product_list_args.dart';

class ProductListPage extends StatefulWidget {
  static const routeName = '/features/ProductDetails/ProductListPage';
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  var _cancelToken = CancelToken();

  final args = Get.Get.arguments as ProductListArguments;
  @override
  Widget build(BuildContext context) {
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

    double widthC = globalSize.setWidthPercentage(100, context);
    double heightC = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
        appBar: appBar,
        body: Container(
            width: widthC,
            height: heightC,
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
