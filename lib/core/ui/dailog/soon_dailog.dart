import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/bloc/application_bloc.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';

class SoonDialog extends StatefulWidget {
  final Function()? actionArabic;
  final Function()? actionEnglish;

  const SoonDialog({this.actionArabic, this.actionEnglish});

  @override
  State<StatefulWidget> createState() => LanguageDialogState();
}

class LanguageDialogState extends State<SoonDialog>
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
      // setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final lang = BlocProvider.of<ApplicationBloc>(context).state.language;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  VerticalPadding(
                    percentage: 2.0,
                  ),
                  Text(
                    '${Translations.of(context).translate('soon')}',
                    style: textStyle.normalTSBasic,
                  ),
                  VerticalPadding(
                    percentage: 2.0,
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Divider moreDivider() => new Divider(
        height: 5.0,
        color: globalColor.buttonColorSecondary,
      );
}
