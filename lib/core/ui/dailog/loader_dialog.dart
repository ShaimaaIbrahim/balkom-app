import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/utils.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LoaderDialog extends StatefulWidget {
  final int imagesCount;
  final int numberOfImageUploaded;
  final Function() actionCancel;

  const LoaderDialog({
    required this.numberOfImageUploaded,
    required this.imagesCount,
    required this.actionCancel,
  });

  @override
  State<StatefulWidget> createState() => LoaderDialogState();
}

class LoaderDialogState extends State<LoaderDialog>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          alignment: AlignmentDirectional.center,
          margin: EdgeInsets.only(
            top: EdgeMargin.subMin,
          ),
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              reverse: true,
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    Container(
                      child: Card(
                        color: globalColor.white,
                        elevation: 2.0,
                        child: Container(
                          width: ScreenUtil().setWidth(270),
                          margin: const EdgeInsets.all(
                            EdgeMargin.small,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  '${Translations.of(context).translate('publishing')}',
                                  style: textStyle.normalTSBasic.copyWith(
                                      color: globalColor.primaryColor),
                                ),
                              ),
                              Divider(
                                height: ScreenUtil().setHeight(20),
                              ),
                              widget.imagesCount != 0
                                  ? Container(
                                      width: ScreenUtil().setWidth(250),
                                      child: FittedBox(
                                        child: LinearPercentIndicator(
                                          backgroundColor: globalColor.grey,
                                          width: ScreenUtil().setWidth(250),
                                          lineHeight: 6.0,
                                          percent:
                                              widget.numberOfImageUploaded /
                                                  widget.imagesCount,
                                          animation: true,
                                          progressColor:
                                              globalColor.accentColor,
                                          isRTL: utils.getLang() == 'ar'
                                              ? true
                                              : false,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: ScreenUtil().setWidth(250),
                                      child: LinearPercentIndicator(
                                        backgroundColor: globalColor.grey,
                                        width: ScreenUtil().setWidth(250),
                                        lineHeight: 6.0,
                                        percent: 1,
                                        animation: true,
                                        progressColor: globalColor.accentColor,
                                        isRTL: utils.getLang() == 'ar'
                                            ? true
                                            : false,
                                      ),
                                    ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              Container(
                                child: Text(
                                  '${widget.numberOfImageUploaded} / ${widget.imagesCount}',
                                  style: textStyle.smallTSBasic.copyWith(
                                      color: globalColor.primaryColor),
                                ),
                              ),
//                              SizedBox(height: ScreenUtil().setHeight(35)),
//
//                              Container(
//                                width: ScreenUtil().setWidth(250),
//                                alignment: AlignmentDirectional.bottomEnd,
//                                child: Container(
//                                  child: InkWell(
//                                    onTap: widget.actionCancel,
//                                    child: Padding(
//                                      padding: const EdgeInsets.all(4.0),
//                                      child: Text(Translations.of(context).translate('cancel'),
//                                      style: textStyle.smallTSBasic.copyWith(color: globalColor.primaryColor),),
//                                    ),
//                                  ),
//                                ),
//                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
