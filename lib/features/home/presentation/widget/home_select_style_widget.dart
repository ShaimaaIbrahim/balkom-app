import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ojos_app/core/bloc/application_bloc.dart';
import 'package:ojos_app/core/entities/extra_glasses_item_entity.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/res/shared_preference_utils/shared_preferences.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:ojos_app/features/user_management/domain/repositories/user_repository.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HomeSelectStyleWidget extends StatefulWidget {
  final Function(int?)? onSelected;
  final double? width;
  final double? height;

  const HomeSelectStyleWidget(
      {this.height, this.width, @required this.onSelected});
  @override
  _HomeSelectStyleWidgetState createState() => _HomeSelectStyleWidgetState();
}

class _HomeSelectStyleWidgetState extends State<HomeSelectStyleWidget> {
  //StyleSelected _selected=StyleSelected.MAN;

  int? selectedStyle = -1111;
  final _controllerListOfStyle = ItemScrollController();
  bool _isStyleEmpty = false;
  List<ExtraGlassesItemEntity>? gender;

  @override
  void initState() {
    super.initState();

    gender =
        BlocProvider.of<ApplicationBloc>(context).state.extraGlasses?.gender ??
            [];
    print(
        'gender length ${BlocProvider.of<ApplicationBloc>(context).state.extraGlasses?.toJson()}');
    checkSelectedStyle();
  }

  void checkSelectedStyle() async {
    //  final selected= await CoreRepository.selectedGenderStyle;
    int selected = -1111;
    await appSharedPrefs.selectedGenderStyle.then((value) {
      print('omar gender cached style in checkSelectedStyle fun is =  $value');
      selected = value!;
      print('omar selected in checkSelectedStyle fun is =  $selected');
    });
    if (selected == null || selected == -1111) {
      if (widget.onSelected != null) {
        widget.onSelected!(null);
      }
      // if(gender!=null&& gender.isNotEmpty)
      //   appSharedPrefs.persistSelectedGenderStyle(gender[0].id).then((value) {
      //
      //     if(value){
      //       if(mounted)
      //         setState(() {
      //           selectedStyle=gender[0].id;
      //         });
      //
      //     }
      //   });
    } else {
      // selectedStyle =selected;
      print('omar here');
      if (mounted)
        setState(() {
          selectedStyle = selected;
        });
    }
    if (widget.onSelected != null) {
      widget.onSelected!(selectedStyle);
    }

    print('omar selectedStyle in checkSelectedStyle fun is  $selectedStyle');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height! * .225,
      child: ScrollablePositionedList.builder(
          itemScrollController: _controllerListOfStyle,
          initialScrollIndex: jumpToIndex(selectedStyle!),
          itemCount: gender!.length,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => _buildItem(
              context: context,
              height: widget.height!,
              width: widget.width!,
              image: gender![index].image!,
              title: gender![index].name!,
              isSelected: selectedStyle == gender![index].id,
              selected: gender![index].id!)),
    );
  }

  jumpToIndex(int index) {
    int indexOfList = 0;
    if (index != null) {
      for (int i = 0; i < gender!.length; i++) {
        if (gender![i].id == index) indexOfList = i;
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
      int? selected}) {
    return Container(
        decoration: BoxDecoration(
          color: globalColor.white,
          borderRadius: BorderRadius.circular(12.0.w),
        ),
        //   padding: const EdgeInsets.all(1.0),
        width: widget.width! * .45,
        margin: const EdgeInsets.only(
            left: EdgeMargin.verySub, right: EdgeMargin.verySub),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(EdgeMargin.sub),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12.0.w)),
                child: ImageCacheWidget(
                  imageUrl: image ?? '',
                  boxFit: BoxFit.fill,
                  imageWidth: width! * .45,
                  imageHeight: height! * .15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      title ?? '',
                      style: textStyle.middleTSBasic
                          .copyWith(color: globalColor.black),
                    ),
                  ),
                  InkWell(
                    hoverColor: globalColor.transparent,
                    splashColor: globalColor.transparent,
                    highlightColor: globalColor.transparent,
                    onTap: () {
                      if (isSelected!) {
                        appSharedPrefs.persistSelectedGenderStyle(null);
                        if (mounted)
                          setState(() {
                            selectedStyle = null;
                          });
                        if (widget.onSelected != null) {
                          widget.onSelected!(null);
                        }
                      } else {
                        if (mounted)
                          setState(() {
                            // selectedStyle = selected;
                            // CoreRepository.persistSelectedGenderStyle(selectedStyle);
                            appSharedPrefs
                                .persistSelectedGenderStyle(selected)
                                .then((value) {
                              if (value) {
                                print(
                                    'omar value in persistSelectedGenderStyle fun is =  $value');
                                print(
                                    'omar value in persistSelectedGenderStyle fun is =  $selected');
                                if (mounted)
                                  setState(() {
                                    selectedStyle = selected;
                                  });
                              }
                            });
                            // CoreRepository.persistSelectedGenderStyle(selected).then((value) {
                            //
                            //   if(value){
                            //     selectedStyle = selected;
                            //   }
                            // });
                            // CoreRepository.selectedGenderStyle.then((value) => print('chached gender $value'));
                          });
                        if (widget.onSelected != null) {
                          widget.onSelected!(selected);
                        }
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
