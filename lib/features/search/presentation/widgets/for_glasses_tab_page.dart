import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/core/bloc/application_bloc.dart';
import 'package:ojos_app/core/entities/extra_glasses_item_entity.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/ui/widget/button/rounded_button.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:ojos_app/core/ui/widget/normal_assets_image.dart';
import 'package:ojos_app/core/ui/widget/text/normal_form_field.dart';
import 'package:ojos_app/core/validators/base_validator.dart';
import 'package:ojos_app/features/search/presentation/pages/search_page.dart';
import 'package:ojos_app/features/search/presentation/widgets/item_color_filter.dart';
import 'package:ojos_app/features/search/presentation/widgets/item_size_filter.dart';

class ForGlassesTabPage extends StatefulWidget {
  final double? width;
  final double? height;
  final List<ExtraGlassesItemEntity>? itemsGlassesType;
  final List<ExtraGlassesItemEntity>? gender;
  final List<ExtraGlassesItemEntity>? faceSize;

  const ForGlassesTabPage(
      {this.width,
      this.height,
      this.itemsGlassesType,
      this.gender,
      this.faceSize});

  @override
  _ForGlassesTabPageState createState() => _ForGlassesTabPageState();
}

class _ForGlassesTabPageState extends State<ForGlassesTabPage> {
  var _cancelToken = CancelToken();
  final _formKey = GlobalKey<FormState>();

  List<int>? listOfColorSelected;
  List<int>? listOfSizeMode;

  /// frame Height parameters
  bool _frameHeightValidation = false;
  String _frameHeight = '';
  final TextEditingController frameHeightEditingController =
      new TextEditingController();

  /// frame Width parameters
  bool _frameWidthValidation = false;
  String _frameWidth = '';
  final TextEditingController frameWidthEditingController =
      new TextEditingController();

  /// frame Length parameters
  bool _frameLengthValidation = false;
  String _frameLength = '';
  final TextEditingController frameLengthEditingController =
      new TextEditingController();

  /// lenses Width parameters
  bool _lensesWidthValidation = false;
  String _lensesWidth = '';
  final TextEditingController lensesWidthEditingController =
      new TextEditingController();

  /// lenses height parameters
  bool _lensesHeightValidation = false;
  String _lensesHeight = '';
  final TextEditingController lensesHeightEditingController =
      new TextEditingController();

  double _minPrice = 0;
  double _maxPrice = 1000;

  ExtraGlassesItemEntity? glassesTypeSelected;
  ExtraGlassesItemEntity? genderSelected;
  ExtraGlassesItemEntity? faceSizeSelected;

  bool _isDisplaySizeList = true;

  @override
  void initState() {
    super.initState();
    listOfColorSelected = [];
    listOfSizeMode = [];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: widget.width,
        height: widget.height,
        color: globalColor.scaffoldBackGroundGreyColor,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        _buildAvailableSizeWidget(
                            context: context,
                            width: widget.width!,
                            height: widget.height!,
                            list: BlocProvider.of<ApplicationBloc>(context)
                                .state
                                .extraGlasses!
                                .sizeMode!),
                        _buildEnterDimensionsOfGlassesWidget(
                            context: context,
                            width: widget.width!,
                            height: widget.height!),
                        _buildEnterDimensionsOfLensesWidget(
                            context: context,
                            width: widget.width!,
                            height: widget.height!),
                        _buildAvailableGlassesColors(
                            context: context,
                            width: widget.width!,
                            height: widget.height!,
                            list: BlocProvider.of<ApplicationBloc>(context)
                                .state
                                .extraGlasses!
                                .colors!),
                        _buildSelscGlasseType(
                            context: context,
                            width: widget.width!,
                            height: widget.height!,
                            list: widget.itemsGlassesType ?? []),
                        _buildSelectedGender(
                            context: context,
                            width: widget.width!,
                            height: widget.height!,
                            list: widget.gender ?? []),
                        _buildFaceSize(
                            context: context,
                            width: widget.width!,
                            height: widget.height!,
                            list: widget.faceSize ?? []),
                        _buildRangOfPRices(
                          context: context,
                          width: widget.width!,
                          height: widget.height!,
                        ),
                        _buildButtonsWidget(
                            height: widget.height!,
                            context: context,
                            widthC: widget.width!),
                      ],
                    )),
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

  _buildButtonsWidget(
      {required BuildContext context,
      required double widthC,
      required double height}) {
    return Container(
      height: 80.h,
      width: widthC,
      color: globalColor.white,
      child: Center(
        child: Container(
          height: 50.h,
          padding: const EdgeInsets.only(
              left: EdgeMargin.min, right: EdgeMargin.min),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  child: RoundedButton(
                height: 50.h,
                width: widthC * .35,
                color: globalColor.primaryColor,
                onPressed: () {
                  Map<String, String> queryParams = {};
                  if (faceSizeSelected != null && faceSizeSelected!.id != null)
                    queryParams.putIfAbsent(
                        'size_face', () => faceSizeSelected!.id!.toString());
                  if (genderSelected != null && genderSelected!.id != null)
                    queryParams.putIfAbsent(
                        'gender_id', () => genderSelected!.id!.toString());
                  if (listOfColorSelected != null &&
                      listOfColorSelected!.isNotEmpty)
                    queryParams.putIfAbsent(
                        'color_id', () => listOfColorSelected.toString());
                  if (listOfColorSelected != null &&
                      listOfColorSelected!.isNotEmpty)
                    queryParams.putIfAbsent(
                        'color_id', () => listOfColorSelected.toString());
                  if (listOfSizeMode != null && listOfSizeMode!.isNotEmpty)
                    queryParams.putIfAbsent(
                        'sizes', () => listOfSizeMode.toString());
                  if (_minPrice != null)
                    queryParams.putIfAbsent(
                        'min_price', () => _minPrice.toString());
                  if (_maxPrice != null)
                    queryParams.putIfAbsent(
                        'max_price', () => _maxPrice.toString());
                  if (_lensesWidth != null)
                    queryParams.putIfAbsent('lens_width', () => _lensesWidth);
                  if (_lensesHeight != null)
                    queryParams.putIfAbsent('lens_height', () => _lensesHeight);
                  if (_frameWidth != null)
                    queryParams.putIfAbsent('frame_width', () => _frameWidth);
                  if (_frameLength != null)
                    queryParams.putIfAbsent('frame_length', () => _frameLength);
                  if (_frameHeight != null)
                    queryParams.putIfAbsent('frame_height', () => _frameHeight);
                  if (glassesTypeSelected != null &&
                      glassesTypeSelected!.id != null)
                    queryParams.putIfAbsent(
                        'type', () => glassesTypeSelected!.id!.toString());

                  queryParams.putIfAbsent('Is_Glasses', () => '1');
                  queryParams.putIfAbsent('order', () => 'asc');
                  queryParams.putIfAbsent('sort', () => 'date');

                  print('SearchPage query params ${queryParams.toString()}');

                  Get.Get.offAndToNamed(SearchPage.routeName,
                      arguments: queryParams);
                },
                borderRadius: 8.w,
                child: Container(
                  child: Center(
                    child: Text(
                      Translations.of(context).translate('search'),
                      style: textStyle.smallTSBasic
                          .copyWith(color: globalColor.white),
                    ),
                  ),
                ),
              )),
              HorizontalPadding(
                percentage: 4.0,
              ),
              Container(
                  child: RoundedButton(
                height: 50.h,
                width: widthC * .35,
                color: globalColor.backgroundLightPrim,
                onPressed: () {
                  Get.Get.back(result: null);
                },
                borderRadius: 8.w,
                child: Container(
                  child: Center(
                    child: Text(
                      Translations.of(context).translate('cancel'),
                      style: textStyle.smallTSBasic
                          .copyWith(color: globalColor.black),
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  _buildAvailableSizeWidget(
      {required BuildContext context,
      required double width,
      required double height,
      required List<ExtraGlassesItemEntity> list}) {
    if (list != null && list.isNotEmpty) {
      return Container(
        width: width,
        padding:
            const EdgeInsets.fromLTRB(0.0, EdgeMargin.sub, 0.0, EdgeMargin.sub),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                if (mounted)
                  setState(() {
                    _isDisplaySizeList = !_isDisplaySizeList;
                  });
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                    EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(
                          Translations.of(context).translate('available_sizes'),
                          style: textStyle.middleTSBasic.copyWith(
                            color: globalColor.black,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: globalColor.grey.withOpacity(0.5)),
                      child: Center(
                        child: Icon(
                          !_isDisplaySizeList
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_up,
                          color: globalColor.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            VerticalPadding(
              percentage: .5,
            ),
            _isDisplaySizeList
                ? Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ItemSizeFilter(
                            width: width,
                            item: list[index],
                            onSelect: _onSelectSize,
                          );
                        }),
                  )
                : Container(),
            // Container(
            //   child: Column(
            //     children: [
            //       _buildSizeItem(
            //           width: width,
            //           image: AppAssets.glasses_svg,
            //           context: context,
            //           height: height,
            //           isAvailable: true,
            //           label: 'SMALL'.toUpperCase(),
            //           size: '40-48',
            //           imageSize: 42.w),
            //       VerticalPadding(
            //         percentage: 1.0,
            //       ),
            //       _buildSizeItem(
            //           width: width,
            //           image: AppAssets.glasses_svg,
            //           context: context,
            //           height: height,
            //           isAvailable: false,
            //           label: 'Medium'.toUpperCase(),
            //           size: '49-54',
            //           imageSize: 55.w),
            //       VerticalPadding(
            //         percentage: 1.0,
            //       ),
            //       _buildSizeItem(
            //           width: width,
            //           image: AppAssets.glasses_svg,
            //           context: context,
            //           height: height,
            //           isAvailable: true,
            //           label: 'Large'.toUpperCase(),
            //           size: '55-58',
            //           imageSize: 65.w),
            //       VerticalPadding(
            //         percentage: 1.0,
            //       ),
            //       _buildSizeItem(
            //           width: width,
            //           image: AppAssets.glasses_svg,
            //           context: context,
            //           height: height,
            //           isAvailable: false,
            //           label: 'E-Large'.toUpperCase(),
            //           size: 'above 58',
            //           imageSize: 80.w),
            //     ],
            //   ),
            // )
          ],
        ),
      );
    }
    return Container();
  }

/*  _buildSizeItem(
      {BuildContext context,
      double width,
      double height,
      bool isAvailable,
      String label,
      String size,
      String image,
      double imageSize}) {
    double sizeIcon;
    if (size == '40-48') {
      sizeIcon = 42.w;
    } else if (size == '49-54') {
      sizeIcon = 55.w;
    } else if (size == '55-58') {
      sizeIcon = 65.w;
    } else if (size == 'above 58') {
      sizeIcon = 80.w;
    } else {
      sizeIcon = 42.w;
    }
    return Container(
      padding:
          const EdgeInsets.fromLTRB(EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
      width: width,
      height: 46.h,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                color: globalColor.white.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                    bottomRight: utils.getLang() == 'ar'
                        ? Radius.circular(10.w)
                        : Radius.circular(0.0),
                    topRight: utils.getLang() == 'ar'
                        ? Radius.circular(10.w)
                        : Radius.circular(0.0),
                    bottomLeft: utils.getLang() == 'ar'
                        ? Radius.circular(0.0)
                        : Radius.circular(10.w),
                    topLeft: utils.getLang() == 'ar'
                        ? Radius.circular(0.0)
                        : Radius.circular(10.w)),
                border: Border.all(
                    color: globalColor.grey.withOpacity(0.3), width: 0.5),
              ),
              height: 46.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HorizontalPadding(
                    percentage: 1.0,
                  ),
                  Container(
                    width: 25.w,
                    height: 25.w,
                    decoration: BoxDecoration(
                        color: isAvailable
                            ? globalColor.primaryColor
                            : globalColor.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 0.5,
                            color: isAvailable
                                ? globalColor.primaryColor.withOpacity(0.3)
                                : globalColor.grey.withOpacity(0.3))),
                    child: Center(
                      child: CircleAvatar(
                        child: isAvailable
                            ? Icon(
                                MaterialIcons.check,
                                color: globalColor.black,
                                size: 12,
                              )
                            : Container(),
                        radius: isAvailable ? 15.w : 9.w,
                        backgroundColor: isAvailable
                            ? globalColor.goldColor
                            : globalColor.grey.withOpacity(0.3),
                      ),
                    ),
                  ),
                  HorizontalPadding(
                    percentage: 1.0,
                  ),
                  Container(
                    child: Text(
                      label ?? '',
                      style: textStyle.smallTSBasic.copyWith(
                          color: globalColor.black,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                color: globalColor.white.withOpacity(0.5),
                border: Border(
                  top: BorderSide(
                      color: globalColor.grey.withOpacity(0.3), width: 0.5),
                  bottom: BorderSide(
                      color: globalColor.grey.withOpacity(0.3), width: 0.5),
                ),
              ),
              height: 46.h,
              alignment: AlignmentDirectional.center,
              //color: globalColor.white,
              child: Text(
                size ?? '',
                style: textStyle.middleTSBasic.copyWith(
                    color: globalColor.grey.withOpacity(0.8),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                color: globalColor.grey.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                    bottomRight: utils.getLang() == 'ar'
                        ? Radius.circular(0.0)
                        : Radius.circular(10.w),
                    topRight: utils.getLang() == 'ar'
                        ? Radius.circular(0.0)
                        : Radius.circular(10.w),
                    bottomLeft: utils.getLang() == 'ar'
                        ? Radius.circular(10.w)
                        : Radius.circular(0.0),
                    topLeft: utils.getLang() == 'ar'
                        ? Radius.circular(10.w)
                        : Radius.circular(0.0)),
                border: Border.all(
                    color: globalColor.grey.withOpacity(0.3), width: 0.5),
              ),
              height: 46.h,
              child: SvgPicture.asset(
                image ?? '',
                width: sizeIcon ?? 10.w,
              ),
            ),
          ),
        ],
      ),
    );
  }*/

  _buildAvailableGlassesColors(
      {required BuildContext context,
      required double width,
      required double height,
      required List<ExtraGlassesItemEntity> list}) {
    if (list.isNotEmpty) {
      Wrap body = Wrap(
          // alignment: WrapAlignment.start,
          // runAlignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(
                  EdgeMargin.sub, 0.0, EdgeMargin.sub, 0.0),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      Translations.of(context).translate('available_colors'),
                      style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ]);

      body.children.addAll(list.map((item) {
        return ItemColorFilter(
          onSelect: _onSelectColors,
          item: item,
        );
      }));
      return Container(
          width: width,
          padding: const EdgeInsets.fromLTRB(
              EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
          child: body);
    }

    return Container();
  }

  _buildEnterDimensionsOfGlassesWidget(
      {required BuildContext context,
      required double width,
      required double height}) {
    return Container(
      width: width,
      padding:
          const EdgeInsets.fromLTRB(0.0, EdgeMargin.sub, 0.0, EdgeMargin.sub),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(
                EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      Translations.of(context)
                          .translate('enter_the_dimensions_of_the_glasses'),
                      style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: globalColor.grey.withOpacity(0.5)),
                //   child: Center(
                //     child: Icon(
                //       MaterialIcons.keyboard_arrow_down,
                //       color: globalColor.black,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: _buildDimensionsInputWidgetFrameHeight(
                      context: context,
                      height: height,
                      width: width,
                      image: AppAssets.frame_height_png,
                      imageSize: 65.w,
                      widgetSubTitle: 'Frame Height',
                      widgetTitle: 'ارتفاع الاطار',
                    )),
                HorizontalPadding(
                  percentage: 0.5,
                ),
                Expanded(
                    flex: 1,
                    child: _buildDimensionsInputWidgetFrameWidth(
                      context: context,
                      height: height,
                      width: width,
                      image: AppAssets.frame_width_png,
                      imageSize: 65.w,
                      widgetSubTitle: 'Frame Width',
                      widgetTitle: 'عرض الاطار',
                    )),
                HorizontalPadding(
                  percentage: 0.5,
                ),
                Expanded(
                    flex: 1,
                    child: _buildDimensionsInputWidgetFrameLength(
                      context: context,
                      height: height,
                      width: width,
                      image: AppAssets.frame_length_png,
                      imageSize: 65.w,
                      widgetSubTitle: 'Frame Length',
                      widgetTitle: 'طول الاطار',
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildDimensionsInputWidgetFrameWidth({
    required BuildContext context,
    required double width,
    required double height,
    required String widgetTitle,
    required String image,
    required double imageSize,
    required String widgetSubTitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.white.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        border:
            Border.all(color: globalColor.grey.withOpacity(0.3), width: 0.5),
      ),
      //   margin: const EdgeInsets.only(left: EdgeMargin.verySub,),
      child: Column(
        children: [
          VerticalPadding(
            percentage: 1.0,
          ),
          Container(
            child: Text(
              widgetTitle,
              style: textStyle.minTSBasic.copyWith(color: globalColor.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(EdgeMargin.subSubMin),
            child: Container(
              decoration: BoxDecoration(
                color: globalColor.white.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                border: Border.all(
                    color: globalColor.grey.withOpacity(0.3), width: 0.5),
              ),
              padding: const EdgeInsets.all(EdgeMargin.sub),
              child: Center(
                child: Column(
                  children: [
                    VerticalPadding(
                      percentage: 1.0,
                    ),
                    Container(
                      child: Image.asset(
                        image,
                        width: imageSize,
                        fit: BoxFit.fill,
                      ),
                    ),
                    VerticalPadding(
                      percentage: 2.0,
                    ),
                    Container(
                      child: Text(
                        widgetSubTitle,
                        style: textStyle.sub2MinTSBasic
                            .copyWith(color: globalColor.black),
                      ),
                    ),
                    VerticalPadding(
                      percentage: 1.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(EdgeMargin.subSubMin),
            child: Container(
              child: BorderFormField(
                controller: frameWidthEditingController,
                validator: (value) {
                  return BaseValidator.validateValue(
                    context,
                    value!,
                    [],
                    _frameWidthValidation,
                  );
                },
                hintText: '48mm',
                hintStyle: textStyle.minTSBasic.copyWith(
                    color: globalColor.grey, fontWeight: FontWeight.bold),
                style: textStyle.minTSBasic.copyWith(
                    color: globalColor.black, fontWeight: FontWeight.bold),
                filled: false,
                keyboardType: TextInputType.number,
                borderRadius: 12.w,
                onChanged: (value) {
                  setState(() {
                    _frameWidthValidation = true;
                    _frameWidth = value;
                  });
                },
                textAlign: TextAlign.center,
                borderColor: globalColor.grey.withOpacity(0.3),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).nextFocus();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildDimensionsInputWidgetFrameHeight({
    required BuildContext context,
    required double width,
    required double height,
    required String widgetTitle,
    required String image,
    required double imageSize,
    required String widgetSubTitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.white.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        border:
            Border.all(color: globalColor.grey.withOpacity(0.3), width: 0.5),
      ),
      //   margin: const EdgeInsets.only(left: EdgeMargin.verySub,),
      child: Column(
        children: [
          VerticalPadding(
            percentage: 1.0,
          ),
          Container(
            child: Text(
              widgetTitle,
              style: textStyle.minTSBasic.copyWith(color: globalColor.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(EdgeMargin.subSubMin),
            child: Container(
              decoration: BoxDecoration(
                color: globalColor.white.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                border: Border.all(
                    color: globalColor.grey.withOpacity(0.3), width: 0.5),
              ),
              padding: const EdgeInsets.all(EdgeMargin.sub),
              child: Center(
                child: Column(
                  children: [
                    VerticalPadding(
                      percentage: 1.0,
                    ),
                    Container(
                      child: Image.asset(
                        image,
                        width: imageSize,
                        fit: BoxFit.fill,
                      ),
                    ),
                    VerticalPadding(
                      percentage: 2.0,
                    ),
                    Container(
                      child: Text(
                        widgetSubTitle,
                        style: textStyle.sub2MinTSBasic
                            .copyWith(color: globalColor.black),
                      ),
                    ),
                    VerticalPadding(
                      percentage: 1.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(EdgeMargin.subSubMin),
            child: Container(
              child: BorderFormField(
                controller: frameHeightEditingController,
                validator: (value) {
                  return BaseValidator.validateValue(
                    context,
                    value!,
                    [],
                    _frameHeightValidation,
                  );
                },
                hintText: '48mm',
                hintStyle: textStyle.minTSBasic.copyWith(
                    color: globalColor.grey, fontWeight: FontWeight.bold),
                style: textStyle.minTSBasic.copyWith(
                    color: globalColor.black, fontWeight: FontWeight.bold),
                filled: false,
                keyboardType: TextInputType.number,
                borderRadius: 12.w,
                onChanged: (value) {
                  setState(() {
                    _frameHeightValidation = true;
                    _frameHeight = value;
                  });
                },
                textAlign: TextAlign.center,
                borderColor: globalColor.grey.withOpacity(0.3),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).nextFocus();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildDimensionsInputWidgetFrameLength({
    required BuildContext context,
    required double width,
    required double height,
    required String widgetTitle,
    required String image,
    required double imageSize,
    required String widgetSubTitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.white.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        border:
            Border.all(color: globalColor.grey.withOpacity(0.3), width: 0.5),
      ),
      //   margin: const EdgeInsets.only(left: EdgeMargin.verySub,),
      child: Column(
        children: [
          VerticalPadding(
            percentage: 1.0,
          ),
          Container(
            child: Text(
              widgetTitle,
              style: textStyle.minTSBasic.copyWith(color: globalColor.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(EdgeMargin.subSubMin),
            child: Container(
              decoration: BoxDecoration(
                color: globalColor.white.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                border: Border.all(
                    color: globalColor.grey.withOpacity(0.3), width: 0.5),
              ),
              padding: const EdgeInsets.all(EdgeMargin.sub),
              child: Center(
                child: Column(
                  children: [
                    VerticalPadding(
                      percentage: 1.0,
                    ),
                    Container(
                      child: Image.asset(
                        image,
                        width: imageSize,
                        fit: BoxFit.fill,
                      ),
                    ),
                    VerticalPadding(
                      percentage: 2.0,
                    ),
                    Container(
                      child: Text(
                        widgetSubTitle,
                        style: textStyle.sub2MinTSBasic
                            .copyWith(color: globalColor.black),
                      ),
                    ),
                    VerticalPadding(
                      percentage: 1.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(EdgeMargin.subSubMin),
            child: Container(
              child: BorderFormField(
                controller: frameLengthEditingController,
                validator: (value) {
                  return BaseValidator.validateValue(
                    context,
                    value!,
                    [],
                    _frameLengthValidation,
                  );
                },
                hintText: '48mm',
                hintStyle: textStyle.minTSBasic.copyWith(
                    color: globalColor.grey, fontWeight: FontWeight.bold),
                style: textStyle.minTSBasic.copyWith(
                    color: globalColor.black, fontWeight: FontWeight.bold),
                filled: false,
                keyboardType: TextInputType.number,
                borderRadius: 12.w,
                onChanged: (value) {
                  setState(() {
                    _frameLengthValidation = true;
                    _frameLength = value;
                  });
                },
                textAlign: TextAlign.center,
                borderColor: globalColor.grey.withOpacity(0.3),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).nextFocus();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildDimensionsInputWidgetLensHeight({
    required BuildContext context,
    required double width,
    required double height,
    required String widgetTitle,
    required String image,
    required double imageSize,
    required String widgetSubTitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.white.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        border:
            Border.all(color: globalColor.grey.withOpacity(0.3), width: 0.5),
      ),
      //   margin: const EdgeInsets.only(left: EdgeMargin.verySub,),
      child: Column(
        children: [
          VerticalPadding(
            percentage: 1.0,
          ),
          Container(
            child: Text(
              widgetTitle,
              style: textStyle.minTSBasic.copyWith(color: globalColor.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(EdgeMargin.subSubMin),
            child: Container(
              decoration: BoxDecoration(
                color: globalColor.white.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                border: Border.all(
                    color: globalColor.grey.withOpacity(0.3), width: 0.5),
              ),
              padding: const EdgeInsets.all(EdgeMargin.sub),
              child: Center(
                child: Column(
                  children: [
                    VerticalPadding(
                      percentage: 1.0,
                    ),
                    Container(
                      child: Image.asset(
                        image,
                        width: imageSize,
                        fit: BoxFit.fill,
                      ),
                    ),
                    VerticalPadding(
                      percentage: 2.0,
                    ),
                    Container(
                      child: Text(
                        widgetSubTitle,
                        style: textStyle.sub2MinTSBasic
                            .copyWith(color: globalColor.black),
                      ),
                    ),
                    VerticalPadding(
                      percentage: 1.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(EdgeMargin.subSubMin),
            child: Container(
              child: BorderFormField(
                controller: lensesHeightEditingController,
                validator: (value) {
                  return BaseValidator.validateValue(
                    context,
                    value!,
                    [],
                    _lensesHeightValidation,
                  );
                },
                hintText: '48mm',
                hintStyle: textStyle.minTSBasic.copyWith(
                    color: globalColor.grey, fontWeight: FontWeight.bold),
                style: textStyle.minTSBasic.copyWith(
                    color: globalColor.black, fontWeight: FontWeight.bold),
                filled: false,
                keyboardType: TextInputType.number,
                borderRadius: 12.w,
                onChanged: (value) {
                  setState(() {
                    _lensesHeightValidation = true;
                    _lensesHeight = value;
                  });
                },
                textAlign: TextAlign.center,
                borderColor: globalColor.grey.withOpacity(0.3),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).nextFocus();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildDimensionsInputWidgetLensWidth({
    required BuildContext context,
    required double width,
    required double height,
    required String widgetTitle,
    required String image,
    required double imageSize,
    required String widgetSubTitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.white.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        border:
            Border.all(color: globalColor.grey.withOpacity(0.3), width: 0.5),
      ),
      //   margin: const EdgeInsets.only(left: EdgeMargin.verySub,),
      child: Column(
        children: [
          VerticalPadding(
            percentage: 1.0,
          ),
          Container(
            child: Text(
              widgetTitle,
              style: textStyle.minTSBasic.copyWith(color: globalColor.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(EdgeMargin.subSubMin),
            child: Container(
              decoration: BoxDecoration(
                color: globalColor.white.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                border: Border.all(
                    color: globalColor.grey.withOpacity(0.3), width: 0.5),
              ),
              padding: const EdgeInsets.all(EdgeMargin.sub),
              child: Center(
                child: Column(
                  children: [
                    VerticalPadding(
                      percentage: 1.0,
                    ),
                    Container(
                      child: Image.asset(
                        image,
                        width: imageSize,
                        fit: BoxFit.fill,
                      ),
                    ),
                    VerticalPadding(
                      percentage: 2.0,
                    ),
                    Container(
                      child: Text(
                        widgetSubTitle,
                        style: textStyle.sub2MinTSBasic
                            .copyWith(color: globalColor.black),
                      ),
                    ),
                    VerticalPadding(
                      percentage: 1.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(EdgeMargin.subSubMin),
            child: Container(
              child: BorderFormField(
                controller: lensesWidthEditingController,
                validator: (value) {
                  return BaseValidator.validateValue(
                    context,
                    value!,
                    [],
                    _lensesWidthValidation,
                  );
                },
                hintText: '48mm',
                hintStyle: textStyle.minTSBasic.copyWith(
                    color: globalColor.grey, fontWeight: FontWeight.bold),
                style: textStyle.minTSBasic.copyWith(
                    color: globalColor.black, fontWeight: FontWeight.bold),
                filled: false,
                keyboardType: TextInputType.number,
                borderRadius: 12.w,
                onChanged: (value) {
                  setState(() {
                    _lensesWidthValidation = true;
                    _lensesWidth = value;
                  });
                },
                textAlign: TextAlign.center,
                borderColor: globalColor.grey.withOpacity(0.3),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).nextFocus();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildEnterDimensionsOfLensesWidget(
      {required BuildContext context,
      required double width,
      required double height}) {
    return Container(
      width: width,
      padding:
          const EdgeInsets.fromLTRB(0.0, EdgeMargin.sub, 0.0, EdgeMargin.sub),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(
                EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      Translations.of(context)
                          .translate('enter_the_dimensions_of_the_lenses'),
                      style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: globalColor.grey.withOpacity(0.5)),
                //   child: Center(
                //     child: Icon(
                //       MaterialIcons.keyboard_arrow_down,
                //       color: globalColor.black,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: _buildDimensionsInputWidgetLensHeight(
                      context: context,
                      height: height,
                      width: width,
                      image: AppAssets.lens_height_png,
                      imageSize: 65.w,
                      widgetSubTitle: 'Lens Height',
                      widgetTitle: 'ارتفاع العدسة',
                    )),
                HorizontalPadding(
                  percentage: 0.5,
                ),
                Expanded(
                    flex: 1,
                    child: _buildDimensionsInputWidgetLensWidth(
                      context: context,
                      height: height,
                      width: width,
                      image: AppAssets.lens_width_png,
                      imageSize: 65.w,
                      widgetSubTitle: 'Lens Width',
                      widgetTitle: 'عرض العدسة',
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildSelscGlasseType(
      {required BuildContext context,
      required double width,
      required double height,
      required List<ExtraGlassesItemEntity> list}) {
    return Container(
      padding:
          const EdgeInsets.fromLTRB(0.0, EdgeMargin.sub, 0.0, EdgeMargin.sub),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(
                EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      Translations.of(context)
                          .translate('select_the_type_of_glasses'),
                      style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: globalColor.grey.withOpacity(0.5)),
                //   child: Center(
                //     child: Icon(
                //       MaterialIcons.keyboard_arrow_down,
                //       color: globalColor.black,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          Container(
            height: widget.height! * .2,
            width: widget.width!,
            child: ListView.builder(
              itemCount: list.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _buildItemSelectGlassesType(
                  context: context,
                  height: widget.height! * .2,
                  width: widget.width! * .475,
                  item: list[index],
                  isSelected: glassesTypeSelected?.id == list[index].id,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildSelectedGender(
      {required BuildContext context,
      required double width,
      required double height,
      required List<ExtraGlassesItemEntity> list}) {
    return Container(
      padding:
          const EdgeInsets.fromLTRB(0.0, EdgeMargin.sub, 0.0, EdgeMargin.sub),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(
                EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      Translations.of(context)
                          .translate('select_the_style_of_the glasses'),
                      style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: globalColor.grey.withOpacity(0.5)),
                //   child: Center(
                //     child: Icon(
                //       MaterialIcons.keyboard_arrow_down,
                //       color: globalColor.black,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          Container(
            height: widget.height! * .2,
            width: widget.width,
            child: ListView.builder(
              itemCount: list.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _buildItemGender(
                  context: context,
                  height: widget.height! * .2,
                  width: widget.width! * .475,
                  item: list[index],
                  isSelected: genderSelected?.id == list[index].id,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildFaceSize(
      {required BuildContext context,
      required double width,
      required double height,
      required List<ExtraGlassesItemEntity> list}) {
    return Container(
      padding:
          const EdgeInsets.fromLTRB(0.0, EdgeMargin.sub, 0.0, EdgeMargin.sub),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(
                EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      Translations.of(context)
                          .translate('select_the_size_of_the face'),
                      style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: globalColor.grey.withOpacity(0.5)),
                //   child: Center(
                //     child: Icon(
                //       MaterialIcons.keyboard_arrow_down,
                //       color: globalColor.black,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          Container(
            height: 149.h,
            width: widget.width,
            child: ListView.builder(
              itemCount: list.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _buildItemFaceSize(
                  context: context,
                  height: 149.h,
                  width: widget.width! * .31,
                  item: list[index],
                  isSelected: faceSizeSelected?.id == list[index].id,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildItemSelectGlassesType({
    required ExtraGlassesItemEntity item,
    required bool isSelected,
    required double width,
    required double height,
    required BuildContext context,
  }) {
    return Container(
        decoration: BoxDecoration(
          color: globalColor.white,
          borderRadius: BorderRadius.circular(12.0.w),
        ),
        // padding: const EdgeInsets.all(2.0),
        width: width,
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
                  child: NormalAssetsImage(
                    imageUrl: item.image ?? '',
                    fit: BoxFit.fill,
                    width: width,
                    height: height * .15,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      item.name ?? '',
                      style: textStyle.smallTSBasic
                          .copyWith(color: globalColor.black),
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      hoverColor: globalColor.transparent,
                      splashColor: globalColor.transparent,
                      highlightColor: globalColor.transparent,
                      onTap: () {
                        if (glassesTypeSelected != null &&
                            glassesTypeSelected!.id == item.id) {
                          if (mounted) {
                            setState(() {
                              glassesTypeSelected = null;
                            });
                          }
                        } else {
                          if (mounted) {
                            setState(() {
                              glassesTypeSelected = item;
                            });
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
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  _buildItemGender({
    required ExtraGlassesItemEntity item,
    required bool isSelected,
    required double width,
    required double height,
    required BuildContext context,
  }) {
    return Container(
        decoration: BoxDecoration(
          color: globalColor.white,
          borderRadius: BorderRadius.circular(12.0.w),
        ),
        // padding: const EdgeInsets.all(2.0),
        width: width,
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
                    imageUrl: item.image ?? '',
                    boxFit: BoxFit.fill,
                    imageWidth: width,
                    imageHeight: height * .15,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      item.name!,
                      style: textStyle.smallTSBasic
                          .copyWith(color: globalColor.black),
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      hoverColor: globalColor.transparent,
                      splashColor: globalColor.transparent,
                      highlightColor: globalColor.transparent,
                      onTap: () {
                        if (genderSelected != null &&
                            genderSelected!.id == item.id) {
                          if (mounted) {
                            setState(() {
                              genderSelected = null;
                            });
                          }
                        } else {
                          if (mounted) {
                            setState(() {
                              genderSelected = item;
                            });
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
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  _buildItemFaceSize({
    required ExtraGlassesItemEntity item,
    required bool isSelected,
    required double width,
    required double height,
    required BuildContext context,
  }) {
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
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(EdgeMargin.sub),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12.0.w)),
                  child: ImageCacheWidget(
                    imageUrl: item.image ?? '',
                    // boxFit: BoxFit.fill,
                    imageWidth: width,
                    imageHeight: height * .15,
                    boxFit: BoxFit.fill,
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
                    item.name ?? '',
                    style: textStyle.smallTSBasic
                        .copyWith(color: globalColor.black),
                    maxLines: 1,
                  ),
                  InkWell(
                    hoverColor: globalColor.transparent,
                    splashColor: globalColor.transparent,
                    highlightColor: globalColor.transparent,
                    onTap: () {
                      if (faceSizeSelected != null &&
                          faceSizeSelected!.id == item.id) {
                        if (mounted) {
                          setState(() {
                            faceSizeSelected = null;
                          });
                        }
                      } else {
                        if (mounted) {
                          setState(() {
                            faceSizeSelected = item;
                          });
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

  _buildRangOfPRices({
    required BuildContext context,
    required double width,
    required double height,
  }) {
    return Container(
      padding:
          const EdgeInsets.fromLTRB(0.0, EdgeMargin.sub, 0.0, EdgeMargin.sub),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(
                EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      Translations.of(context)
                          .translate('select_the_price_rang'),
                      style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: Text(
                        '${_minPrice.toStringAsFixed(0)} - ${_maxPrice.toStringAsFixed(0)}',
                        style: textStyle.middleTSBasic.copyWith(
                          color: globalColor.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: widget.width,
            child: RangeSlider(
              values: RangeValues(_minPrice, _maxPrice),
              onChanged: (newRange) {
                setState(() {
                  _minPrice = newRange.start;
                  _maxPrice = newRange.end;
                });
              },
              divisions: 299,
              min: 0,
              max: 1000,
              activeColor: globalColor.primaryColor,
              inactiveColor: globalColor.grey,
            ),
          ),
        ],
      ),
    );
  }

  _onSelectColors(ExtraGlassesItemEntity color, bool isSelected) {
    if (isSelected) {
      if (mounted) {
        setState(() {
          listOfColorSelected!.add(color.id!);
        });
      }
    } else {
      if (mounted)
        setState(() {
          listOfColorSelected!.removeWhere((element) => element == color.id);
        });
    }

    print('listOfYourSelected ${listOfColorSelected.toString()}');
  }

  _onSelectSize(ExtraGlassesItemEntity size, bool isSelected) {
    if (isSelected) {
      if (mounted) {
        setState(() {
          listOfSizeMode!.add(size.id!);
        });
      }
    } else {
      if (mounted)
        setState(() {
          listOfSizeMode!.removeWhere((element) => element == size.id);
        });
    }

    print('listOfSizeMode ${listOfSizeMode.toString()}');
  }
}
