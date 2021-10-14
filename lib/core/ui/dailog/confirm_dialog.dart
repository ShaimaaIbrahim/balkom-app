import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';

class ConfirmDialog extends StatefulWidget {
  final String? title;
  final String? confirmMessage;
  final String? messageYes;
  final Function()? actionYes;
  final Function()? actionNo;
  final double? heightC;

  const ConfirmDialog({
    this.title,
    this.confirmMessage,
    this.heightC = 150,
    this.messageYes,
    this.actionYes,
    this.actionNo,
  });

  @override
  State<StatefulWidget> createState() => ConfirmDialogState();
}

class ConfirmDialogState extends State<ConfirmDialog>
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
              // height: ScreenUtil().setHeight(widget.heightC),
              decoration: ShapeDecoration(
                  color: globalColor.white,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(10)))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${widget.title ?? ''}',
                    style: textStyle.bigTSBasic.copyWith(
                        color: globalColor.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: EdgeMargin.subMin,
                        right: EdgeMargin.subMin,
                        top: EdgeMargin.subMin),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '${widget.confirmMessage ?? ''}',
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
                                    '${Translations.of(context).translate('confirm')}',
                                    textAlign: TextAlign.center,
                                    style: textStyle.minTSBasic
                                        .copyWith(color: globalColor.white),
                                  ),
                                  onPressed: widget.actionYes)),
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
                                          .translate('cancel'),
                                      textAlign: TextAlign.center,
                                      style: textStyle.minTSBasic
                                          .copyWith(color: globalColor.black),
                                    ),
                                    onPressed: widget.actionNo))),
                      ),
                    ],
                  ),
                  // Expanded(
                  //     child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: <Widget>[
                  //     Container(
                  //       child: ButtonTheme(
                  //           height: ScreenUtil().setHeight(35),
                  //           minWidth: ScreenUtil().setWidth(110),
                  //           child: RaisedButton(
                  //               color: Colors.white,
                  //               shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(5.0)),
                  //               splashColor: Colors.white.withAlpha(40),
                  //               child: Text(
                  //                 widget.messageYes ??
                  //                     'Yes',
                  //                 textAlign: TextAlign.center,
                  //                 style: textStyle.minTSBasic.copyWith(color: globalColor.basic1),
                  //               ),
                  //               onPressed: widget.actionYes)),
                  //     ),
                  //     Container(
                  //         child: ButtonTheme(
                  //             height: ScreenUtil().setHeight(35),
                  //             minWidth: ScreenUtil().setWidth(110),
                  //             child: RaisedButton(
                  //                 color: Colors.white,
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(5.0)),
                  //                 splashColor: Colors.white.withAlpha(40),
                  //                 child: Text(
                  //                   Translations.of(context).translate('cancel'),
                  //                   textAlign: TextAlign.center,
                  //                   style: textStyle.minTSBasic.copyWith(color: Colors.redAccent),
                  //                 ),
                  //                 onPressed: widget.actionNo))),
                  //   ],
                  // ))
                ],
              )),
        ),
      ),
    );
  }
}
