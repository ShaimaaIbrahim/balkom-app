import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/core/appConfig.dart';
import 'package:ojos_app/core/errors/connection_error.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/ui/items_shimmer/base_shimmer.dart';
import 'package:ojos_app/features/order/domain/entities/general_order_item_entity.dart';
import 'package:ojos_app/features/order/domain/entities/spec_order_item_entity.dart';
import 'package:ojos_app/features/order/presentation/blocs/order_bloc.dart';
import 'package:steps_indicator/steps_indicator.dart';

import 'item_order_widget.dart';
import 'order_page_shimmer.dart';

class BasicOrderListPage extends StatefulWidget {
  final double? width;
  final double? height;
  final Map<String, String>? filterParams;

  const BasicOrderListPage(
      {this.width, this.height, required this.filterParams});

  @override
  _BasicOrderListPageState createState() => _BasicOrderListPageState();
}

class _BasicOrderListPageState extends State<BasicOrderListPage>
    with AutomaticKeepAliveClientMixin<BasicOrderListPage> {
  var _cancelToken = CancelToken();

  GlobalKey _key = GlobalKey();
  int selectedStep = 0;
  int nbSteps = 4;

  bool recipient = true;
  bool on_way = false;
  bool delivered = false;
  bool in_progress = false;

  bool track = true;
  bool loading = false;
  String state = 'pending';

  List<GeneralOrderItemEntity> listOfData = [];
  var _orderBloc = OrderBloc();
  GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    if (widget.filterParams!['order_status'] == "new") {
      // Timer.periodic(Duration(seconds: 1), (_) {
      _orderBloc.add(StatusOrder(
          cancelToken: _cancelToken,
          filterParams: widget.filterParams,
          status: "pending"));
      // });
    } else {
      // Timer.periodic(Duration(seconds: 1), (_) {
      _orderBloc.add(GetOrderEvent(
          cancelToken: _cancelToken, filterParams: widget.filterParams));
      //  });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocListener<OrderBloc, OrderState>(
        bloc: _orderBloc,
        listener: (BuildContext context, state) async {
          if (state is OrderDoneState) {
            listOfData = state.orders!;
            setState(() {
              track = state.withTrack!;
            });
          }
          if (state is DoneDeleteOrder) {
            appConfig.showToast(
                msg: Translations.of(context)
                    .translate('order_successfully_deleted'));
          }
          if (state is FailureDeleteOrder) {
            appConfig.showToast(
                msg: Translations.of(context).translate('order_failed_added'));
          }
          if (state is OrderDoneStateState) {
            listOfData = state.orders!;
            setState(() {
              track = state.withTrack!;
            });
          }
        },
        child: BlocBuilder<OrderBloc, OrderState>(
            bloc: _orderBloc,
            builder: (context, state) {
              if (state is OrderDoneState) {
                if (state.orders != null && state.orders!.isNotEmpty) {
                  return Container(
                    key: _globalKey,
                    width: widget.width,
                    height: widget.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          widget.filterParams!['order_status'] == "new"
                              ? Container(
                                  alignment: AlignmentDirectional.centerStart,
                                  padding: const EdgeInsets.only(
                                      left: EdgeMargin.min,
                                      right: EdgeMargin.min),
                                  child: Text(
                                    Translations.of(context)
                                        .translate('order_tracking'),
                                    style: textStyle.smallTSBasic.copyWith(
                                        color: globalColor.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              : Container(),
                          widget.filterParams!['order_status'] == "new"
                              ? Container(
                                  key: _key,
                                  margin: const EdgeInsets.only(
                                    left: EdgeMargin.min,
                                    right: EdgeMargin.min,
                                  ),
                                  height: widget.height! * .16,
                                  child: _buildStepWidget(
                                      context: context, width: widget.width!))
                              : Container(),
                          Container(
                            child: ListView.builder(
                              itemCount: listOfData.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return (listOfData[index].status ==
                                            "canceled" &&
                                        widget.filterParams!["order_status"] ==
                                            "new")
                                    ? SizedBox.shrink()
                                    : ItemOrderWidget(
                                        orderBloc: _orderBloc,
                                        filterparams: widget.filterParams,
                                        orderItem: listOfData[index],
                                        cancelToken: _cancelToken,
                                        onUpdate: _onUpdate,
                                      );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  if (state.withTrack!) {
                    return Container(
                        width: widget.width,
                        height: widget.height,
                        child: Column(
                          children: [
                            widget.filterParams!['order_status'] == "new"
                                ? Container(
                                    alignment: AlignmentDirectional.centerStart,
                                    padding: const EdgeInsets.only(
                                        left: EdgeMargin.min,
                                        right: EdgeMargin.min),
                                    child: Text(
                                      Translations.of(context)
                                          .translate('order_tracking'),
                                      style: textStyle.smallTSBasic.copyWith(
                                          color: globalColor.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                : Container(),
                            widget.filterParams!['order_status'] == "new"
                                ? Container(
                                    key: _key,
                                    margin: const EdgeInsets.only(
                                      left: EdgeMargin.min,
                                      right: EdgeMargin.min,
                                    ),
                                    height: widget.height! * .16,
                                    child: _buildStepWidget(
                                        context: context, width: widget.width!))
                                : Container(),
                            Center(
                              child: Text(
                                '${Translations.of(context).translate('there_are_no_orders')}',
                                style: textStyle.smallTSBasic
                                    .copyWith(color: globalColor.primaryColor),
                              ),
                            ),
                          ],
                        ));
                  } else {
                    return Center(
                      child: Text(
                        '${Translations.of(context).translate('there_are_no_orders')}',
                        style: textStyle.smallTSBasic
                            .copyWith(color: globalColor.primaryColor),
                      ),
                    );
                  }
                }
              }

              if (state is OrderFailureState) {
                return Container(
                  width: widget.width,
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                              Translations.of(context)
                                  .translate('err_connection'),
                              style: textStyle.normalTSBasic
                                  .copyWith(color: globalColor.accentColor)),
                        ),
                        RaisedButton(
                          onPressed: () {
                            _orderBloc.add(GetOrderEvent(
                                cancelToken: _cancelToken,
                                filterParams: widget.filterParams));
                          },
                          elevation: 1.0,
                          child: Text(
                              Translations.of(context).translate('retry'),
                              style: textStyle.smallTSBasic
                                  .copyWith(color: globalColor.white)),
                          color: Theme.of(context).accentColor,
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is OrderDoneStateState) {
                if (state.orders != null && state.orders!.isNotEmpty) {
                  return Container(
                    key: _globalKey,
                    width: widget.width,
                    height: widget.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          widget.filterParams!['order_status'] == "new"
                              ? Container(
                                  alignment: AlignmentDirectional.centerStart,
                                  padding: const EdgeInsets.only(
                                      left: EdgeMargin.min,
                                      right: EdgeMargin.min),
                                  child: Text(
                                    Translations.of(context)
                                        .translate('order_tracking'),
                                    style: textStyle.smallTSBasic.copyWith(
                                        color: globalColor.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              : Container(),
                          widget.filterParams!['order_status'] == "new"
                              ? Container(
                                  key: _key,
                                  margin: const EdgeInsets.only(
                                    left: EdgeMargin.min,
                                    right: EdgeMargin.min,
                                  ),
                                  height: widget.height! * .16,
                                  child: _buildStepWidget(
                                      context: context, width: widget.width!))
                              : Container(),
                          Container(
                            child: ListView.builder(
                              itemCount: listOfData.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return (listOfData[index].status ==
                                            "canceled" &&
                                        widget.filterParams!["order_status"] ==
                                            "new")
                                    ? SizedBox.shrink()
                                    : ItemOrderWidget(
                                        orderBloc: _orderBloc,
                                        filterparams: widget.filterParams,
                                        orderItem: listOfData[index],
                                        cancelToken: _cancelToken,
                                        onUpdate: _onUpdate,
                                      );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  if (state.withTrack!) {
                    return Container(
                        width: widget.width,
                        height: widget.height,
                        child: Column(
                          children: [
                            widget.filterParams!['order_status'] == "new"
                                ? Container(
                                    alignment: AlignmentDirectional.centerStart,
                                    padding: const EdgeInsets.only(
                                        left: EdgeMargin.min,
                                        right: EdgeMargin.min),
                                    child: Text(
                                      Translations.of(context)
                                          .translate('order_tracking'),
                                      style: textStyle.smallTSBasic.copyWith(
                                          color: globalColor.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                : Container(),
                            widget.filterParams!['order_status'] == "new"
                                ? Container(
                                    key: _key,
                                    margin: const EdgeInsets.only(
                                      left: EdgeMargin.min,
                                      right: EdgeMargin.min,
                                    ),
                                    height: widget.height! * .16,
                                    child: _buildStepWidget(
                                        context: context, width: widget.width!))
                                : Container(),
                            Center(
                              child: Text(
                                '${Translations.of(context).translate('there_are_no_orders')}',
                                style: textStyle.smallTSBasic
                                    .copyWith(color: globalColor.primaryColor),
                              ),
                            ),
                          ],
                        ));
                  } else {
                    return Center(
                      child: Text(
                        '${Translations.of(context).translate('there_are_no_orders')}',
                        style: textStyle.smallTSBasic
                            .copyWith(color: globalColor.primaryColor),
                      ),
                    );
                  }
                }
              }
              if (state is StateLoadingState) {
                return Container(
                  width: widget.width,
                  height: widget.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        widget.filterParams!['order_status'] == "new"
                            ? Container(
                                alignment: AlignmentDirectional.centerStart,
                                padding: const EdgeInsets.only(
                                    left: EdgeMargin.min,
                                    right: EdgeMargin.min),
                                child: Text(
                                  Translations.of(context)
                                      .translate('order_tracking'),
                                  style: textStyle.smallTSBasic.copyWith(
                                      color: globalColor.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            : Container(),
                        widget.filterParams!['order_status'] == "new"
                            ? Container(
                                margin: const EdgeInsets.only(
                                  left: EdgeMargin.min,
                                  right: EdgeMargin.min,
                                ),
                                height: widget.height! * .16,
                                child: _buildStepWidget(
                                    context: context, width: widget.width!))
                            : Container(),
                        Container(
                          child: ListView.builder(
                            itemCount: 10,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _itemShimmer(width: widget.width!);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return Container(
                  width: widget.width,
                  height: widget.height,
                  child: OrderPageShimmer(
                    status: widget.filterParams!['order_status'],
                    width: widget.width!,
                    height: widget.height!,
                  ));
            }));
  }

  _onUpdate() {
    _globalKey = GlobalKey();
    if (mounted) setState(() {});
  }

  _buildStepWidget({required BuildContext context, required double width}) {
    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: globalColor.white,
                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                border: Border.all(
                    color: globalColor.grey.withOpacity(0.2), width: 1.0)),
            width: 73.w,
            height: 60,
            child: InkWell(
              onTap: () {
                _orderBloc.add(StatusOrder(
                    status: 'pending',
                    filterParams: widget.filterParams,
                    cancelToken: _cancelToken));
                setState(() {
                  recipient = true;
                  on_way = false;
                  delivered = false;
                  in_progress = false;
                  state = "pending";
                  loading = true;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  recipient ? coloredCircle() : emptyCircle(),
                  Container(
                    child: Text(
                      Translations.of(context).translate('pending'),
                      style: textStyle.subMinTSBasic.copyWith(
                          color: globalColor.black,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          in_progress
              ? Expanded(
                  child: Container(
                  height: 1.0,
                  color: globalColor.primaryColor,
                ))
              : Expanded(
                  child: Container(
                  height: 1.0,
                  color: globalColor.grey.withOpacity(0.2),
                )),
          Container(
            decoration: BoxDecoration(
                color: globalColor.white,
                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                border: Border.all(
                    color: globalColor.grey.withOpacity(0.2), width: 1.0)),
            width: 73.w,
            height: 60,
            child: InkWell(
              onTap: () {
                setState(() {
                  in_progress = true;
                  recipient = false;
                  delivered = false;
                  on_way = false;
                  state = "accepted";
                  loading = true;
                  _orderBloc.add(StatusOrder(
                      status: 'accepted',
                      filterParams: widget.filterParams,
                      cancelToken: _cancelToken));
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  in_progress ? coloredCircle() : emptyCircle(),
                  Container(
                    child: Text(
                      Translations.of(context).translate('accepted'),
                      style: textStyle.subMinTSBasic.copyWith(
                          color: globalColor.black,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          on_way
              ? Expanded(
                  child: Container(
                  height: 1.0,
                  color: globalColor.primaryColor,
                ))
              : Expanded(
                  child: Container(
                  height: 1.0,
                  color: globalColor.grey.withOpacity(0.2),
                )),
          Container(
            decoration: BoxDecoration(
                color: globalColor.white,
                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                border: Border.all(
                    color: globalColor.grey.withOpacity(0.2), width: 1.0)),
            width: 73.w,
            height: 60,
            child: InkWell(
              onTap: () {
                setState(() {
                  _orderBloc.add(StatusOrder(
                      status: 'shipped',
                      filterParams: widget.filterParams,
                      cancelToken: _cancelToken));

                  state = "shipped";
                  on_way = true;
                  recipient = false;
                  in_progress = false;
                  delivered = false;
                  loading = true;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  on_way ? coloredCircle() : emptyCircle(),
                  Container(
                    child: Text(
                      Translations.of(context).translate('shipped'),
                      style: textStyle.subMinTSBasic.copyWith(
                          color: globalColor.black,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          delivered
              ? Expanded(
                  child: Container(
                  height: 1.0,
                  color: globalColor.primaryColor,
                ))
              : Expanded(
                  child: Container(
                  height: 1.0,
                  color: globalColor.grey.withOpacity(0.2),
                )),
          Container(
            decoration: BoxDecoration(
                color: globalColor.white,
                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                border: Border.all(
                    color: globalColor.grey.withOpacity(0.2), width: 1.0)),
            width: 73.w,
            height: 60,
            child: InkWell(
              onTap: () {
                setState(() {
                  _orderBloc.add(StatusOrder(
                      status: 'completed',
                      filterParams: widget.filterParams,
                      cancelToken: _cancelToken));

                  state = "completed";
                  delivered = true;
                  on_way = false;
                  recipient = false;
                  in_progress = false;
                  loading = true;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  delivered ? coloredCircle() : emptyCircle(),
                  Container(
                    child: Text(
                      Translations.of(context).translate('completed'),
                      style: textStyle.subMinTSBasic.copyWith(
                          color: globalColor.black,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget coloredCircle() {
    return Container(
      decoration: BoxDecoration(
          color: globalColor.goldColor,
          shape: BoxShape.circle,
          border: Border.all(color: globalColor.primaryColor, width: 1.0)),
      width: 24.w,
      height: 24.w,
      child: Icon(
        Icons.check,
        color: globalColor.black,
        size: 10.w,
      ),
    );
  }

  Widget emptyCircle() {
    return Container(
      decoration: BoxDecoration(
          color: globalColor.grey.withOpacity(0.2),
          shape: BoxShape.circle,
          border:
              Border.all(color: globalColor.grey.withOpacity(0.2), width: 1.0)),
      width: 24.w,
      height: 24.w,
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
                              width: 80,
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
                            Container(
                              child: BaseShimmerWidget(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: globalColor.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color:
                                              globalColor.grey.withOpacity(0.2),
                                          width: 1.0)),
                                  width: 12.w,
                                  height: 12.w,
                                ),
                              ),
                            ),
                            HorizontalPadding(
                              percentage: 1,
                            ),
                            BaseShimmerWidget(
                              child: Container(
                                width: 16,
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
                Divider(
                  color: globalColor.backgroundLightPrim,
                  height: 2.0,
                ),
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
  void dispose() {
    _orderBloc.close();
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
