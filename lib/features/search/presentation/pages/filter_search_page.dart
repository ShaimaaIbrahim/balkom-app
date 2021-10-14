import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/bloc/application_bloc.dart';
import 'package:ojos_app/core/entities/extra_glasses_item_entity.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/utils.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/features/profile/presentation/widgets/basic_info_page.dart';
import 'package:ojos_app/features/profile/presentation/widgets/profile_location_page.dart';
import 'package:ojos_app/features/profile/presentation/widgets/profile_protection_page.dart';
import 'package:ojos_app/features/search/presentation/widgets/for_glasses_tab_page.dart';
import 'package:ojos_app/features/search/presentation/widgets/for_lenses_tab_page.dart';

class FilterSearchPage extends StatefulWidget {
  static const routeName = '/search/pages/FilterSearchPage';

  @override
  _FilterSearchPageState createState() => _FilterSearchPageState();
}

class _FilterSearchPageState extends State<FilterSearchPage> {
  int _currentIndex = 0;
  List<ExtraGlassesItemEntity>? gender;
  List<ExtraGlassesItemEntity>? faceSize;
  @override
  void initState() {
    super.initState();
    gender =
        BlocProvider.of<ApplicationBloc>(context).state.extraGlasses?.gender ??
            [];
    faceSize = BlocProvider.of<ApplicationBloc>(context)
            .state
            .extraGlasses
            ?.sizeFace ??
        [];
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //=========================================================================

    double width = globalSize.setWidthPercentage(100, context);

    AppBar appBar = AppBar(
      backgroundColor: globalColor.white,
      brightness: Brightness.light,
      elevation: 0,
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      title: Text(
        Translations.of(context).translate('search_filter'),
        style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          height: 45,
          width: width,
          margin: const EdgeInsets.only(
            left: EdgeMargin.min,
            right: EdgeMargin.min,
          ),
          // decoration: BoxDecoration(
          //     color: globalColor.white,
          //     borderRadius: BorderRadius.all(Radius.circular(12.0.w)),
          //   border: Border.all(
          //     color: globalColor.grey.withOpacity(0.3),
          //   )
          // ),
          child: TabBar(
            onTap: (index) {
              if (mounted)
                setState(() {
                  _currentIndex = index;
                });
            },
            labelPadding: const EdgeInsets.all(0.0),
            indicatorColor: globalColor.transparent,
            tabs: [
              Container(
                width: width / 2,
                // padding: const EdgeInsets.only(right:EdgeMargin.sub,left: EdgeMargin.sub),
                decoration: BoxDecoration(
                    color: _currentIndex == 0
                        ? globalColor.primaryColor
                        : globalColor.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: utils.getLang() == 'ar'
                            ? Radius.circular(12.w)
                            : Radius.circular(0.0),
                        topRight: utils.getLang() == 'ar'
                            ? Radius.circular(12.w)
                            : Radius.circular(0.0),
                        bottomLeft: utils.getLang() == 'ar'
                            ? Radius.circular(0.0)
                            : Radius.circular(12.w),
                        topLeft: utils.getLang() == 'ar'
                            ? Radius.circular(0.0)
                            : Radius.circular(12.w)),
                    border: Border.all(
                      color: globalColor.grey.withOpacity(0.3),
                    )),
                child: Center(
                  child: Text(
                    Translations.of(context).translate('for_glasses'),
                    style: textStyle.minTSBasic.copyWith(
                        color: _currentIndex == 0
                            ? globalColor.white
                            : globalColor.black),
                  ),
                ),
              ),
              Container(
                width: width / 2,
                decoration: BoxDecoration(
                    color: _currentIndex == 1
                        ? globalColor.primaryColor
                        : globalColor.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: utils.getLang() != 'ar'
                            ? Radius.circular(12.w)
                            : Radius.circular(0.0),
                        topRight: utils.getLang() != 'ar'
                            ? Radius.circular(12.w)
                            : Radius.circular(0.0),
                        bottomLeft: utils.getLang() != 'ar'
                            ? Radius.circular(0.0)
                            : Radius.circular(12.w),
                        topLeft: utils.getLang() != 'ar'
                            ? Radius.circular(0.0)
                            : Radius.circular(12.w)),
                    border: Border.all(
                      color: globalColor.grey.withOpacity(0.3),
                    )),
                //  padding: const EdgeInsets.only(right:EdgeMargin.sub,left: EdgeMargin.sub),
                child: Center(
                  child: Text(
                    Translations.of(context).translate('for_lenses'),
                    style: textStyle.minTSBasic.copyWith(
                        color: _currentIndex == 1
                            ? globalColor.white
                            : globalColor.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    double height = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appBar,
        backgroundColor: globalColor.white,
        body: Container(
          width: width,
          height: height,
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              ForGlassesTabPage(
                width: width,
                height: height,
                itemsGlassesType: [
                  ExtraGlassesItemEntity(
                      id: 1,
                      image: AppAssets.sun_glasses_test,
                      name: Translations.of(context).translate('sunglasses'),
                      value: '1'),
                  ExtraGlassesItemEntity(
                      id: 0,
                      image: AppAssets.medical_glasses_test,
                      name: Translations.of(context).translate('Goggles'),
                      value: '0'),
                ],
                gender: gender!,
                faceSize: faceSize!,
              ),
              ForLensesTabPage(
                width: width,
                height: height,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
