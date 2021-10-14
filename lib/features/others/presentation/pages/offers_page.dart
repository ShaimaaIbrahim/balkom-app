import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/errors/connection_error.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/items_shimmer/home/offer_item_shimmer.dart';
import 'package:ojos_app/features/home/presentation/blocs/offer_bloc.dart';
import 'package:ojos_app/features/home/presentation/widget/item_offer_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/item_offer_page_middle_widget.dart';

class OffersPage extends StatefulWidget {
  static const routeName = '/others/pages/OffersPage';

  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  var _offerBloc = OfferBloc();

  PageController controller =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  PageController controller2 =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  PageController controller3 =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  PageController controller4 =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  PageController controller5 =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);

  @override
  void initState() {
    super.initState();
    _offerBloc.add(SetupOfferEvent(cancelToken: _cancelToken));
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _cancelToken = CancelToken();

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
        Translations.of(context).translate('offers_drawer'),
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
        body: Container(
            height: height,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                child: Column(
                  children: [
                    VerticalPadding(
                      percentage: 2.0,
                    ),
                    _buildTopAds(
                        context: context, width: width, height: height),
                    VerticalPadding(
                      percentage: 2.0,
                    ),
                    _buildMiddle2Ads(
                        context: context, width: width, height: height),
                    VerticalPadding(
                      percentage: 2.0,
                    ),
                    _buildMiddle1Ads(
                        context: context, width: width, height: height),
                    VerticalPadding(
                      percentage: 2.0,
                    ),
                    _buildBottom1Ads(
                        context: context, width: width, height: height),
                    VerticalPadding(
                      percentage: 2.0,
                    ),
                    _buildBottom2Ads(
                        context: context, width: width, height: height),
                    VerticalPadding(
                      percentage: 4.0,
                    ),
                  ],
                ),
              ),
            )));
  }

  _buildTopAds({required BuildContext context, double? width, double? height}) {
    return BlocListener<OfferBloc, OfferState>(
      bloc: _offerBloc,
      listener: (BuildContext context, state) async {
        if (state is OfferDoneState) {
          // _navigateTo(context, state.extraGlassesEntity);
        }
      },
      child: BlocBuilder<OfferBloc, OfferState>(
          bloc: _offerBloc,
          builder: (BuildContext context, state) {
            if (state is OfferFailureState) {
              return Container(
                width: width,
                height: 184.h,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                            (state.error is ConnectionError)
                                ? Translations.of(context)
                                    .translate('err_connection')
                                : Translations.of(context)
                                    .translate('err_unexpected'),
                            style: textStyle.normalTSBasic
                                .copyWith(color: globalColor.accentColor)),
                      ),
                      RaisedButton(
                        onPressed: () {
                          _offerBloc
                              .add(SetupOfferEvent(cancelToken: _cancelToken));
                        },
                        elevation: 1.0,
                        child: Text(Translations.of(context).translate('retry'),
                            style: textStyle.smallTSBasic
                                .copyWith(color: globalColor.white)),
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is OfferDoneState) {
              if (state.offer!.topHome != null &&
                  state.offer!.topHome.isNotEmpty) {
                return Container(
                  width: width,
                  height: 184.h,
                  child: Stack(
                    children: [
                      PageView(
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: state.offer!.topHome
                            .map((item) => ItemOfferWidget(
                                  offerItem: item,
                                  width: width,
                                ))
                            .toList(),
                      ),
                      Positioned(
                          bottom: 10,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  EdgeMargin.small, 0.0, EdgeMargin.small, 0.0),
                              child: _buildPageIndicator(
                                  width: width!,
                                  controller: controller,
                                  count: state.offer!.topHome.length)))
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }

            return Container(
              width: width,
              height: 184.h,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    EdgeMargin.small, 0.0, EdgeMargin.small, 0.0),
                child: HomeAdsItemShimmer(
                  height: 184,
                  width: width,
                ),
              ),
            );
          }),
    );
  }

  _buildMiddle2Ads(
      {required BuildContext context, double? width, double? height}) {
    return BlocListener<OfferBloc, OfferState>(
      bloc: _offerBloc,
      listener: (BuildContext context, state) async {
        if (state is OfferDoneState) {
          // _navigateTo(context, state.extraGlassesEntity);
        }
      },
      child: BlocBuilder<OfferBloc, OfferState>(
          bloc: _offerBloc,
          builder: (BuildContext context, state) {
            if (state is OfferFailureState) {
              return Container(
                width: width,
                height: 184.h,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                            (state.error is ConnectionError)
                                ? Translations.of(context)
                                    .translate('err_connection')
                                : Translations.of(context)
                                    .translate('err_unexpected'),
                            style: textStyle.normalTSBasic
                                .copyWith(color: globalColor.accentColor)),
                      ),
                      RaisedButton(
                        onPressed: () {
                          _offerBloc
                              .add(SetupOfferEvent(cancelToken: _cancelToken));
                        },
                        elevation: 1.0,
                        child: Text(Translations.of(context).translate('retry'),
                            style: textStyle.smallTSBasic
                                .copyWith(color: globalColor.white)),
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is OfferDoneState) {
              if (state.offer!.middleTwoHome != null &&
                  state.offer!.middleTwoHome.isNotEmpty) {
                return Container(
                  width: width,
                  height: 200.h,
                  child: Stack(
                    children: [
                      PageView(
                        controller: controller2,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: state.offer!.middleTwoHome
                            .map((item) => ItemOfferMiddlePageWidget(
                                  offerItem: item,
                                  width: width,
                                ))
                            .toList(),
                      ),
                      Positioned(
                          bottom: 55.h,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  EdgeMargin.small, 0.0, EdgeMargin.small, 0.0),
                              child: _buildPageIndicator(
                                  width: width!,
                                  controller: controller2,
                                  count: state.offer!.middleTwoHome.length)))
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }

            return Container(
              width: width,
              height: 184.h,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    EdgeMargin.small, 0.0, EdgeMargin.small, 0.0),
                child: HomeAdsItemShimmer(
                  height: 184,
                  width: width,
                ),
              ),
            );
          }),
    );
  }

  _buildMiddle1Ads(
      {required BuildContext context, double? width, double? height}) {
    return BlocListener<OfferBloc, OfferState>(
      bloc: _offerBloc,
      listener: (BuildContext context, state) async {
        if (state is OfferDoneState) {
          // _navigateTo(context, state.extraGlassesEntity);
        }
      },
      child: BlocBuilder<OfferBloc, OfferState>(
          bloc: _offerBloc,
          builder: (BuildContext context, state) {
            if (state is OfferFailureState) {
              return Container(
                width: width,
                height: 184.h,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                            (state.error is ConnectionError)
                                ? Translations.of(context)
                                    .translate('err_connection')
                                : Translations.of(context)
                                    .translate('err_unexpected'),
                            style: textStyle.normalTSBasic
                                .copyWith(color: globalColor.accentColor)),
                      ),
                      RaisedButton(
                        onPressed: () {
                          _offerBloc
                              .add(SetupOfferEvent(cancelToken: _cancelToken));
                        },
                        elevation: 1.0,
                        child: Text(Translations.of(context).translate('retry'),
                            style: textStyle.smallTSBasic
                                .copyWith(color: globalColor.white)),
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is OfferDoneState) {
              if (state.offer!.middleOneHome != null &&
                  state.offer!.middleOneHome.isNotEmpty) {
                return Container(
                  width: width,
                  height: 184.h,
                  child: Stack(
                    children: [
                      PageView(
                        controller: controller3,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: state.offer!.middleOneHome
                            .map((item) => ItemOfferWidget(
                                  offerItem: item,
                                  width: width,
                                ))
                            .toList(),
                      ),
                      Positioned(
                          bottom: 10,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  EdgeMargin.small, 0.0, EdgeMargin.small, 0.0),
                              child: _buildPageIndicator(
                                  width: width!,
                                  controller: controller3,
                                  count: state.offer!.middleOneHome.length)))
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }

            return Container(
              width: width,
              height: 184.h,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    EdgeMargin.small, 0.0, EdgeMargin.small, 0.0),
                child: HomeAdsItemShimmer(
                  height: 184,
                  width: width,
                ),
              ),
            );
          }),
    );
  }

  _buildBottom1Ads(
      {required BuildContext context, double? width, double? height}) {
    return BlocListener<OfferBloc, OfferState>(
      bloc: _offerBloc,
      listener: (BuildContext context, state) async {
        if (state is OfferDoneState) {
          // _navigateTo(context, state.extraGlassesEntity);
        }
      },
      child: BlocBuilder<OfferBloc, OfferState>(
          bloc: _offerBloc,
          builder: (BuildContext context, state) {
            if (state is OfferFailureState) {
              return Container(
                width: width,
                height: 184.h,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                            (state.error is ConnectionError)
                                ? Translations.of(context)
                                    .translate('err_connection')
                                : Translations.of(context)
                                    .translate('err_unexpected'),
                            style: textStyle.normalTSBasic
                                .copyWith(color: globalColor.accentColor)),
                      ),
                      RaisedButton(
                        onPressed: () {
                          _offerBloc
                              .add(SetupOfferEvent(cancelToken: _cancelToken));
                        },
                        elevation: 1.0,
                        child: Text(Translations.of(context).translate('retry'),
                            style: textStyle.smallTSBasic
                                .copyWith(color: globalColor.white)),
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is OfferDoneState) {
              if (state.offer!.bottomOneHome != null &&
                  state.offer!.bottomOneHome.isNotEmpty) {
                return Container(
                  width: width,
                  height: 184.h,
                  child: Stack(
                    children: [
                      PageView(
                        controller: controller4,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: state.offer!.bottomOneHome
                            .map((item) => ItemOfferWidget(
                                  offerItem: item,
                                  width: width,
                                ))
                            .toList(),
                      ),
                      Positioned(
                          bottom: 10,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  EdgeMargin.small, 0.0, EdgeMargin.small, 0.0),
                              child: _buildPageIndicator(
                                  width: width!,
                                  controller: controller4,
                                  count: state.offer!.bottomOneHome.length)))
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }

            return Container(
              width: width,
              height: 184.h,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    EdgeMargin.small, 0.0, EdgeMargin.small, 0.0),
                child: HomeAdsItemShimmer(
                  height: 184,
                  width: width,
                ),
              ),
            );
          }),
    );
  }

  _buildBottom2Ads(
      {required BuildContext context, double? width, double? height}) {
    return BlocListener<OfferBloc, OfferState>(
      bloc: _offerBloc,
      listener: (BuildContext context, state) async {
        if (state is OfferDoneState) {
          // _navigateTo(context, state.extraGlassesEntity);
        }
      },
      child: BlocBuilder<OfferBloc, OfferState>(
          bloc: _offerBloc,
          builder: (BuildContext context, state) {
            if (state is OfferFailureState) {
              return Container(
                width: width,
                height: 184.h,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                            (state.error is ConnectionError)
                                ? Translations.of(context)
                                    .translate('err_connection')
                                : Translations.of(context)
                                    .translate('err_unexpected'),
                            style: textStyle.normalTSBasic
                                .copyWith(color: globalColor.accentColor)),
                      ),
                      RaisedButton(
                        onPressed: () {
                          _offerBloc
                              .add(SetupOfferEvent(cancelToken: _cancelToken));
                        },
                        elevation: 1.0,
                        child: Text(Translations.of(context).translate('retry'),
                            style: textStyle.smallTSBasic
                                .copyWith(color: globalColor.white)),
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is OfferDoneState) {
              if (state.offer!.bottomTwoHome != null &&
                  state.offer!.bottomTwoHome.isNotEmpty) {
                return Container(
                  width: width,
                  height: 184.h,
                  child: Stack(
                    children: [
                      PageView(
                        controller: controller5,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: state.offer!.bottomTwoHome
                            .map((item) => ItemOfferWidget(
                                  offerItem: item,
                                  width: width,
                                ))
                            .toList(),
                      ),
                      Positioned(
                          bottom: 10,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  EdgeMargin.small, 0.0, EdgeMargin.small, 0.0),
                              child: _buildPageIndicator(
                                  width: width!,
                                  controller: controller5,
                                  count: state.offer!.bottomTwoHome.length)))
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }

            return Container(
              width: width,
              height: 184.h,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    EdgeMargin.small, 0.0, EdgeMargin.small, 0.0),
                child: HomeAdsItemShimmer(
                  height: 184,
                  width: width,
                ),
              ),
            );
          }),
    );
  }

  _buildPageIndicator({double? width, int? count, PageController? controller}) {
    return count == 1
        ? Container(
            alignment: AlignmentDirectional.center,
            width: width!,
            child: SmoothPageIndicator(
                controller: controller!, //// PageController
                count: count!,
                effect: WormEffect(
                  spacing: 8.0,
                  radius: 12.0,
                  dotWidth: 12.0,
                  dotHeight: 12.0,
                  dotColor: Colors.white,
                  paintStyle: PaintingStyle.fill,
                  strokeWidth: 2,
                  activeDotColor: globalColor.goldColor,
                ), // your preferred effect
                onDotClicked: (index) {}),
          )
        : Container();
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    _offerBloc.close();
    super.dispose();
  }
}
