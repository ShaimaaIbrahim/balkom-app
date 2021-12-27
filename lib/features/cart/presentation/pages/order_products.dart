import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/list/build_grid_product.dart';
import 'package:ojos_app/features/cart/presentation/widgets/item_product_order_item.dart';
import 'package:ojos_app/features/order/data/models/order_products_arguments.dart';

class OrderProducts extends StatefulWidget {
  static String routeName = "/cart/pages/ordderProducts";

  const OrderProducts({Key? key}) : super(key: key);

  @override
  _OrderProductsState createState() => _OrderProductsState();
}

class _OrderProductsState extends State<OrderProducts> {
  final args = Get.Get.arguments as OrderProductsArguments;

  @override
  Widget build(BuildContext context) {
    var _cancelToken = CancelToken();

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
          child: GridView.builder(
            itemCount: args.products!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: globalSize.setWidthPercentage(60, context) /
                  globalSize.setWidthPercentage(47, context),
            ),
            itemBuilder: (BuildContext context, int index) {
              return ItemProductOrderWidget(
                height: heightC,
                orderId: args.orderId,
                product: args.products![index],
              );
            },
          )),
    );
  }
}
