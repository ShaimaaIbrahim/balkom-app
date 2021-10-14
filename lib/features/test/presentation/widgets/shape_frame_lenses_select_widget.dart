import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ojos_app/core/entities/extra_glasses_item_entity.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ShapeOfFrameAndLensesSelectWidget extends StatefulWidget {
  final Function(int) onSelected;
  final double width;
  final double height;
  final List<ExtraGlassesItemEntity> items;

  const ShapeOfFrameAndLensesSelectWidget(
      {required this.height,
      required this.width,
      required this.onSelected,
      required this.items});
  @override
  _ShapeOfFrameAndLensesSelectWidgetState createState() =>
      _ShapeOfFrameAndLensesSelectWidgetState();
}

class _ShapeOfFrameAndLensesSelectWidgetState
    extends State<ShapeOfFrameAndLensesSelectWidget> {
  //StyleSelected _selected=StyleSelected.MAN;

  int? selectedStyle;
  final _controllerListOfStyle = ItemScrollController();
  bool _isStyleEmpty = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.items != null && widget.items.isNotEmpty
        ? Container(
            width: widget.width,
            height: widget.height * .3,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 4,
                  childAspectRatio: widget.width * .31 / 129.h,
                ),
                padding: const EdgeInsets.only(
                    left: EdgeMargin.subSubMin, right: EdgeMargin.subSubMin),
                itemCount: widget.items.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => _buildItem(
                    context: context,
                    height: 129.h,
                    width: widget.width * .31,
                    image: widget.items[index].image!,
                    title: widget.items[index].name!,
                    isSelected: selectedStyle == widget.items[index].id,
                    selected: widget.items[index].id!)),
          )
        : Container();
  }

  jumpToIndex(int index) {
    int indexOfList = 0;
    if (index != null) {
      for (int i = 0; i < widget.items.length; i++) {
        if (widget.items[i].id == index) indexOfList = i;
      }
    } else {
      indexOfList = 0;
    }

    return indexOfList;
  }

  _buildItem(
      {required String title,
      required bool isSelected,
      required String image,
      required double width,
      required double height,
      required BuildContext context,
      required int selected}) {
    return Container(
        decoration: BoxDecoration(
          color: globalColor.white,
          borderRadius: BorderRadius.circular(12.0.w),
        ),
        // padding: const EdgeInsets.all(2.0),
        width: widget.width * .31,
        height: height,
        margin:
            const EdgeInsets.only(left: EdgeMargin.sub, right: EdgeMargin.sub),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(EdgeMargin.sub),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12.0.w)),
                  child: ImageCacheWidget(
                    imageUrl: image,
                    boxFit: BoxFit.fill,
                    imageWidth: width,
                    imageHeight: height * .15,
                    imageBorderRadius: 0.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: textStyle.smallTSBasic
                        .copyWith(color: globalColor.black),
                    maxLines: 1,
                  ),
                  VerticalPadding(
                    percentage: 1,
                  ),
                  InkWell(
                    hoverColor: globalColor.transparent,
                    splashColor: globalColor.transparent,
                    highlightColor: globalColor.transparent,
                    onTap: () {
                      if (mounted)
                        setState(() {
                          selectedStyle = selected;
                          // selectedStyle = selected;
                          // CoreRepository.persistSelectedGenderStyle(selectedStyle);
                          //  appSharedPrefs.persistSelectedGenderStyle(selected).then((value) {
                          //
                          //    if(value){
                          //      print( 'omar value in persistSelectedGenderStyle fun is =  $value');
                          //      print( 'omar value in persistSelectedGenderStyle fun is =  $selected');
                          //      if(mounted)
                          //        setState(() {
                          //          selectedStyle = selected;
                          //        });
                          //
                          //    }
                          //  });
                          // CoreRepository.persistSelectedGenderStyle(selected).then((value) {
                          //
                          //   if(value){
                          //     selectedStyle = selected;
                          //   }
                          // });
                          // CoreRepository.selectedGenderStyle.then((value) => print('chached gender $value'));
                        });
                      if (widget.onSelected != null) {
                        widget.onSelected(selected);
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
                        child: FittedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 2.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: isSelected
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
                                Translations.of(context).translate('choose'),
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
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

enum StyleSelected { MAN, WOMAN }
