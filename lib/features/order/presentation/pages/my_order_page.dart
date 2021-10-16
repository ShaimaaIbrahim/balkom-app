import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojos_app/core/bloc/application_bloc.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/icon_size.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/utils.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/features/order/presentation/widgets/basic_order_list_page.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/features/user_management/presentation/pages/sign_in_page.dart';
import 'package:get/get.dart' as Get;

class MyOrderPage extends StatefulWidget {
  static const routeName = '/order/pages/MyOrderPage';

  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  int _currentIndex = 0;
  final _controller = TextEditingController();
  var _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //=========================================================================

    double width = globalSize.setWidthPercentage(100, context);

    AppBar appBar = AppBar(
      backgroundColor: globalColor.scaffoldBackGroundGreyColor,
      brightness: Brightness.light,
      elevation: 0,
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      title: Text(
        Translations.of(context).translate('order_drawer'),
        style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: Container(
          height: 110,
          width: width,
          color: globalColor.scaffoldBackGroundGreyColor,
          margin: const EdgeInsets.only(
            left: EdgeMargin.min,
            right: EdgeMargin.min,
          ),
          // decoration: BoxDecoration(
          //     color: globalColor.white,
          //     borderRadius: BorderRadius.all(Radius.circular(12.0.w)),
          //   border: Border.all(
          //     color: globalColor.grey.withOpacity(0.3),
          //   )
          // ),
          child: (BlocProvider.of<ApplicationBloc>(context)
                      .state
                      .isUserAuthenticated ||
                  BlocProvider.of<ApplicationBloc>(context)
                      .state
                      .isUserVerified)
              ? Column(
                  children: [
                    _buildSearchWidget(width: width, context: context),
                    VerticalPadding(
                      percentage: 1.0,
                    ),
                    Container(
                      height: 45,
                      width: width,
                      child: TabBar(
                        onTap: (index) {
                          if (mounted)
                            setState(() {
                              _currentIndex = index;
                              _controller.text = '';
                              _refreshList();
                            });
                        },
                        labelPadding: const EdgeInsets.all(0.0),
                        indicatorColor: globalColor.transparent,
                        tabs: [
                          Container(
                            width: width / 3,
                            // padding: const EdgeInsets.only(right:EdgeMargin.sub,left: EdgeMargin.sub),
                            decoration: BoxDecoration(
                                color: _currentIndex == 0
                                    ? globalColor.primaryColor
                                    : globalColor.white,
                                borderRadius: BorderRadius.only(
                                    bottomRight: utils.getLang() == 'ar'
                                        ? Radius.circular(12.w)
                                        : Radius.circular(0.0),
                                    topRight: utils.getLang() == 'ar'
                                        ? Radius.circular(12.w)
                                        : Radius.circular(0.0),
                                    bottomLeft: utils.getLang() == 'ar'
                                        ? Radius.circular(0.0)
                                        : Radius.circular(12.w),
                                    topLeft: utils.getLang() == 'ar'
                                        ? Radius.circular(0.0)
                                        : Radius.circular(12.w)),
                                border: Border.all(
                                  color: globalColor.grey.withOpacity(0.3),
                                )),
                            child: Center(
                              child: Text(
                                Translations.of(context).translate('new'),
                                style: textStyle.minTSBasic.copyWith(
                                    color: _currentIndex == 0
                                        ? globalColor.white
                                        : globalColor.black),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: _currentIndex == 1
                                    ? globalColor.primaryColor
                                    : globalColor.white,
                                border: Border(
                                  top: BorderSide(
                                    color: globalColor.grey.withOpacity(0.3),
                                  ),
                                  bottom: BorderSide(
                                    color: globalColor.grey.withOpacity(0.3),
                                  ),
                                )),
                            // padding: const EdgeInsets.only(right:EdgeMargin.sub,left: EdgeMargin.sub),
                            child: Center(
                              child: Text(
                                Translations.of(context).translate('finished'),
                                style: textStyle.minTSBasic.copyWith(
                                    color: _currentIndex == 1
                                        ? globalColor.white
                                        : globalColor.black),
                              ),
                            ),
                          ),
                          Container(
                            width: width / 3,
                            decoration: BoxDecoration(
                                color: _currentIndex == 2
                                    ? globalColor.primaryColor
                                    : globalColor.white,
                                borderRadius: BorderRadius.only(
                                    bottomRight: utils.getLang() != 'ar'
                                        ? Radius.circular(12.w)
                                        : Radius.circular(0.0),
                                    topRight: utils.getLang() != 'ar'
                                        ? Radius.circular(12.w)
                                        : Radius.circular(0.0),
                                    bottomLeft: utils.getLang() != 'ar'
                                        ? Radius.circular(0.0)
                                        : Radius.circular(12.w),
                                    topLeft: utils.getLang() != 'ar'
                                        ? Radius.circular(0.0)
                                        : Radius.circular(12.w)),
                                border: Border.all(
                                  color: globalColor.grey.withOpacity(0.3),
                                )),
                            //  padding: const EdgeInsets.only(right:EdgeMargin.sub,left: EdgeMargin.sub),
                            child: Center(
                              child: Text(
                                Translations.of(context).translate('canceled'),
                                style: textStyle.minTSBasic.copyWith(
                                    color: _currentIndex == 2
                                        ? globalColor.white
                                        : globalColor.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
        ),
      ),
    );

    double height = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return (BlocProvider.of<ApplicationBloc>(context)
                .state
                .isUserAuthenticated ||
            BlocProvider.of<ApplicationBloc>(context).state.isUserVerified)
        ? DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: appBar,
              backgroundColor: globalColor.scaffoldBackGroundGreyColor,
              body: Container(
                width: width,
                height: height,
                key: _listKey,
                child: TabBarView(
                  children: [
                    BasicOrderListPage(
                      height: height,
                      width: width,
                      filterParams: {
                        'order_status': 'new',
                        'search_input': _controller.text
                      },
                    ),
                    BasicOrderListPage(
                      height: height,
                      width: width,
                      filterParams: {
                        'order_status': 'finshed',
                        'search_input': _controller.text
                      },
                    ),
                    BasicOrderListPage(
                      height: height,
                      width: width,
                      filterParams: {
                        'order_status': 'canceled',
                        'search_input': _controller.text
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: appBar,
            backgroundColor: globalColor.scaffoldBackGroundGreyColor,
            body: Container(
                width: width,
                height: height,
                key: _listKey,
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                        margin: const EdgeInsets.all(EdgeMargin.big),
                        padding: const EdgeInsets.all(EdgeMargin.small),
                        decoration: ShapeDecoration(
                            color: globalColor.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setWidth(10)))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              '${Translations.of(context).translate('disclaimer')}',
                              style: textStyle.bigTSBasic.copyWith(
                                  color: globalColor.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: EdgeMargin.subMin,
                                  right: EdgeMargin.subMin,
                                  top: EdgeMargin.subMin),
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                '${Translations.of(context).translate('msg_disclaimer')}',
                                style: textStyle.minTSBasic.copyWith(
                                    color: globalColor.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            VerticalPadding(
                              percentage: 1.5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: ButtonTheme(
                                        height: 50.h,
                                        minWidth: 130.w,
                                        child: RaisedButton(
                                            color: globalColor.primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            splashColor:
                                                Colors.white.withAlpha(40),
                                            child: Text(
                                              '${Translations.of(context).translate('login')}',
                                              textAlign: TextAlign.center,
                                              style: textStyle.minTSBasic
                                                  .copyWith(
                                                      color: globalColor.white),
                                            ),
                                            onPressed: () {
                                              Get.Get.back();
                                              Get.Get.toNamed(
                                                  SignInPage.routeName);
                                            })),
                                  ),
                                ),
                                HorizontalPadding(
                                  percentage: 2,
                                ),
                                Expanded(
                                  child: Container(
                                      child: ButtonTheme(
                                          height: 50.h,
                                          minWidth: 136.w,
                                          child: RaisedButton(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              splashColor:
                                                  Colors.white.withAlpha(40),
                                              child: Text(
                                                Translations.of(context)
                                                    .translate(
                                                        'register_as_guest'),
                                                textAlign: TextAlign.center,
                                                style: textStyle.minTSBasic
                                                    .copyWith(
                                                        color:
                                                            globalColor.black),
                                              ),
                                              onPressed: () {
                                                Get.Get.back();
                                              }))),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                )),
          );
  }

  _buildSearchWidget({BuildContext? context, double? width}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: globalColor.white,
        borderRadius: BorderRadius.circular(12.0.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5, // has the effect of softening the shadow
            spreadRadius: 0, // has the effect of extending the shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      String text = _controller.value.text.trim();
                      if (text.isNotEmpty) {
//                    WidgetsBinding.instance
//                        .addPostFrameCallback((_) => _controller.clear());
                        _refreshList();
                      }
                    },
                    child: Container(
                      child: Center(
                        child: Icon(
                          Icons.search,
                          size: 28.w,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50.h,
                  color: globalColor.grey.withOpacity(0.2),
                  width: .5,
                )
              ],
            ),
          ),
          Expanded(
              flex: 6,
              child: TextField(
                onChanged: (_) {
                  _refreshList();
                },
                onSubmitted: (_) {
                  String text = _controller.value.text.trim();
                  if (text.isNotEmpty) {
                    _refreshList();
                  }
                },
                controller: _controller,
                textInputAction: TextInputAction.search,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: Translations.of(context!)
                        .translate('Find_your_product_here'),
                    hintStyle: textStyle.smallTSBasic
                        .copyWith(color: globalColor.grey)),
              )),
          // Expanded(
          //   flex: 1,
          //   child: Row(
          //     children: [
          //       Container(
          //         height: 50.h,
          //         color: globalColor.grey.withOpacity(0.2),
          //         width: .5,
          //       ),
          //       Expanded(
          //         flex: 1,
          //         child: SvgPicture.asset(
          //           AppAssets.filter,
          //           width: 22,
          //           height: 22,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  void _refreshList({bool isClearSearch = false}) {
    _listKey = GlobalKey();

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }
}
