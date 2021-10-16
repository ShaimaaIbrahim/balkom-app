import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/dailog/confirm_dialog.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:ojos_app/features/order/domain/entities/general_order_item_entity.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/features/order/domain/repositories/order_repository.dart';
import 'package:ojos_app/features/order/domain/usecases/delete_order.dart';
import 'package:ojos_app/features/order/presentation/blocs/order_bloc.dart';
import 'package:ojos_app/features/order/presentation/pages/order_details_page.dart';

import '../../../../main.dart';

class ItemOrderWidget extends StatefulWidget {

  final GeneralOrderItemEntity? orderItem;
  final CancelToken? cancelToken;
  final Function? onUpdate;
  final OrderBloc? orderBloc;
  final Map<String, String>? filterparams;

  const ItemOrderWidget({this.orderItem, this.onUpdate,
    this.cancelToken, required this.orderBloc, this.filterparams});

  @override
  _ItemOrderWidgetState createState() => _ItemOrderWidgetState();
}

class _ItemOrderWidgetState extends State<ItemOrderWidget> {
  bool isDeleted = false;
  var _cancelToken = CancelToken();

  @override
  Widget build(BuildContext context) {
    double width = globalSize.setWidthPercentage(95, context);
    return isDeleted
        ? Container()
        : InkWell(
            onTap: () {
              Get.Get.toNamed(OrderDetailsPage.routeName,
                  arguments: widget.orderItem);
            },
            child: Container(
              width: width,
              padding: EdgeInsets.only(
                  left: EdgeMargin.subMin, right: EdgeMargin.subMin),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 144.h,
                                            child: ImageCacheWidget(
                                              imageUrl: widget
                                                      .orderItem!.orderimage ??
                                                  '',
                                              imageWidth: 10.w,
                                              imageHeight: 144.h,
                                              imageBorderRadius: 12.w,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      left: 4.0,
                                      top: 4.0,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      EdgeMargin.verySub,
                                      EdgeMargin.sub,
                                      EdgeMargin.verySub,
                                      EdgeMargin.sub),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  color: globalColor.white,
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          12.w)),
                                                  border: Border.all(
                                                      color: globalColor.grey
                                                          .withOpacity(0.3),
                                                      width: 0.5)),
                                              constraints: BoxConstraints(
                                                  minWidth: width * .1),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0, right: 4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text(
                                                      '${widget.orderItem?.subtotal?.toString() ?? ''}',
                                                      style: textStyle
                                                          .minTSBasic
                                                          .copyWith(
                                                        color:
                                                        globalColor.black,
                                                      ),
                                                    ),
                                                    Text(
                                                        ' ${Translations.of(context).translate('rail')}',
                                                        style: textStyle
                                                            .minTSBasic
                                                            .copyWith(
                                                            color:
                                                            globalColor
                                                                .black)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Container(
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    color: globalColor.white,
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            12.w)),
                                                    border: Border.all(
                                                        color: globalColor.grey
                                                            .withOpacity(0.3),
                                                        width: 0.5)),
                                                padding:
                                                const EdgeInsets.fromLTRB(
                                                    EdgeMargin.subSubMin,
                                                    EdgeMargin.verySub,
                                                    EdgeMargin.subSubMin,
                                                    EdgeMargin.verySub),
                                                child:
                                                //  widget.orderItem.order_items.product.discountTypeInt != null &&widget.orderItem.order_items.product.discountTypeInt ==1  ?
                                                Row(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      AppAssets.sales_svg,
                                                      width: 12,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      '${widget.orderItem!.price_discount ?? '-'} ${Translations.of(context).translate('rail')}',
                                                      style: textStyle
                                                          .minTSBasic
                                                          .copyWith(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          color: globalColor
                                                              .primaryColor),
                                                    ),
                                                    Text(
                                                        ' ${Translations.of(context).translate('discount')}',
                                                        style: textStyle
                                                            .minTSBasic
                                                            .copyWith(
                                                            color:
                                                            globalColor
                                                                .black)),
                                                  ],
                                                )
                                            ),
                                          ]
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                                child: InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (ctx) => ConfirmDialog(
                                                              title: Translations
                                                                  .of(context)
                                                                  .translate(
                                                                  'delete_order'),
                                                              confirmMessage: Translations
                                                                  .of(context)
                                                                  .translate(
                                                                  'are_you_sure_delete_order'),
                                                              actionYes: () {
                                                                widget.orderBloc!.add(
                                                                    DeleteOrderEvent(
                                                                     filterparams: widget.filterparams,
                                                                     cancelToken: _cancelToken,
                                                                     id: widget.orderItem!.id));
                                                                },
                                                              actionNo: () {
                                                                setState(() {
                                                                  Get.Get.back();
                                                                });
                                                              },
                                                            ),
                                                      );
                                                    },
                                                    child: Icon(Icons.delete,
                                                        size: 30,
                                                        color: globalColor
                                                            .red)),),
                                      )
                                    ],
                                  )),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: EdgeMargin.subMin,
                                      right: EdgeMargin.subMin),
                                  child: Text(
                                    '${Translations.of(context).translate('order_status')}',
                                    style: textStyle.smallTSBasic.copyWith(
                                        color: globalColor.black,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
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
                                      decoration: BoxDecoration(
                                          color: _getColorStatus(
                                                  context: context,
                                                  status: widget.orderItem!
                                                          .statusint ??
                                                      "0") ??
                                              globalColor.green,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: globalColor.grey
                                                  .withOpacity(0.2),
                                              width: 1.0)),
                                      width: 12.w,
                                      height: 12.w,
                                    ),
                                    HorizontalPadding(
                                      percentage: 1,
                                    ),
                                    Text(
                                      //'${Translations.of(context).translate('delivery_stage')}',
                                      _getStrStatus(
                                          context: context,
                                          status: widget.orderItem!.statusint!),
                                      style: textStyle.minTSBasic.copyWith(
                                          color: globalColor.primaryColor),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
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
                          // padding: const EdgeInsets.all(EdgeMargin.subMin),
                          height: 41.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: EdgeMargin.subMin,
                                      right: EdgeMargin.subMin),
                                  child: Text(
                                    '${Translations.of(context).translate('time_left_for_delivery')}',
                                    style: textStyle.smallTSBasic.copyWith(
                                        color: globalColor.black,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              Container(
                                //  margin: const EdgeInsets.only(left:EdgeMargin.min,right: EdgeMargin.min),
                                width: 148.w,
                                height: 41.h,
                                color: globalColor.scaffoldBackGroundGreyColor,
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  '${widget.orderItem?.city?.shiping_time ?? '-'}',
                                  style: textStyle.smallTSBasic.copyWith(
                                      color: globalColor.primaryColor,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
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
                          // padding: const EdgeInsets.all(EdgeMargin.subMin),
                          height: 41.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: EdgeMargin.subMin,
                                      right: EdgeMargin.subMin),
                                  alignment: AlignmentDirectional.center,
                                  child: Text(
                                    '${Translations.of(context).translate('order_details')}',
                                    style: textStyle.smallTSBasic.copyWith(
                                        color: globalColor.black,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              widget.orderItem!.status == "pending"
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => ConfirmDialog(
                                            title: Translations.of(context)
                                                .translate('delete'),
                                            confirmMessage:
                                                Translations.of(context)
                                                    .translate(
                                                        'are_you_sure_delete'),
                                            actionYes: () {
                                              Get.Get.back();
                                              _requestDeleteNotificationsNewProduct(
                                                  id: widget.orderItem!.id!,
                                                  context: context);
                                            },
                                            actionNo: () {
                                              Get.Get.back();
                                            },
                                          ),
                                        );
                                      },
                                      child: Container(
                                        child: Center(
                                          child: Container(
                                            // decoration: BoxDecoration(
                                            //     color: globalColor.white,
                                            //     borderRadius: BorderRadius.circular(12.0.w),
                                            //     border: Border.all(
                                            //         color: globalColor.grey.withOpacity(0.3),
                                            //         width: 0.5)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      EdgeMargin.sub,
                                                      EdgeMargin.sub,
                                                      EdgeMargin.sub,
                                                      EdgeMargin.sub),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.delete,
                                                    color: globalColor.red,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
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
            ),
          );
  }

  _getStrStatus({required BuildContext context, required String status}) {
    switch (status) {
      case "accepted":
        return Translations.of(context).translate('received');
        break;
      case "canceled":
        return Translations.of(context).translate('canceled');
        break;
      case "pending":
        return Translations.of(context).translate('processing');
        break;
      // case 4:
      //   return Translations.of(context).translate('delivered');
      //   break;
      // case 5:
      //   return Translations.of(context).translate('canceled');
      //   break;
      // case 6:
      //   return Translations.of(context).translate('cancel_requested');
      //   break;
      // case 7:
      //   return Translations.of(context).translate('refunded');
      //   break;
      default:
        return Translations.of(context).translate('received');
        break;
    }
  }

  _getColorStatus({required BuildContext context, required String status}) {
    switch (status) {
      case "accepted":
        return globalColor.green;
        break;

      case "canceled":
        return globalColor.red;
        break;
      case "refunded":
        return globalColor.red;
        break;
      case "cancel_requested":
        return globalColor.red;
        break;
      case "pending":
        return globalColor.buttonColorOrange;
        break;
      default:
        return globalColor.green;
        break;
    }
  }

  _requestDeleteNotificationsNewProduct(
      {required int id, required BuildContext context}) async {
    final result = await DeleteOrderUseCase(locator<OrderRepository>())(
      DeleteOrderParams(cancelToken: widget.cancelToken, id: id),
    );
    if (result.hasDataOnly) {
      Fluttertoast.showToast(
          msg: Translations.of(context).translate('Deleted'),
          backgroundColor: globalColor.primaryColor,
          textColor: globalColor.white);

      if (mounted) {
        setState(() {
          isDeleted = true;
        });
      }
      if (widget.onUpdate != null) widget.onUpdate!();
    } else if (result.hasErrorOnly || result.hasDataAndError)
      Fluttertoast.showToast(
          msg: Translations.of(context).translate('err_unexpected'));
  }
}
