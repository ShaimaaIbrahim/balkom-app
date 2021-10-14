import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/ui/widget/image/basic_avatar.dart';

class ImagesStack extends StatefulWidget {
  final double radius;
  final List<String> listOfImagesUrl;

  const ImagesStack({
    Key? key,
    required this.radius,
    required this.listOfImagesUrl,
  }) : super(key: key);

  @override
  _ImagesStackState createState() => _ImagesStackState();
}

class _ImagesStackState extends State<ImagesStack> {
  late int countOfDisplay;
  late int numberOfImages;

  @override
  void initState() {
    super.initState();
    countOfDisplay = widget.listOfImagesUrl.length > 3
        ? widget.listOfImagesUrl.length - 3
        : 0;
    numberOfImages =
        widget.listOfImagesUrl.length > 3 ? 3 : widget.listOfImagesUrl.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: (4 * widget.radius) + widget.radius + 8,
        height: widget.radius * 2 + 8,
        child: Stack(
          children: Translations.of(context).currentLanguage == 'ar'
              ? getArPositionedImages()
              : getEnPositionedImages(),
        ),
      ),
    );
  }

  List<Widget> getEnPositionedImages() {
    final list = <Widget>[];
    for (int i = 0; i < numberOfImages; i++) {
      list.add(
        Positioned(
          child: BasicAvatar(
            radius: widget.radius,
            imageUrl: widget.listOfImagesUrl[i],
            hasShadow: false,
            hasBorder: true,
          ),
          left: widget.radius * i,
        ),
      );
    }
    if (countOfDisplay != 0) {
      list.add(Positioned(
        left: widget.radius * 3,
        child: _buildOthersWidget(countOfDisplay.toString()),
      ));
    }
    return list;
  }

  List<Widget> getArPositionedImages() {
    final list = <Widget>[];
    for (int i = 0; i < numberOfImages; i++) {
      list.add(
        Positioned(
          child: BasicAvatar(
            radius: widget.radius,
            imageUrl: widget.listOfImagesUrl[i],
            hasShadow: false,
            hasBorder: true,
          ),
          right: widget.radius * i,
        ),
      );
    }
    if (countOfDisplay != 0) {
      list.add(Positioned(
        right: widget.radius * 3,
        child: _buildOthersWidget(countOfDisplay.toString()),
      ));
    }
    return list;
  }

  Widget _buildOthersWidget(String countOthers) {
    return SizedBox(
      width: ScreenUtil().setWidth(widget.radius * 2),
      height: ScreenUtil().setWidth(widget.radius * 2),
      child: Container(
        decoration: BoxDecoration(
          color: globalColor.accentColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5, // has the effect of softening the shadow
              spreadRadius: 0, // has the effect of extending the shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            '$countOthers',
            style: textStyle.subMinTSBasic
                .copyWith(color: globalColor.accentColor)
                .copyWith(color: globalColor.white),
          ),
        ),
      ),
    );
  }
}
