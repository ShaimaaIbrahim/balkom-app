import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/core/bloc/application_bloc.dart';
import 'package:ojos_app/core/bloc/application_events.dart';
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/core/database/db.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/utils.dart';

class LanguageDialog extends StatefulWidget {
  final Function()? actionArabic;
  final Function()? actionEnglish;

  const LanguageDialog({this.actionArabic, this.actionEnglish});

  @override
  State<StatefulWidget> createState() => LanguageDialogState();
}

class LanguageDialogState extends State<LanguageDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final lang = BlocProvider.of<ApplicationBloc>(context).state.language ?? '';

    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              width: ScreenUtil().setWidth(270),
              margin: const EdgeInsets.all(EdgeMargin.big),
              padding: const EdgeInsets.all(EdgeMargin.small),
              decoration: ShapeDecoration(
                  color: globalColor.white,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(10)))),
              child: Wrap(
//                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${Translations.of(context).translate('change_language')}',
                    style: textStyle.normalTSBasic,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  moreDivider(),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  _getArabicButton(lang),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  _getEnglishButton(lang),
                ],
              )),
        ),
      ),
    );
  }

  Widget _getEnglishButton(String lang) {
    bool correctLang = lang == LANG_EN;
    return GestureDetector(
      onTap: () async {
        if (correctLang) {
          Navigator.pop(context);
          return;
        }

        await AppDB.clear();
        var locale = Locale('en');
        utils.setLang('en');
        Get.Get.updateLocale(locale);
        BlocProvider.of<ApplicationBloc>(context)
            .add(SetEnglishLanguageEvent());
        //  RestartWidget.restartApp(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'English',
              style: textStyle.smallTSBasic,
            ),
            Icon(
              correctLang
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: correctLang
                  ? globalColor.primaryColor
                  : globalColor.buttonColorSecondary,
            ),
          ],
        ),
      ),
    );
  }

  bool _isLoading = false;

  Widget _getArabicButton(String lang) {
    bool correctLang = lang == LANG_AR;
    return GestureDetector(
      onTap: () async {
        if (correctLang) {
          Navigator.pop(context);
          return;
        }
//
//        setState(() {
//          _isLoading = true;
//        });
//        final result = await ChangeAppLanguage(locator<CoreRepository>())(
//          ChangeAppLanguageParams(lang: LANG_AR),
//        );
//        if (result.hasErrorOnly) {
//          setState(() {
//            _isLoading = false;
//          });
////          Fluttertoast.showToast(
////            msg: Translations.of(context).translate('err_lang'),
////            backgroundColor: globalColor.black1,
////            textColor: Colors.white,
////          );
//        } else {
//          setState(() {
//            _isLoading = false;
//          });
        {
          await AppDB.clear();
          var locale = Locale('ar');
          utils.setLang('ar');
          Get.Get.updateLocale(locale);
          BlocProvider.of<ApplicationBloc>(context)
              .add(SetArabicLanguageEvent());
          // RestartWidget.restartApp(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'العربية',
              style: textStyle.smallTSBasic,
            ),
            Icon(
              correctLang
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: correctLang
                  ? globalColor.primaryColor
                  : globalColor.buttonColorSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Divider moreDivider() => new Divider(
        height: 5.0,
        color: globalColor.buttonColorSecondary,
      );
}
