import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/items_shimmer/base_shimmer.dart';
import 'package:ojos_app/core/ui/widget/network/network_widget.dart';
import 'package:ojos_app/features/others/domain/entity/privacy_result.dart';
import 'package:ojos_app/features/others/domain/usecases/get_privacy.dart';

import '../../../../../main.dart';

class MembershipSystemPage extends StatefulWidget {
  static const routeName = '/others/sub_pages/pages/MembershipSystemPage';

  @override
  _MembershipSystemPageState createState() => _MembershipSystemPageState();
}

class _MembershipSystemPageState extends State<MembershipSystemPage> {
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
        Translations.of(context).translate('membership_system'),
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
        body: NetworkWidget<PrivacyAppResult>(
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
            return GetPrivacyApp(locator<CoreRepository>())(
              GetPrivacyAppParams(
                isPrivacyApp: false,
                cancelToken: _cancelToken,
              ),
            );
          },
          builder: (BuildContext context, aboutAppResult) {
            return Container(
                height: height,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    child: Column(
                      children: [
                        VerticalPadding(
                          percentage: 2.0,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: EdgeMargin.min, right: EdgeMargin.min),
                          child: _buildTextWidget(
                              width: width,
                              context: context,
                              title: aboutAppResult.details),
                        ),
                        VerticalPadding(
                          percentage: 4.0,
                        ),
                      ],
                    ),
                  ),
                ));
          },
        ));
  }

  _buildTextWidget(
      {required BuildContext context, double? width, String? title}) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.white,
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        // border:
        // Border.all(color: globalColor.primaryColor.withOpacity(0.3), width: 0.5),
      ),
      //   margin: const EdgeInsets.only(left: EdgeMargin.verySub,),
      width: width,

      child: Padding(
        padding: const EdgeInsets.all(EdgeMargin.min),
        child: Text(
          title ?? '',
          style: textStyle.smallTSBasic
              .copyWith(color: globalColor.black, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }
}
