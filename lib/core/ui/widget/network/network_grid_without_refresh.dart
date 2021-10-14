// import 'package:ojos_app/core/entities/base_entity.dart';
// import 'package:ojos_app/core/errors/base_error.dart';
// import 'package:ojos_app/core/res/edge_margin.dart';
// import 'package:ojos_app/core/results/result.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
//
// import 'network_widget.dart';
//
//
// class NetworkGridWithoutRefresh<Entity extends BaseEntity>
//     extends StatelessWidget {
//   final bool enableRefresh;
//   final bool enablePagination;
//   final int pageSize;
//   final int crossCount;
//   final bool isScroll;
//   final Axis scrollDirection;
//
//   final Widget Function(required BuildContext context,  Entity item) itemBuilder;
//   final Future<Result<BaseError, List<Entity>>> Function(
//       int pageSize, int pageIndex) loader;
//   final WidgetBuilder placeHolder;
//   final WidgetBuilder loadingWidgetBuilder;
//   final SliverGridDelegate sliverGridDelegate;
//
//   NetworkGridWithoutRefresh(
//       {Key? key,
//       required this.loader,
//       required this.itemBuilder,
//       this.enableRefresh = false,
//       this.enablePagination = false,
//       this.pageSize = 10,
//       this.crossCount = 3,
//       this.isScroll = true,
//       this.scrollDirection = Axis.vertical,
//         required this.placeHolder,
//         required this.loadingWidgetBuilder,
//         required this.sliverGridDelegate})
//       :
//         super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return NetworkWidget<List<Entity>>(
//       builder: (context, networkItems) {
//         if (networkItems.isEmpty) {
//
//             return placeHolder(context);
//
//         }
//         return _NetworkGridContent<Entity>(
//           items: networkItems,
//           enableRefresh: enableRefresh,
//           enablePagination: enablePagination,
//           pageSize: pageSize,
//           crossCount: crossCount,
//           itemBuilder: itemBuilder,
//           scrollDirection: scrollDirection,
//           loader: loader,
//           isScroll: isScroll,
//           sliverGridDelegate: sliverGridDelegate,
//         );
//       },
//       fetcher: () {
//         return loader(pageSize, 0);
//       },
//       loadingWidgetBuilder: loadingWidgetBuilder,
//     );
//   }
// }
//
// class _NetworkGridContent<Entity extends BaseEntity> extends StatefulWidget {
//   final List<Entity > items;
//   final bool enableRefresh;
//   final bool enablePagination;
//   final bool isScroll;
//   final int pageSize;
//   final int crossCount;
//   final dynamic itemBuilder;
//   final Future<Result<BaseError, List<Entity>>> Function(int pageSize, int pageIndex)
//       loader;
//   final Axis scrollDirection;
//   final SliverGridDelegate sliverGridDelegate;
//
//   const _NetworkGridContent(
//       {Key? key,
//       required this.items,
//       required this.enableRefresh,
//       required this.enablePagination,
//       required this.pageSize,
//       required this.crossCount,
//       required this.itemBuilder,
//         required  this.scrollDirection,
//       required this.loader,
//       required this.isScroll,
//       required this.sliverGridDelegate})
//       :
//         super(key: key);
//
//   @override
//   __NetworkGridContentState<Entity> createState() => __NetworkGridContentState<Entity>();
// }
//
// class __NetworkGridContentState<Entity extends BaseEntity>
//     extends State<_NetworkGridContent> {
//   // Pagination State.
//   late List<Entity> _items;
//
//   @override
//   void initState() {
//     super.initState();
//     // _items = [...widget.items];
//     print(_items);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       scrollDirection: widget.scrollDirection,
//       gridDelegate: widget.sliverGridDelegate,
//       itemBuilder: (context, index) =>
//           widget.itemBuilder(context, _items[index]),
//       itemCount: _items.length,
//       shrinkWrap: true,
//       padding: const EdgeInsets.only(
//           left: EdgeMargin.subSubMin, right: EdgeMargin.subSubMin),
//       physics: widget.isScroll
//           ? ClampingScrollPhysics()
//           : NeverScrollableScrollPhysics(),
//     );
//   }
// }
