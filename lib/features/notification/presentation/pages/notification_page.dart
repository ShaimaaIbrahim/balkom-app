import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/utils.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/list/build_list_notifications.dart';
import 'package:ojos_app/core/ui/widget/title_with_view_all_widget.dart';
import 'package:ojos_app/features/home/data/models/category_model.dart';
import 'package:ojos_app/features/notification/data/models/notification_model.dart';
import 'package:ojos_app/features/notification/presentation/widgets/item_notification_widget.dart';

class NotificationPage extends StatefulWidget {
  static const routeName = '/notification/pages/NotificationPage';

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<NotificationModel> _list;
  initList() {
    _list = [
      NotificationModel(
          title: 'الملف الشخصي',
          image: AppAssets.profile_nav_bar,
          subTitle: 'لديك بيانات غير مدخلة في ملفك الشخصي'),
      NotificationModel(
          title: 'المفضلة',
          image: AppAssets.love,
          subTitle: 'تم إضافة نظارة لوكس الشمسية للمفضلة'),
      NotificationModel(
          title: 'الأقسام',
          image: AppAssets.section_nav_bar,
          subTitle: 'تم إضافة اقسام جديدة '),
      NotificationModel(
          title: 'المحفظة',
          image: AppAssets.wallet_drawer,
          subTitle: 'تم إضافة مبلغ 500 ريال لحسابك'),
      NotificationModel(
          title: 'التقييمات',
          image: AppAssets.review_drawer,
          subTitle: 'تم ارسال التقييم الخاص بك بنجاح'),
      NotificationModel(
          title: 'العروض',
          image: AppAssets.sales_svg,
          subTitle: 'تم نشر العديد من العروض الجديدة '),
      NotificationModel(
          title: 'الدعم الفني',
          image: AppAssets.supported_team_svg,
          subTitle: 'اذا عندك أي استفسارات تواصل معنا'),
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey _globalKey = GlobalKey();
  var _cancelToken = CancelToken();

  @override
  Widget build(BuildContext context) {
    initList();
    //=========================================================================

    AppBar appBar = AppBar(
      backgroundColor: globalColor.appBar,
      brightness: Brightness.light,
      elevation: 0,
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      title: Text(
        Translations.of(context).translate('notifications'),
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
            key: _globalKey,
            height: height,
            child: BuildListNotificationsWidget(
              cancelToken: _cancelToken,
              onUpdate: _onUpdate,
              isEnablePagination: true,
              isEnableRefresh: true,
              params: {},
              itemWidth: width,
            )));
  }

  _onUpdate() {
    _globalKey = GlobalKey();
    if (mounted) setState(() {});
  }

  _buildCoponTextWidget({
    required BuildContext context,
    required double width,
    required double height,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        // border:
        // Border.all(color: globalColor.primaryColor.withOpacity(0.3), width: 0.5),
      ),
      //   margin: const EdgeInsets.only(left: EdgeMargin.verySub,),
      height: height,
      width: width,

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: Container(
                  width: 32,
                  height: 32,
                  color: globalColor.goldColor,
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
          ),
          Expanded(
            flex: 4,
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'اجمالي الرصيد',
                    style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '360',
                    style: textStyle.bigTSBasic.copyWith(
                        color: globalColor.goldColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${Translations.of(context).translate('rail')}',
                    style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: globalColor.white,
                      borderRadius: BorderRadius.circular(12.0.w),
                      border: Border.all(
                          color: globalColor.grey.withOpacity(0.3),
                          width: 0.5)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(EdgeMargin.sub,
                        EdgeMargin.sub, EdgeMargin.sub, EdgeMargin.sub),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(
                          'طرق الدفع',
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
          ),
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
