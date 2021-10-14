
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ojos_app/core/localization/translations.dart';

import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/list/build_list_category.dart';
import 'package:ojos_app/features/home/data/models/category_model.dart';
import 'package:ojos_app/features/home/presentation/widget/item_category.dart';
import 'package:ojos_app/features/section/presentation/widgets/item_section.dart';



class SectionPage extends StatefulWidget {
  static const routeName = '/section/pages/SectionPage';

  @override
  _SectionPageState createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
 List<CategoryModel> _itemsCategory = [
  CategoryModel(id: 1, imageUrl: AppAssets.section_sun_glasses, title: 'نظارات شمسية'),
  CategoryModel(id: 2, imageUrl: AppAssets.section_med_glasses, title: 'نظارات طبيه'),
  CategoryModel(id: 3, imageUrl: AppAssets.cat_2, title: 'عدسات لاصقه'),
  CategoryModel(id: 4, imageUrl: AppAssets.section_box_glasses, title: 'اكسسوارات'),
   CategoryModel(id: 1, imageUrl: AppAssets.section_rmosh, title: 'رموش'),
  CategoryModel(id: 2, imageUrl: AppAssets.section_lens, title: 'عدسات'),
   CategoryModel(id: 1, imageUrl: AppAssets.section_sun_glasses, title: 'نظارات شمسية'),
  CategoryModel(id: 2, imageUrl: AppAssets.section_med_glasses, title: 'نظارات طبيه'),
  CategoryModel(id: 3, imageUrl: AppAssets.cat_2, title: 'عدسات لاصقه'),
  CategoryModel(id: 4, imageUrl: AppAssets.section_box_glasses, title: 'اكسسوارات'),
   CategoryModel(id: 1, imageUrl: AppAssets.section_rmosh, title: 'رموش'),
  CategoryModel(id: 2, imageUrl: AppAssets.section_lens, title: 'عدسات'),

  ];

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
        Translations.of(context).translate('section'),
        style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
      ),
      centerTitle: true,
    );

    double widthC = globalSize.setWidthPercentage(100, context);
    double heightC = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery
            .of(context)
            .viewPadding
            .top;




    return Scaffold(
        appBar: appBar,
        key: _scaffoldKey,
        body: Container(
          child: BuildListCategoryWidget(
            params: {},
            cancelToken:_cancelToken ,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
                childAspectRatio:
                globalSize.setWidthPercentage(40, context) /
                    globalSize.setWidthPercentage(40, context),
              ),
          )
        ));
  }

  // _buildGrid(){
  //   return GridView.builder(
  //       padding: const EdgeInsets.only(left: EdgeMargin.small,right:EdgeMargin.small),
  //       itemCount: _itemsCategory.length,
  //       shrinkWrap: true,
  //       gridDelegate:
  //       SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         crossAxisSpacing: 4,
  //         mainAxisSpacing: 4,
  //         childAspectRatio:
  //         globalSize.setWidthPercentage(40, context) /
  //             globalSize.setWidthPercentage(40, context),
  //       ),
  //       itemBuilder: (context, index) {
  //         return ItemSection(
  //           categoryModel: _itemsCategory[index],
  //           height: globalSize.setWidthPercentage(40, context),
  //           width: globalSize.setWidthPercentage(40, context),
  //         );
  //       });
  // }
  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }
}
