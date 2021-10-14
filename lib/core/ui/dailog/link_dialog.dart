//import 'package:ojos_app/core/localization/translations.dart';
//import 'package:ojos_app/core/res/edge_margin.dart';
//import 'package:ojos_app/core/res/global_color.dart';
//import 'package:ojos_app/core/res/text_style.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//import '../../appConfig.dart';
//
//class OpenLinkDialog extends StatefulWidget {
//  final String title;
//  final String confirmMessage;
//  final String messageYes;
//  final Function() actionYes;
//  final Function() actionNo;
//  final double heightC;
//  final String link;
//
//  const OpenLinkDialog({
//    this.title,
//    this.confirmMessage,
//    this.heightC = 150,
//    this.messageYes,
//    this.link,
//    this.actionYes,
//    this.actionNo,
//  });
//
//  @override
//  State<StatefulWidget> createState() => OpenLinkDialogState();
//}
//
//class OpenLinkDialogState extends State<OpenLinkDialog>
//    with SingleTickerProviderStateMixin {
//  AnimationController controller;
//  Animation<double> scaleAnimation;
//
//  @override
//  void initState() {
//    super.initState();
//
//    controller =
//        AnimationController(vsync: this, duration: Duration(milliseconds: 750));
////    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticOut);
//    scaleAnimation =
//        CurvedAnimation(parent: controller, curve: Curves.easeOutBack);
//
//    controller.addListener(() {
//      setState(() {});
//    });
//
//    controller.forward();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Center(
//      child: Material(
//        color: Colors.transparent,
//        child: ScaleTransition(
//          scale: scaleAnimation,
//          child: Container(
//              margin: const EdgeInsets.all(EdgeMargin.big),
//              padding: const EdgeInsets.all(EdgeMargin.small),
//              //             height: ScreenUtil().setHeight(widget.heightC),
//              decoration: ShapeDecoration(
//                  color: globalColor.white,
//                  shape: RoundedRectangleBorder(
//                      borderRadius:
//                          BorderRadius.circular(ScreenUtil().setWidth(10)))),
//              child: Column(
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  Text(
//                    Translations.of(context).translate(widget.title),
//                    style: textStyle.normalTextPrimary,
//                  ),
//                  Container(
//                    margin: EdgeInsets.only(
//                        left: EdgeMargin.subMin,
//                        right: EdgeMargin.subMin,
//                        top: EdgeMargin.subMin),
//                    alignment: AlignmentDirectional.centerStart,
//                    child: Text(
//                        Translations.of(context)
//                            .translate(widget.confirmMessage),
//                        style: textStyle.smallTextSecondry),
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    children: <Widget>[
//                      Container(
//                        child: ButtonTheme(
//                          height: ScreenUtil().setHeight(35),
//                          minWidth: ScreenUtil().setWidth(110),
//                          child: RaisedButton(
//                            color: Colors.white,
//                            shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(5.0)),
//                            splashColor: Colors.white.withAlpha(40),
//                            child: Text(
//                              widget.messageYes ??
//                                  Translations.of(context).translate('yes'),
//                              textAlign: TextAlign.center,
//                              style: textStyle.subMinGreen,
//                            ),
//                            onPressed: widget.actionYes ??
//                                () {
//                                  Navigator.of(context).pop();
//                                  appConfig.launchURL(widget.link ?? "");
//                                },
//                          ),
//                        ),
//                      ),
//                      Container(
//                        child: ButtonTheme(
//                          height: ScreenUtil().setHeight(35),
//                          minWidth: ScreenUtil().setWidth(110),
//                          child: RaisedButton(
//                            color: Colors.white,
//                            shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(5.0)),
//                            splashColor: Colors.white.withAlpha(40),
//                            child: Text(
//                              Translations.of(context).translate('cancel'),
//                              textAlign: TextAlign.center,
//                              style: textStyle.subMinRed,
//                            ),
//                            onPressed: widget.actionNo ??
//                                () {
//                                  Navigator.of(context).pop();
//                                },
//                          ),
//                        ),
//                      ),
//                    ],
//                  )
//                ],
//              )),
//        ),
//      ),
//    );
//  }
//}
