import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ojos_app/core/entities/faqs_entity.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/screen_helper.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/items_shimmer/base_shimmer.dart';
import 'package:ojos_app/core/ui/widget/network/network_sperated_list_without_refresh.dart';
import 'package:ojos_app/core/usecases/get_faqs.dart';
import 'package:ojos_app/features/others/presentation/pages/sub_pages/questions_answers_page.dart';

import '../../../main.dart';

class BuildListFaqsWidget extends StatefulWidget {
  final Map<String, String> params;

  final CancelToken cancelToken;

  final double? listWidth;
  final double? listHeight;

  final double? itemWidth;
  final double? itemHeight;

  final bool isScrollList;

  final bool isEnableRefresh;
  final bool isEnablePagination;

  //final bool isFromLearningPage;
  final Axis listScrollDirection;

  //final bool isAuth;
  final SliverGridDelegate? gridDelegate;

  const BuildListFaqsWidget({
    required this.params,
    required this.cancelToken,
    this.listWidth = 100,
    this.listHeight = 100,
    this.itemHeight,
    this.itemWidth,
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

class BuildListNotificationsWidgetState extends State<BuildListFaqsWidget>
    with AutomaticKeepAliveClientMixin<BuildListFaqsWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    double widthC =
        globalSize.setWidthPercentage(widget.listWidth ?? 100, context);
    double heightC =
        globalSize.setHeightPercentage(widget.listHeight ?? 100, context);

    return Container(
      width: widthC,
      // height: heightC,
      child: NetworkSperatedListWithoutRefresh<FaqsEntity>(
        enablePagination: widget.isEnablePagination,
        enableRefresh: widget.isEnableRefresh,
        isScroll: widget.isScrollList,
        placeHolder: (context) {
          return Center(
            child: Text(
              Translations.of(context).translate('no_faqs'),
              style: textStyle.smallTSBasic.copyWith(color: globalColor.black),
              textAlign: TextAlign.center,
            ),
          );
        },
        itemBuilder: (context, subject, index) {
          return QuestionsAnswersItemWidget(
            width: widget.itemWidth!,
            questionsAnswers: subject,
          );
        },
        getItems: (subjects) {},
        loader: (pageSize, pageIndex) {
          return GetFaqs(locator<CoreRepository>())(
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
                return _itemShimmer(
                    width: widget.itemWidth ?? ScreensHelper.fromWidth(85));
              });
        },
      ),
    );
  }

  _itemShimmer({double? width}) {
    return Container(
      width: width,
      height: 55,
      padding:
          EdgeInsets.only(left: EdgeMargin.subMin, right: EdgeMargin.subMin),
      child: Row(
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
