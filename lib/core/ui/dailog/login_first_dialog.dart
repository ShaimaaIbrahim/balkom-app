import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/features/user_management/presentation/pages/sign_in_page.dart';

class LoginFirstDialog extends StatefulWidget {
  // final String title;
  // final String confirmMessage;
  // final String messageYes;
  // final Function() actionYes;
  // final Function() actionNo;
  // final double heightC;
  // const LoginFirstDialog({
  //   this.title,
  //   this.confirmMessage,
  //   this.heightC = 150,
  //   this.messageYes,
  //   this.actionYes,
  //   this.actionNo,
  // });

  bool? title;
  LoginFirstDialog({this.title});

  @override
  State<StatefulWidget> createState() => _LoginFirstDialogState();
}

class _LoginFirstDialogState extends State<LoginFirstDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));
//    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticOut);
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: const EdgeInsets.all(EdgeMargin.big),
              padding: const EdgeInsets.all(EdgeMargin.small),
              decoration: ShapeDecoration(
                  color: globalColor.white,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(10)))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${Translations.of(context).translate('disclaimer')}',
                    style: textStyle.bigTSBasic.copyWith(
                        color: globalColor.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  widget.title == null
                      ? Container(
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
                        )
                      : Container(
                          margin: EdgeInsets.only(
                              left: EdgeMargin.subMin,
                              right: EdgeMargin.subMin,
                              top: EdgeMargin.subMin),
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            '${Translations.of(context).translate('msg_disclaimer2')}',
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
                                      borderRadius: BorderRadius.circular(5.0)),
                                  splashColor: Colors.white.withAlpha(40),
                                  child: Text(
                                    '${Translations.of(context).translate('login')}',
                                    textAlign: TextAlign.center,
                                    style: textStyle.minTSBasic
                                        .copyWith(color: globalColor.white),
                                  ),
                                  onPressed: () {
                                    Get.Get.back();
                                    Get.Get.toNamed(SignInPage.routeName);
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
                                            BorderRadius.circular(5.0)),
                                    splashColor: Colors.white.withAlpha(40),
                                    child: Text(
                                      Translations.of(context)
                                          .translate('register_as_guest'),
                                      textAlign: TextAlign.center,
                                      style: textStyle.minTSBasic
                                          .copyWith(color: globalColor.black),
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
      ),
    );
  }
}
