import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/entities/brand_entity.dart';
import 'package:ojos_app/core/entities/extra_glasses_item_entity.dart';
import 'package:ojos_app/core/errors/bad_request_error.dart';
import 'package:ojos_app/core/errors/connection_error.dart';
import 'package:ojos_app/core/errors/custom_error.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/widget/button/rounded_button.dart';
import 'package:ojos_app/core/ui/widget/general_widgets/error_widgets.dart';
import 'package:ojos_app/features/product/presentation/blocs/brands_bloc.dart';
import 'package:ojos_app/features/test/presentation/widgets/start_testing_select_widget.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/xternal_lib/model_progress_hud.dart';
import 'lenses_brands_select_widget.dart';

class LensesCompanyPage extends StatefulWidget {
  static const routeName =
      '/features/products/presentation/widgets/LensesCompanyPage';

  @override
  _LensesCompanyPageState createState() => _LensesCompanyPageState();
}

class _LensesCompanyPageState extends State<LensesCompanyPage> {
  bool? _isSelected;
  BrandEntity? _styleSelected;
  GlobalKey _globalKey = GlobalKey();
  var _cancelToken = CancelToken();
  List<BrandEntity> brands = [];
  var _bloc = BrandsBloc();
  @override
  void initState() {
    super.initState();
    _isSelected = false;
    _bloc.add(GetBrandsEvent(cancelToken: _cancelToken));
  }

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
        Translations.of(context).translate('choose_company'),
        style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
      ),
      centerTitle: true,
    );
    double widthC = globalSize.setWidthPercentage(100, context);
    double heightC = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
        backgroundColor: globalColor.scaffoldBackGroundGreyColor,
        appBar: appBar,
        key: _globalKey,
        body: BlocListener<BrandsBloc, BrandsState>(
          bloc: _bloc,
          listener: (BuildContext context, state) async {
            if (state is BrandsDoneState) {
              brands = state.brands!;
            }
            if (state is BrandsFailureState) {
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
          child: BlocBuilder<BrandsBloc, BrandsState>(
              bloc: _bloc,
              builder: (BuildContext context, state) {
                return ModalProgressHUD(
                    inAsyncCall: state is BrandsLoadingState,
                    color: globalColor.primaryColor,
                    opacity: 0.2,
                    child: Container(
                        width: widthC,
                        height: heightC,
                        // color: globalColor.white,
                        child: Column(
                          children: [
                            Container(
                              alignment: AlignmentDirectional.centerStart,
                              padding: const EdgeInsets.only(
                                  left: EdgeMargin.min, right: EdgeMargin.min),
                              child: Text(
                                Translations.of(context)
                                    .translate('select_the_brand_of_glasses'),
                                style: textStyle.middleTSBasic.copyWith(
                                    color: globalColor.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      BrandsLensesSelectWidget(
                                        onSelected: _onSelectedStyle,
                                        items: brands,
                                        width: widthC,
                                        height: heightC - 83.h,
                                      ),
                                    ],
                                  )),
                            ),
                            _buildButtonsWidget(
                                height: heightC,
                                context: context,
                                widthC: widthC),
                          ],
                        )));
              }),
        ));
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
                onPressed: _styleSelected == null
                    ? () {}
                    : () {
                        /// pop with result
                        // if(widget.onSelect!=null){
                        //   widget.onSelect(1,'style_glasses');
                        //   widget.controller.nextPage(
                        //       duration: kTabScrollDuration, curve: Curves.ease);
                        // }
                        Get.Get.back(result: _styleSelected);
                      },
                borderRadius: 8.w,
                child: Container(
                  child: Center(
                    child: Text(
                      Translations.of(context).translate('continue'),
                      style: textStyle.smallTSBasic
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
                  Get.Get.back(result: null);
                },
                borderRadius: 8.w,
                child: Container(
                  child: Center(
                    child: Text(
                      Translations.of(context).translate('cancel'),
                      style: textStyle.smallTSBasic
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

  _onSelectedStyle(BrandEntity selected) {
    if (mounted)
      setState(() {
        _styleSelected = selected;
      });
    print('style selected is ${_styleSelected.toString()}');
  }

  @override
  void dispose() {
    _bloc.close();
    _cancelToken.cancel();
    super.dispose();
  }
}
