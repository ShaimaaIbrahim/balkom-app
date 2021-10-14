import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ojos_app/core/entities/wallet_transactions_entity.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/utils.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/items_shimmer/base_shimmer.dart';
import 'package:ojos_app/core/ui/widget/network/network_list_without_refresh.dart';
import 'package:ojos_app/core/usecases/get_wallet_transactions.dart';

import '../../../main.dart';

class BuildListWalletTransactionsWidget extends StatefulWidget {
  final Map<String, String> params;

  final CancelToken cancelToken;

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

  const BuildListWalletTransactionsWidget({
    required this.params,
    required this.cancelToken,
    this.listWidth = 100,
    this.listHeight = 100,
    this.itemHeight,
    required this.itemWidth,
    this.isScrollList = true,
    this.isEnableRefresh = true,
    this.isEnablePagination = true,
    //  this.isFromLearningPage = false,
    this.listScrollDirection = Axis.vertical,
    this.gridDelegate,
    // this.isAuth = true,
  }) : assert(cancelToken != null);

  @override
  State<StatefulWidget> createState() {
    return BuildListNotificationsWidgetState();
  }
}

class BuildListNotificationsWidgetState
    extends State<BuildListWalletTransactionsWidget>
    with AutomaticKeepAliveClientMixin<BuildListWalletTransactionsWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    double widthC =
        globalSize.setWidthPercentage(widget.listWidth ?? 100, context);
    double heightC =
        globalSize.setHeightPercentage(widget.listHeight ?? 100, context);

    return Container(
      width: widthC,
      child: NetworkListWithoutRefresh<WalletTransactionsEntity>(
        enablePagination: widget.isEnablePagination,
        enableRefresh: widget.isEnableRefresh,
        isScroll: widget.isScrollList,
        placeHolder: (context) {
          return Center(
            child: Text(
              Translations.of(context).translate('no_process'),
              style: textStyle.smallTSBasic.copyWith(color: globalColor.black),
              textAlign: TextAlign.center,
            ),
          );
        },
        itemBuilder: (context, subject, index) {
          return Container(
            padding: const EdgeInsets.only(
                left: EdgeMargin.min, right: EdgeMargin.min),
            child: Card(
                color: globalColor.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0.w))),
                child: Container(
                  width: widget.itemWidth,
                  padding: const EdgeInsets.only(
                      left: EdgeMargin.min,
                      right: EdgeMargin.min,
                      bottom: EdgeMargin.min,
                      top: EdgeMargin.min),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Center(
                          child: Container(
                            width: 32,
                            height: 32,
                            color: globalColor.scaffoldBackGroundGreyColor,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SvgPicture.asset(
                                AppAssets.wallet_drawer,
                                width: 10.w,
                                color: globalColor.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      HorizontalPadding(
                        percentage: 2.5,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${subject.opreate_name ?? ''} ${subject.description ?? ''}',
                              style: textStyle.smallTSBasic.copyWith(
                                  color: globalColor.black,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              text: TextSpan(
                                text: Translations.of(context)
                                    .translate('amount_added'),
                                style: textStyle.minTSBasic
                                    .copyWith(color: globalColor.black),
                                children: <TextSpan>[
                                  new TextSpan(
                                      text:
                                          '  ${subject.amount ?? ''} ${Translations.of(context).translate('rail')}',
                                      style: textStyle.minTSBasic.copyWith(
                                          color: globalColor.primaryColor,
                                          fontWeight: FontWeight.w600)),
                                  new TextSpan(
                                    text:
                                        ' ${Translations.of(context).translate('For_your_account')} ',
                                    style: textStyle.minTSBasic
                                        .copyWith(color: globalColor.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: globalColor.white,
                                borderRadius: BorderRadius.circular(12.0.w),
                                border: Border.all(
                                    color: globalColor.grey.withOpacity(0.3),
                                    width: 0.5)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  EdgeMargin.sub,
                                  EdgeMargin.sub,
                                  EdgeMargin.sub,
                                  EdgeMargin.sub),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(
                                    '${Translations.of(context).translate('view')}',
                                    style: textStyle.minTSBasic.copyWith(
                                      color: globalColor.black,
                                    ),
                                  ),
                                  Icon(
                                    utils.getLang() == 'ar'
                                        ? Icons.keyboard_arrow_left
                                        : Icons.keyboard_arrow_right,
                                    color: globalColor.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
        getItems: (subjects) {},
        loader: (pageSize, pageIndex) {
          return GetWalletTransactions(locator<CoreRepository>())(
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
                      // Container(
                      //   //margin: const EdgeInsets.only(left:EdgeMargin.min,right: EdgeMargin.min),
                      //   width: 148.w,
                      //   height: 41.h,
                      //   color: globalColor.scaffoldBackGroundGreyColor,
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //
                      //       HorizontalPadding(
                      //         percentage: 1,
                      //       ),
                      //       BaseShimmerWidget(
                      //         child: Container(
                      //           width: 40,
                      //           height: 6,
                      //           color: Colors.white,
                      //
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
