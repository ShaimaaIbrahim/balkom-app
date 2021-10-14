import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojos_app/core/errors/bad_request_error.dart';
import 'package:ojos_app/core/errors/connection_error.dart';
import 'package:ojos_app/core/errors/custom_error.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/widget/button/rounded_button.dart';
import 'package:ojos_app/core/ui/widget/general_widgets/error_widgets.dart';
import 'package:ojos_app/core/ui/widget/title_with_view_all_widget.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/presentation/widgets/item_product_home_widget.dart';
import 'package:ojos_app/features/test/presentation/blocs/test_bloc.dart';
import 'package:ojos_app/xternal_lib/model_progress_hud.dart';

import 'main_test_page.dart';
import 'test_result_view_all_page.dart';

class TestResultPage extends StatefulWidget {
  static const routeName = '/test/pages/TestResultPage';

  @override
  _TestResultPageState createState() => _TestResultPageState();
}

class _TestResultPageState extends State<TestResultPage> {
  final args = Get.Get.arguments as Map<String, dynamic>;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey _key = GlobalKey();
  var _cancelToken = CancelToken();

  int selectedStep = 0;
  int nbSteps = 7;

  String _title = 'start_test';

  List<ProductEntity> result = [];
  var _bloc = TestBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetTestEvent(cancelToken: _cancelToken, filterParams: args));
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
        Translations.of(context).translate('the_result'),
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
        key: _scaffoldKey,
        backgroundColor: globalColor.scaffoldBackGroundGreyColor,
        body: BlocListener<TestBloc, TestState>(
          bloc: _bloc,
          listener: (BuildContext context, state) async {
            if (state is TestDoneState) {
              result = state.list!;
            }
            if (state is TestFailureState) {
              final error = state.error;
              if (error is ConnectionError) {
                ErrorViewer.showCustomError(context,
                    Translations.of(context).translate('err_connection'));
              } else if (error is CustomError) {
                ErrorViewer.showCustomError(context, error.message);
              } else if (error is BadRequestError) {
                ErrorViewer.showCustomError(context, error.message);
              } else {
                ErrorViewer.showUnexpectedError(context);
              }
            }
          },
          child: BlocBuilder<TestBloc, TestState>(
              bloc: _bloc,
              builder: (BuildContext context, state) {
                if (state is TestLoadingState) {
                  return Container(
                      height: height,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ));
                }
                return ModalProgressHUD(
                    inAsyncCall: state is TestLoadingState,
                    color: globalColor.primaryColor,
                    opacity: 0.2,
                    child: Container(
                        height: height,
                        child: Column(
                          children: [
                            Expanded(
                              child: _buildTopSection(
                                  context: context,
                                  height: height * .7,
                                  width: width),
                            ),
                            VerticalPadding(
                              percentage: 1,
                            ),
                            _buildMenProduct(
                                context: context, height: height, width: width),
                            VerticalPadding(
                              percentage: 1,
                            ),
                          ],
                        )));
              }),
        ));
  }

  _buildTopSection(
      {required BuildContext context,
      required double width,
      required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: globalColor.white,
          borderRadius: BorderRadius.all(Radius.circular(12.w))),
      child: Column(
        children: [
          VerticalPadding(
            percentage: 3,
          ),
          Expanded(
            child: Container(
              width: width * .85,
              child: SvgPicture.asset(
                AppAssets.test_result_svg,
                width: width * .85,
              ),
            ),
          ),
          VerticalPadding(
            percentage: 0.5,
          ),
          _buildResultTextWidget(
              width: width, context: context, height: height),
          // VerticalPadding(percentage: 0.5,),
          Container(
            padding: const EdgeInsets.only(
                left: EdgeMargin.lager, right: EdgeMargin.lager),
            child: Text(
              Translations.of(context).translate('text_result_msg'),
              style: textStyle.smallTSBasic.copyWith(color: globalColor.black),
              textAlign: TextAlign.center,
            ),
          ),
          // VerticalPadding(percentage: 2.5,),
          _buildButtonsWidget(height: height, context: context, widthC: width),

          VerticalPadding(
            percentage: 1.5,
          ),
        ],
      ),
    );
  }

  _buildButtonsWidget(
      {required BuildContext context,
      required double widthC,
      required double height}) {
    return Container(
      height: 80.h,
      width: widthC,
      color: globalColor.white,
      child: Center(
        child: Container(
          height: 50.h,
          padding: const EdgeInsets.only(
              left: EdgeMargin.min, right: EdgeMargin.min),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  child: RoundedButton(
                height: 50.h,
                width: widthC * .35,
                color: globalColor.primaryColor,
                onPressed: () {
                  Get.Get.toNamed(TestResultVeiwAllPage.routeName,
                      arguments: result);
                },
                borderRadius: 8.w,
                child: Container(
                  child: Center(
                    child: Text(
                      Translations.of(context).translate('view_all_results'),
                      style: textStyle.minTSBasic
                          .copyWith(color: globalColor.white),
                    ),
                  ),
                ),
              )),
              HorizontalPadding(
                percentage: 4.0,
              ),
              Container(
                  child: RoundedButton(
                height: 50.h,
                width: widthC * .35,
                color: globalColor.backgroundLightPrim,
                onPressed: () {
                  Get.Get.back();
                  Get.Get.offAndToNamed(MainTestPage.routeName);
                },
                borderRadius: 8.w,
                child: Container(
                  child: Center(
                    child: Text(
                      Translations.of(context).translate('Retesting'),
                      style: textStyle.minTSBasic
                          .copyWith(color: globalColor.black),
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  _buildResultTextWidget({
    required BuildContext context,
    required double width,
    required double height,
  }) {
    return Container(
      // decoration: BoxDecoration(
      //   color: globalColor.primaryColor,
      //   borderRadius: BorderRadius.all(Radius.circular(12.w)),
      //   // border:
      //   // Border.all(color: globalColor.primaryColor.withOpacity(0.3), width: 0.5),
      // ),
      //   margin: const EdgeInsets.only(left: EdgeMargin.verySub,),
      width: width,

      child: Wrap(
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          SizedBox(
            width: 1.w,
          ),
          Text(
            Translations.of(context).translate('congratulations'),
            style: textStyle.lagerTSBasic.copyWith(
                color: globalColor.primaryColor, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 1.w,
          ),
          Text(
            Translations.of(context).translate('Found'),
            style: textStyle.normalTSBasic.copyWith(
                color: globalColor.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 2.w,
          ),
          Text(
            result.length.toString(),
            style: textStyle.normalTSBasic.copyWith(
                color: globalColor.primaryColor, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 2.w,
          ),
          Text(
            Translations.of(context).translate('matching_style'),
            style: textStyle.normalTSBasic.copyWith(
                color: globalColor.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  _buildMenProduct(
      {required BuildContext context,
      required double width,
      required double height}) {
    return Container(
      key: _key,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: EdgeMargin.small, right: EdgeMargin.small),
            child: TitleWithViewAllWidget(
              width: width,
              title: Translations.of(context).translate('some_results'),
              onClickView: () {
                Get.Get.toNamed(TestResultVeiwAllPage.routeName,
                    arguments: result);
              },
              strViewAll: Translations.of(context).translate('view_all'),
            ),
          ),
          result != null && result.isNotEmpty
              ? Container(
                  height: globalSize.setWidthPercentage(60, context),
                  alignment: AlignmentDirectional.centerStart,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: result.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemProductHomeWidget(
                          height: globalSize.setWidthPercentage(60, context),
                          width: globalSize.setWidthPercentage(47, context),
                          product: result[index],
                        );
                      }))
              : Container(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }
}
