import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/items_shimmer/base_shimmer.dart';
import 'package:ojos_app/core/ui/widget/network/network_widget.dart';
import 'package:ojos_app/features/others/domain/entity/about_app_result.dart';
import 'package:ojos_app/features/others/domain/usecases/get_about_app.dart';
import 'package:ojos_app/features/others/presentation/widgets/custom_section_about.dart';
import 'package:ojos_app/features/others/presentation/widgets/sectionAbout.dart';
import 'package:ojos_app/features/others/presentation/widgets/section_about_with_custom_child.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../main.dart';

class AboutOjosPage extends StatefulWidget {
  static const routeName = '/others/sub_pages/pages/AboutOjosPage';

  @override
  _AboutOjosPageState createState() => _AboutOjosPageState();
}

class _AboutOjosPageState extends State<AboutOjosPage> {
  @override
  void initState() {
    super.initState();
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
        Translations.of(context).translate('about_ojos'),
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
        body: NetworkWidget<AboutAppResult>(
          loadingWidgetBuilder: (BuildContext context) {
            return Container(
              width: width,
              height: height,
              child: BaseShimmerWidget(
                child: Container(
                  color: Colors.white,
                ),
              ),
            );
          },
          fetcher: () {
            return GetAboutApp(locator<CoreRepository>())(
              GetAboutAppParams(
                cancelToken: _cancelToken,
              ),
            );
          },
          builder: (BuildContext context, aboutAppResult) {
            return Container(
              height: height,
              color: globalColor.white,
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //============= about section with description ===============
                        SectionAbout(
                          icon: Icons.info_outline,
                          title: Translations.of(context).translate('about_us'),
                          description: aboutAppResult.site_desc,
                        ),
                        CustomSectionAbout(
                          svg: AppAssets.address,
                          title: Translations.of(context).translate('address'),
                          description: aboutAppResult.address,
                        ),
                        SectionAboutWithCustomChild(
                          icon: Icons.contact_mail,
                          title:
                              Translations.of(context).translate("contact_us"),
                          description: buildContactUs(aboutAppResult, width),
                        ),

                        buildVersionNumberWithPhoto(width),
                      ],
                    ),
                  )),
            );
          },
        ));
  }

  Widget buildVersionNumberWithPhoto(double widthC) {
    return Container(
      width: widthC,
      margin: const EdgeInsets.only(
          top: EdgeMargin.big,
          left: EdgeMargin.min,
          right: EdgeMargin.min,
          bottom: EdgeMargin.subSubMin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            AppAssets.splashLogo,
//            width: ScreenUtil().setWidth(91),
            height: ScreenUtil().setHeight(85),
          ),
          SizedBox(
            height: EdgeMargin.subSubMin,
          ),
        ],
      ),
    );
  }

  Widget buildContactUs(AboutAppResult? aboutAppResult, double widthC) {
    return Padding(
      padding: EdgeInsets.only(top: EdgeMargin.sub),
      child: new Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: EdgeMargin.sub),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  onPressed: () => _lunchSocialMediaAction(
                      context, aboutAppResult?.address ?? ''),
                  icon: Icon(
                    Icons.web,
                    color: globalColor.primaryColor,
                    size: 30.0,
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      _callMobile(context, aboutAppResult?.mobile ?? ''),
                  icon: SvgPicture.asset(
                    AppAssets.phone_sq,
                    width: 30,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      _callMobile(context, aboutAppResult?.phone ?? ''),
                  icon: SvgPicture.asset(
                    AppAssets.telephone,
                    width: 30,
                    color: globalColor.basic1,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    String configEmail =
                        'mailto:${aboutAppResult?.email ?? "email@gmail.com"}'
                        '?subject=Email about $APP_NAME   &'
                        'body=Thank you for a such great App';
                    _lunchSocialMediaAction(context, configEmail);
                  },
                  icon: SvgPicture.asset(
                    AppAssets.gmail,
                    width: 30,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: SvgPicture.asset(
                    AppAssets.facebook,
                    width: 35,
                    fit: BoxFit.cover,
                  ),
                  onPressed: () => _lunchSocialMediaAction(
                      context, aboutAppResult?.facebook ?? 'www.facebook.com'),
                ),
                // IconButton(
                //   icon: Icon(
                //     AntDesign.linkedin_square,
                //     size: 30.0,
                //     color: Color(0xFF0e76a8),
                //   ),
                //   onPressed: () =>
                //       _lunchSocialMediaAction(context, aboutAppResult.linkedin),
                // ),
                IconButton(
                  icon: SvgPicture.asset(
                    AppAssets.twitter,
                    width: 35,
                    fit: BoxFit.cover,
                  ),
                  onPressed: () => _lunchSocialMediaAction(
                      context, aboutAppResult?.twitter ?? 'www.twitter.com'),
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    AppAssets.instagram,
                    width: 35,
                    fit: BoxFit.cover,
                  ),
                  onPressed: () => _lunchSocialMediaAction(context,
                      aboutAppResult?.instagram ?? 'www.instagram.com'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _callMobile(BuildContext context, String mobile) async {
    // Android
    if (Platform.isAndroid) {
      var uri = 'tel:+$mobile';
      if (await canLaunch(uri)) await launch(uri);
    } else if (Platform.isIOS) {
      // iOS
      //   var uri = 'tel:+963-949-954-951';

      int j = 0;
      String mobileNumber = "";
      if (mobile != null)
        for (int i = 0; i < mobile.length; ++i, j++) {
          mobileNumber += mobile[i];
          if (j == 2) {
            mobileNumber += "-";
            j = 0;
          }
        }
      var uri = 'tel:+$mobileNumber';
      if (await canLaunch(uri)) await launch(uri);
    } else {
      // var uri = 'tel:+963 949 954 951';
      var uri = 'tel:+$mobile';
      if (await canLaunch(uri))
        await launch(uri);
      else
        onError(context);
    }
  }

  onError(BuildContext context) {
    Fluttertoast.showToast(
      msg: Translations.of(context).translate('err_unexpected'),
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _lunchSocialMediaAction(BuildContext context, String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      onError(context);
    }
  }

  _launchMap(BuildContext context, lat, lng) async {
    var url = '';
    var urlAppleMaps = '';
    if (Platform.isAndroid) {
      url = "https://www.google.com/maps/search/?api=1&query=${lat},${lng}";
    } else {
      urlAppleMaps = 'https://maps.apple.com/?q=$lat,$lng';
      url = "comgooglemaps://?saddr=&daddr=$lat,$lng&directionsmode=driving";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else if (await canLaunch(urlAppleMaps)) {
      await launch(urlAppleMaps);
    } else {
      throw 'Could not launch $url';
    }
  }

  buildOurLocation(AboutAppResult aboutAppResult, double widthC) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            aboutAppResult.address!,
            style: textStyle.middleTSBasic
                .copyWith(color: globalColor.primaryColor),
            maxLines: 3,
            overflow: TextOverflow.fade,
          ),
          constraints: BoxConstraints(maxWidth: widthC * 0.78),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }
}
