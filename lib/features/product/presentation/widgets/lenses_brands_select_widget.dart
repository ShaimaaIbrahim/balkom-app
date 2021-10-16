import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ojos_app/core/entities/brand_entity.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class BrandsLensesSelectWidget extends StatefulWidget {
  final Function(BrandEntity)? onSelected;
  final double? width;
  final double? height;
  final List<BrandEntity>? items;

  const BrandsLensesSelectWidget(
      {this.height, this.width, this.onSelected, this.items});
  @override
  _HomeSelectStyleWidgetState createState() => _HomeSelectStyleWidgetState();
}

class _HomeSelectStyleWidgetState extends State<BrandsLensesSelectWidget> {
  //StyleSelected _selected=StyleSelected.MAN;

  BrandEntity selectedStyle =
      BrandEntity(id: -11121, name: 'null', image: 'null');
  final _controllerListOfStyle = ItemScrollController();
  bool _isStyleEmpty = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.items != null && widget.items!.isNotEmpty
        ? Container(
            width: widget.width,
            height: widget.height,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: globalSize.setWidthPercentage(40, context) /
                      globalSize.setWidthPercentage(40, context),
                ),
                padding: const EdgeInsets.only(
                    left: EdgeMargin.subSubMin, right: EdgeMargin.subSubMin),
                itemCount: widget.items!.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => _buildItem(
                    context: context,
                    height: widget.height!,
                    width: widget.width! * .31,
                    image: widget.items![index].image,
                    title: widget.items![index].name,
                    isSelected: selectedStyle.id == widget.items![index].id,
                    selected: widget.items![index])),
          )
        : Container();
  }

  jumpToIndex(int index) {
    int indexOfList = 0;
    if (index != null) {
      for (int i = 0; i < widget.items!.length; i++) {
        if (widget.items![i].id == index) indexOfList = i;
      }
    } else {
      indexOfList = 0;
    }

    return indexOfList;
  }

  _buildItem(
      {String? title,
      bool? isSelected,
      String? image,
      double? width,
      double? height,
      BuildContext? context,
      BrandEntity? selected}) {
    return Container(
        decoration: BoxDecoration(
          color: globalColor.white,
          borderRadius: BorderRadius.circular(12.0.w),
        ),
        // padding: const EdgeInsets.all(2.0),
        width: widget.width! * .31,
        height: height,
        margin:
            const EdgeInsets.only(left: EdgeMargin.sub, right: EdgeMargin.sub),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(EdgeMargin.sub),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12.0.w)),
                  child: ImageCacheWidget(
                    imageUrl: image ?? '',
                    boxFit: BoxFit.fill,
                    imageWidth: width!,
                    imageHeight: height! * .15,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Expanded(
                  //   flex: 4,
                  //   child: Text(
                  //   title??'',
                  //     style: textStyle.smallTSBasic.copyWith(
                  //         color: globalColor.black),
                  //     maxLines: 1,
                  //   ),
                  // ),
                  InkWell(
                    hoverColor: globalColor.transparent,
                    splashColor: globalColor.transparent,
                    highlightColor: globalColor.transparent,
                    onTap: () {
                      if (mounted)
                        setState(() {
                          selectedStyle = selected!;
                        });
                      if (widget.onSelected != null) {
                        widget.onSelected!(selected!);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: globalColor.white,
                          borderRadius: BorderRadius.circular(12.0.w),
                          border: Border.all(
                              width: .5,
                              color: globalColor.grey.withOpacity(0.3))),
                      child: Padding(
                        padding: const EdgeInsets.all(EdgeMargin.sub),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 2.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: isSelected!
                                      ? globalColor.primaryColor
                                      : globalColor.transparent,
                                  borderRadius: BorderRadius.circular(14.0),
                                  border: Border.all(
                                      width: isSelected ? 0.5 : 0,
                                      color: isSelected
                                          ? globalColor.primaryColor
                                              .withOpacity(0.3)
                                          : globalColor.transparent)),
                              child: CircleAvatar(
                                child: isSelected
                                    ? Icon(
                                        Icons.check,
                                        color: globalColor.black,
                                        size: 12,
                                      )
                                    : Container(),
                                radius: 10,
                                backgroundColor: isSelected
                                    ? globalColor.goldColor
                                    : globalColor.grey.withOpacity(0.3),
                              ),
                            ),
                            SizedBox(
                              width: 5.h,
                            ),
                            Text(
                              Translations.of(context!).translate('choose'),
                              style: textStyle.minTSBasic
                                  .copyWith(color: globalColor.black),
                            ),
                            SizedBox(
                              width: 5.h,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

enum StyleSelected { MAN, WOMAN }
