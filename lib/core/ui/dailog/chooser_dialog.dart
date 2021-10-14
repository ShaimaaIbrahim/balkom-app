import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/icon_size.dart';
import 'package:ojos_app/core/res/text_style.dart';

class ChooserDialog extends StatefulWidget {
  final Function()? actionGallery;
  final Function()? actionCamera;

  const ChooserDialog(
      {required this.actionCamera, required this.actionGallery});

  @override
  State<StatefulWidget> createState() => ChooserDialogState();
}

class ChooserDialogState extends State<ChooserDialog>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
            margin: const EdgeInsets.all(EdgeMargin.big),
            padding: const EdgeInsets.all(EdgeMargin.small),
            width: 250.w,
            decoration: ShapeDecoration(
                color: globalColor.white,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(10)))),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: widget.actionGallery,
                  child: Container(
                    height: ScreenUtil().setHeight(50),
                    width: 200.w,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            child: Icon(
                          Icons.photo,
                          size: IconSize.subLarge,
                          color: globalColor.primaryColor.withOpacity(0.7),
                        )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                            child: Text(
                          Translations.of(context).translate('gallery'),
                          style: textStyle.normalTSBasic.copyWith(
                              color: globalColor.primaryColor.withOpacity(0.7)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        )),
                      ],
                    ),
                  ),
                ),
                _divider(200.w),
                InkWell(
                  onTap: widget.actionCamera,
                  child: Container(
                    height: ScreenUtil().setHeight(50),
                    width: 200.w,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            child: Icon(
                          Icons.camera,
                          size: IconSize.subLarge,
                          color: globalColor.primaryColor.withOpacity(0.7),
                        )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                            child: Text(
                          Translations.of(context).translate('camera'),
                          style: textStyle.normalTSBasic.copyWith(
                              color: globalColor.primaryColor.withOpacity(0.7)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _divider(double width) {
    return Container(
      width: width,
      child: Divider(
        height: 10.h,
        color: globalColor.basic2.withOpacity(0.2),
        thickness: 1,
      ),
    );
  }
}
