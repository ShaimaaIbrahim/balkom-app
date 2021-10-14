// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:ojos_app/core/localization/translations.dart';
// import 'package:ojos_app/core/res/edge_margin.dart';
// import 'package:ojos_app/core/res/global_color.dart';
// import 'package:ojos_app/core/res/text_style.dart';
// import 'package:ojos_app/core/res/width_height.dart';
// import 'package:ojos_app/core/ui/items_shimmer/item_general_shimmer.dart';
// import 'package:ojos_app/core/ui/widget/network/network_list.dart';
// import 'package:ojos_app/features/order/domain/entities/general_order_item_entity.dart';
// import 'package:ojos_app/features/order/domain/repositories/order_repository.dart';
// import 'package:ojos_app/features/order/domain/usecases/get_orders.dart';
// import 'package:ojos_app/features/order/presentation/widgets/item_order_widget.dart';
// import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
// import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';
// import 'package:ojos_app/features/product/domin/usecases/get_products.dart';
// import 'package:ojos_app/features/product/presentation/widgets/item_product_home_widget.dart';
// import 'package:ojos_app/features/product/presentation/widgets/item_product_widget.dart';
//
//
// import '../../../main.dart';
//
// class BuildListProductWidget extends StatefulWidget {
//   final void Function(List<GeneralOrderItemEntity>) getOrder;
//
//   final Map<String, String> params;
//
//   final CancelToken cancelToken;
//
//   final double listWidth;
//   final double listHeight;
//
//   final bool isScrollList;
//
//   final bool isEnableRefresh;
//   final bool isEnablePagination;
//
//   //final bool isAuth;
//
//   const BuildListProductWidget({
//     this.params,
//     this.getOrder,
//     this.cancelToken,
//     this.listWidth = 100,
//     this.listHeight = 100,
//     this.isScrollList = true,
//    // this.isFavoritePage = false,
//     this.isEnableRefresh = true,
//     this.isEnablePagination = true,
//    // this.isAuth = true,
//   }) : assert(cancelToken != null);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _BuildListProductWidgetState();
//   }
// }
//
// class _BuildListProductWidgetState extends State<BuildListProductWidget>
//     with AutomaticKeepAliveClientMixin<BuildListProductWidget> {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//
//     double widthC = globalSize.setWidthPercentage(widget.listWidth??100, context);
//     double heightC = globalSize.setHeightPercentage(widget.listHeight??100, context);
//
//     return Container(
//       width: widthC,
//       height: heightC,
//
//       child: NetworkList<GeneralOrderItemEntity>(
//         listScrollDirection: Axis.vertical,
//         enablePagination: widget.isEnablePagination,
//         enableRefresh: widget.isEnableRefresh,
//         isScroll: widget.isScrollList,
//         placeHolder: (context) {
//           return Center(
//                   child: Text(
//                     Translations.of(context).translate('there_are_no_orders'),
//                     style: textStyle.smallTSBasic.copyWith(
//                       color: globalColor.black
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 );
//         },
//         itemBuilder: (context, order, index) {
//           return ItemOrderWidget(
//             orderItem: order,
//           );
//         },
//         getItems: (orders) {
//           if (widget.getOrder != null) widget.getOrder(orders);
//         },
//         loader: (pageSize, pageIndex) {
//           return GetOrders(locator<OrderRepository>())(
//             GetOrdersParams(
//               page: pageIndex,
//               pagesize: pageSize,
//               filterParams: widget.params,
//               cancelToken: widget.cancelToken,
//             ),
//           );
//         },
//         loadingWidgetBuilder: (context) {
//           return ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: 10,
//               shrinkWrap: true,
//               scrollDirection: Axis.vertical,
//               itemBuilder: (required BuildContext context,  int index) {
//                 return ItemGeneralShimmer(
//                   height: globalSize.setWidthPercentage(60, context),
//                   width: globalSize.setWidthPercentage(47, context),
//                 );
//               });
//         },
//       ),
//     );
//   }
//
//
//   @override
//   bool get wantKeepAlive => true;
// }
