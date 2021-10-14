import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/features/test/presentation/pages/steps/face_shape_section_page.dart';
import 'package:ojos_app/features/test/presentation/pages/steps/face_size_section_page.dart';
import 'package:ojos_app/features/test/presentation/pages/steps/select_color_section_page.dart';
import 'package:ojos_app/features/test/presentation/pages/steps/shape_frame_lenses_section_page.dart';
import 'package:ojos_app/features/test/presentation/pages/steps/start_testing_section_page.dart';
import 'package:ojos_app/features/test/presentation/pages/steps/style_glasses_section_page.dart';
import 'package:ojos_app/features/test/presentation/pages/test_result_page.dart';
import 'package:steps_indicator/steps_indicator.dart';
import 'package:get/get.dart' as Get;
class MainTestPage extends StatefulWidget {
  static const routeName = '/test/pages/MainTestPage';

  @override
  _MainTestPageState createState() => _MainTestPageState();
}

class _MainTestPageState extends State<MainTestPage> {
  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey _key = GlobalKey();
  var _cancelToken = CancelToken();

  Map<String, String> searchParams = {};

  int selectedStep = 0;
  int nbSteps = 7;

  String _title = 'start_test';

  PageController controller =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);

  //Current page
  var currentPageValue = 0.0;

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
        Translations.of(context).translate(_title),
        style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
      ),
      centerTitle: true,
    );

    double width = globalSize.setWidthPercentage(100, context);
    double height = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: appBar,
          key: _scaffoldKey,
          backgroundColor: globalColor.scaffoldBackGroundGreyColor,
          body: Container(
              height: height,
              child: Container(
                  child: Column(
                children: [
                  Container(
                    key: _key,
                    height: height * .08,
                    // color: globalColor.red,
                    color: globalColor.scaffoldBackGroundGreyColor,
                    child: StepsIndicator(
                      selectedStep: selectedStep,
                      nbSteps: nbSteps,
                      lineLength: 20,
                      isHorizontal: true,
                      selectedStepColorIn: globalColor.goldColor,
                      doneLineColor: globalColor.primaryColor,
                      doneStepColor: globalColor.goldColor,
                      selectedStepColorOut: globalColor.primaryColor,
                      unselectedStepColorIn: globalColor.white,
                      unselectedStepColorOut: globalColor.grey.withOpacity(0.3),
                      undoneLineColor: globalColor.grey.withOpacity(0.3),
                      selectedStepSize: 25.w,
                      unselectedStepSize: 25.w,
                      doneStepSize: 25.w,
                      selectedStepBorderSize: 1.0,
                      unselectedStepBorderSize: 1.0,
                      doneLineThickness: 1.5,
                      undoneLineThickness: 1.0,
                      doneStepWidget: Container(
                        decoration: BoxDecoration(
                            color: globalColor.goldColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: globalColor.primaryColor, width: 1.0)),
                        width: 24.w,
                        height: 24.w,
                      ),
                      // lineLengthCustomStep: [
                      //   StepsIndicatorCustomLine(nbStep: 4, lenght: 105)
                      // ],
                    ),
                  ),
                  Container(
                    color: globalColor.scaffoldBackGroundGreyColor,
                    height: height - (height * .08),
                    child: PageView(
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        StartTestingSectionPage(
                          controller: controller,
                          height: height - (height * .08),
                          width: width,
                          onSelect: _onSelectItemType,
                        ),
                        StyleGlassesSectionPage(
                          controller: controller,
                          height: height - (height * .08),
                          width: width,
                          onSelect: _onSelectItemGender,
                        ),
                        FaceSizeSectionPage(
                          controller: controller,
                          height: height - (height * .08),
                          width: width,
                          onSelect: _onSelectItemFaceSize,
                        ),
                        FaceShapeSectionPage(
                          controller: controller,
                          height: height - (height * .08),
                          width: width,
                          onSelect: _onSelectItemFaceShape,
                        ),
                        ShapeOfFrameAndLensesSectionPage(
                          controller: controller,
                          height: height - (height * .08),
                          width: width,
                          onSelect: _onSelectItemFrameShape,
                        ),
                        SelectColorSectionPage(
                          controller: controller,
                          height: height - (height * .08),
                          width: width,
                          onSelect: _onSelectItemColor,
                          doneAction: _doneAction,
                        ),

                        // StartTestingSectionPage(
                        //   controller: controller,
                        //   height: height - (height * .08),
                        //   width: width,
                        //   onSelect: _onSelectItem,
                        // ),
                      ],
                    ),
                  ),
                ],
              )))),
    );
  }

  Future<bool> _onWillPop() {
    switch(selectedStep){
      case 0:
        if(mounted)
          {
            Get.Get.back();
            return Future.value(true);
          }
        break;
      case 1:
        if(mounted)
        {
          _title = 'start_test';
          _key = GlobalKey();
          selectedStep = 0;
          controller.previousPage(
              duration: kTabScrollDuration, curve: Curves.ease);
          setState(() {});
        }
        break;

        case 2:
        if(mounted)
        {
          _title = 'style_glasses';
          _key = GlobalKey();
          selectedStep = 1;
          controller.previousPage(
              duration: kTabScrollDuration, curve: Curves.ease);
          setState(() {});
        }
        break;
        case 3:
        if(mounted)
        {
          _title = 'face_size';
          _key = GlobalKey();
          selectedStep = 2;
          controller.previousPage(
              duration: kTabScrollDuration, curve: Curves.ease);
          setState(() {});
        }
        break;

        case 4:
        if(mounted)
        {
          _title = 'face_shape';
          _key = GlobalKey();
          selectedStep = 3;
          controller.previousPage(
              duration: kTabScrollDuration, curve: Curves.ease);
          setState(() {});
        }
        break;

        case 5:
        if(mounted)
        {
          _title = 'select_the_shape_of_the_frame_and_lenses';
          _key = GlobalKey();
          selectedStep = 4;
          controller.previousPage(
              duration: kTabScrollDuration, curve: Curves.ease);
          setState(() {});
        }
        break;

        case 6:
        if(mounted)
        {
          _title = 'select_color';
          _key = GlobalKey();
          selectedStep = 5;
          controller.previousPage(
              duration: kTabScrollDuration, curve: Curves.ease);
          setState(() {});
        }
        break;
    }
      return Future.value(false);
    }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }



  _onSelectItem(int index,String title) {
    if (mounted)
      setState(() {
        _key = GlobalKey();
        selectedStep = index;
        _title = title;
      });
    print('style selected is ${selectedStep.toString()}');
  }
  _onSelectItemType(int index,String title,int id) {
    if (mounted)
      setState(() {
        _key = GlobalKey();
        selectedStep = index;
        searchParams.putIfAbsent('type', () => id.toString());
        _title = title;
      });
    print('style selected is ${selectedStep.toString()}');
  }
  _onSelectItemGender(int index,String title,int id) {
    if (mounted)
      setState(() {
        _key = GlobalKey();
        selectedStep = index;
        searchParams.putIfAbsent('gender_id', () => id.toString());
        _title = title;
      });
    print('style selected is ${selectedStep.toString()}');
  }
  _onSelectItemFaceSize(int index,String title,int id) {
    if (mounted)
      setState(() {
        _key = GlobalKey();
        selectedStep = index;
        searchParams.putIfAbsent('sizes', () => [id].toString());
        _title = title;
      });
    print('style selected is ${selectedStep.toString()}');
  }
  _onSelectItemFrameShape(int index,String title,int id) {
    if (mounted)
      setState(() {
        _key = GlobalKey();
        selectedStep = index;
        searchParams.putIfAbsent('frame_shape', () => id.toString());
        _title = title;
      });
    print('style selected is ${selectedStep.toString()}');
  }
  _onSelectItemColor(int index,String title,int id) {
    if (mounted)
      setState(() {
        _key = GlobalKey();
        selectedStep = index;
        searchParams.putIfAbsent('color_id', () => [id].toString());
        _title = title;
      });
    print('style selected is ${selectedStep.toString()}');
  }
  _onSelectItemFaceShape(int index,String title,int id) {
    if (mounted)
      setState(() {
        _key = GlobalKey();
        selectedStep = index;
        searchParams.putIfAbsent('face_shape', () => id.toString());
        _title = title;
      });
    print('style selected is ${selectedStep.toString()}');
  }
  _doneAction(){
    Get.Get.toNamed(TestResultPage.routeName,arguments: searchParams);
  }
}
