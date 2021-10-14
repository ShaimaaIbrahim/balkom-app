import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/entities/notifications_entity.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/items_shimmer/base_shimmer.dart';
import 'package:ojos_app/core/ui/widget/network/network_list.dart';
import 'package:ojos_app/core/usecases/get_notifications.dart';
import 'package:ojos_app/features/notification/presentation/widgets/item_notification_widget.dart';

import '../../../main.dart';

class BuildListNotificationsWidget extends StatefulWidget {
  final Map<String, String> params;

  final CancelToken cancelToken;
  final Function() onUpdate;

  final double? listWidth;
  final double? listHeight;

  final double itemWidth;
  final double? itemHeight;

  final bool isScrollList;

  final bool isEnableRefresh;
  final bool isEnablePagination;

  //final bool isFromLearningPage;
  final Axis listScrollDirection;

  //final bool isAuth;
  final SliverGridDelegate? gridDelegate;

  const BuildListNotificationsWidget({
    required this.params,
    required this.cancelToken,
    this.listWidth = 100,
    this.listHeight = 100,
    this.itemHeight,
    required this.itemWidth,
    required this.onUpdate,
    this.isScrollList = true,
    this.isEnableRefresh = true,
    this.isEnablePagination = true,
    //  this.isFromLearningPage = false,
    this.listScrollDirection = Axis.vertical,
    this.gridDelegate,
    // this.isAuth = true,
  });

  @override
  State<StatefulWidget> createState() {
    return BuildListNotificationsWidgetState();
  }
}

class BuildListNotificationsWidgetState
    extends State<BuildListNotificationsWidget>
    with AutomaticKeepAliveClientMixin<BuildListNotificationsWidget> {
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
      child: NetworkList<NotificationsEntity>(
        listScrollDirection: widget.listScrollDirection,
        enablePagination: widget.isEnablePagination,
        enableRefresh: widget.isEnableRefresh,
        isScroll: widget.isScrollList,
        placeHolder: (context) {
          return Center(
            child: Text(
              Translations.of(context).translate('no_notif'),
              style: textStyle.smallTSBasic.copyWith(color: globalColor.black),
              textAlign: TextAlign.center,
            ),
          );
        },
        itemBuilder: (context, subject, index) {
          return ItemNotificationWidget(
            width: widget.itemWidth,
            notification: subject,
            cancelToken: widget.cancelToken,
            onUpdate: widget.onUpdate,
          );
        },
        getItems: (subjects) {},
        loader: (pageSize, pageIndex) {
          return GetNotifications(locator<CoreRepository>())(
            NoParams(
              cancelToken: widget.cancelToken,
            ),
          );
        },
        loadingWidgetBuilder: (context) {
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              shrinkWrap: true,
              scrollDirection: widget.listScrollDirection,
              itemBuilder: (BuildContext context, int index) {
                return _itemShimmer(width: widget.itemWidth);
              });
        },
      ),
    );
  }

  _itemShimmer({required double width}) {
    return Container(
      width: width,
      height: 55,
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
                              width: 40,
                              height: 40,
                              color: Colors.white,
                            ),
                          ),
                          HorizontalPadding(
                            percentage: 3,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BaseShimmerWidget(
                                child: Container(
                                  width: 60,
                                  height: 10,
                                  color: Colors.white,
                                ),
                              ),
                              VerticalPadding(
                                percentage: 0.5,
                              ),
                              BaseShimmerWidget(
                                child: Container(
                                  width: 30,
                                  height: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
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
  bool get wantKeepAlive => true;
}
