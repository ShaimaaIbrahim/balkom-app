import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/utils.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/list/build_grid_product.dart';
import 'package:get/get.dart' as Get;

class SearchPage extends StatefulWidget {
  static const routeName = '/search/presentation/SearchPage';

  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  final _controller = TextEditingController();
  var _listKey = GlobalKey();

  var _searchCancelToken = CancelToken();

  Map<String, String>? searchParams = {};

  final args = Get.Get.arguments as Map<String, String>?;

  @override
  void initState() {
    super.initState();
    if (args != null) searchParams = args;
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      brightness: Brightness.light,
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      elevation: 0,
      title: Container(
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.w),
          border:
              Border.all(color: globalColor.grey.withOpacity(0.5), width: .5),
          color: globalColor.white,
        ),
        child: TextField(
          maxLines: null,
          style: textStyle.minTSBasic.copyWith(
            color: globalColor.black,
          ),
          cursorColor: globalColor.black,
          textDirection:
              utils.getLang() == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          decoration: InputDecoration(
            hintText: Translations.of(context).translate('hint_search'),
            hintStyle: textStyle.minTSBasic.copyWith(color: globalColor.grey),
            prefixIcon: IconButton(
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: Icon(
                Icons.search,
                color: globalColor.black,
                size: 18.w,
              ),
              onPressed: () {
                String text = _controller.value.text.trim();
                if (text.isNotEmpty) {
//                    WidgetsBinding.instance
//                        .addPostFrameCallback((_) => _controller.clear());
                  _refreshList();
                }
              },
            ),
            fillColor: globalColor.white,
            suffixIcon: IconButton(
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: Icon(
                Icons.clear,
                color: globalColor.black,
                size: 18.w,
              ),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  WidgetsBinding.instance!
                      .addPostFrameCallback((_) => _controller.clear());

                  _refreshList(
                    isClearSearch: true,
                  );
                }
              },
            ),
            border: InputBorder.none,
          ),
          onChanged: (_) {
            _refreshList();
          },
          onSubmitted: (_) {
            String text = _controller.value.text.trim();
            if (text.isNotEmpty) {
              _refreshList();
            }
          },
          controller: _controller,
          textInputAction: TextInputAction.search,
        ),
      ),
      iconTheme: IconThemeData(color: globalColor.black),
      backgroundColor: globalColor.appBar,
      actions: [
        // InkWell(
        //   onTap: (){
        //     Get.Get.toNamed(FilterSearchPage.routeName);
        //   },
        //   child: Container(
        //       padding: const EdgeInsets.all(EdgeMargin.min),
        //       child: Center(child: SvgPicture.asset(AppAssets.filter,color: globalColor.primaryColor,))),
        // )
      ],
    );

    double widthC = globalSize.setWidthPercentage(100, context);
    double heightC = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      backgroundColor: globalColor.scaffoldBackGroundWhiteColor,
      appBar: appBar,
      resizeToAvoidBottomInset: false,
      body: Container(
          width: widthC,
          height: heightC,
          key: _listKey,
          child: BuildGridProductWidget(
            cancelToken: _searchCancelToken,
            itemWidth: globalSize.setWidthPercentage(43, context),
            itemHeight: globalSize.setWidthPercentage(60, context),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: globalSize.setWidthPercentage(43, context) /
                  globalSize.setWidthPercentage(60, context),
            ),
            isEnablePagination: true,
            isEnableRefresh: true,
            isFromSearchPage: true,
            params: searchParams!,
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _searchCancelToken.cancel();
  }

  void _refreshList({bool isClearSearch = false}) {
    _searchCancelToken.cancel();
    _searchCancelToken = CancelToken();
    _listKey = GlobalKey();
    searchParams = {};
    searchParams!.putIfAbsent('search', () => _controller.text);
    /*  searchParams!.putIfAbsent('order', () => 'asc');
    searchParams!.putIfAbsent('sort', () => 'date');*/

    setState(() {});
  }
}
