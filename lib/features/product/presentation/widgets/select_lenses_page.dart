import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/entities/brand_entity.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/utils.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/widget/button/custom2_dropdown_button.dart';
import 'package:ojos_app/core/ui/widget/button/rounded_button.dart';
import 'package:ojos_app/features/home/data/models/product_model.dart';
import 'package:ojos_app/features/product/domin/entities/general_item_entity.dart';
import 'package:ojos_app/features/product/presentation/args/product_details_args.dart';
import 'package:ojos_app/features/product/presentation/args/select_lenses_args.dart';
import 'package:ojos_app/features/product/presentation/widgets/lens_company_pages.dart';
import 'package:ojos_app/features/product/presentation/widgets/lens_select_size_widget.dart';
import 'package:get/get.dart' as Get;

import 'item_color_widget.dart';
import 'lens_select_ipd_add_widget.dart';

class SelectLensesPage extends StatefulWidget {
  static const routeName = '/features/ProductDetails/SelectLensesPage';

  @override
  _SelectLensesPageState createState() => _SelectLensesPageState();
}

class _SelectLensesPageState extends State<SelectLensesPage> {
  List<String> list = [
    AppAssets.product_details_1,
    AppAssets.product_details_1,
    AppAssets.product_details_1,
    AppAssets.product_details_1,
  ];
  PageController controller =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  var currentPageValue = 0;

  /// add parameters
  // bool _addValidation = false;
  // String _add = '';
  // final TextEditingController addEditingController =
  //     new TextEditingController();
  //
  // /// ipd parameters
  // bool _ipdWidthValidation = false;
  // String _ipd = '';
  // final TextEditingController ipdEditingController =
  //     new TextEditingController();

  List<ProductModel>? listOfProduct;
  GeneralItemEntity? _colorSelect;
  LensesSelectedEnum? _selectedForRightEye;
  LensesSelectedEnum? _selectedForLeftEye;
  LensesIpdAddEnum? _selectedForAddIPD;

  TypeOfLensesChoose? _chooseType;
  final args = Get.Get.arguments as ProductDetailsArguments;

  BrandEntity? companyLenses;
  @override
  void initState() {
    super.initState();
    _colorSelect = args.product.colorInfo?.first;
    _chooseType = TypeOfLensesChoose.Medical;
  }

  GlobalKey _globalKey = GlobalKey();
  var _cancelToken = CancelToken();

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: globalColor.appBar,
      brightness: Brightness.light,
      elevation: 0,
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      title: Text(
        Translations.of(context).translate('choose_lenses'),
        style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
      ),
      centerTitle: true,
    );
    double width = globalSize.setWidthPercentage(100, context);
    double height = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
        backgroundColor: globalColor.scaffoldBackGroundGreyColor,
        appBar: appBar,
        key: _globalKey,
        body: Container(
            height: height,
            // padding: const EdgeInsets.fromLTRB(EdgeMargin.subMin,
            //     EdgeMargin.sub, EdgeMargin.subMin, EdgeMargin.sub),
            child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _globalKey = GlobalKey();
                  });
                  return null;
                },
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Container(
                            child: Column(
                              children: [
                                _buildSelectLensesTypeWidget(
                                  context: context,
                                  width: width,
                                  height: height,
                                ),

                                // _buildSelectCompanyWidget(
                                //     context: context,
                                //     width: width,
                                //     height: 50.h),
                                _buildLensCompanyTitleWidget(
                                    context: context,
                                    width: width,
                                    height: height),

                                _buildLensesColorWidget(
                                    context: context,
                                    width: width,
                                    height: height,
                                    listOfColor: args.product.colorInfo ?? []),

                                _buildEnterDimensionsTitleWidget(
                                    context: context,
                                    width: width,
                                    height: height),
                                _buildLensesSizeForRightEyessWidget(
                                    context: context,
                                    width: width,
                                    height: height,
                                    title: Translations.of(context)
                                        .translate('lens_size_for_right_eye')),

                                _buildLensesSizeForLeftEyessWidget(
                                    context: context,
                                    width: width,
                                    height: height,
                                    title: Translations.of(context)
                                        .translate('lens_size_for_left_eye')),

                                _buildEnterDimensionsOfLensesWidget(
                                    context: context,
                                    width: width,
                                    height: height),
                                VerticalPadding(
                                  percentage: 2.0,
                                ),

                                VerticalPadding(
                                  percentage: 2.5,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      _buildButtonsWidget(
                        context: context,
                        widthC: width,
                        height: height,
                      ),
                    ],
                  ),
                ))));
  }

  void reBuildPage() {
    setState(() {
      _globalKey = GlobalKey();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cancelToken.cancel();
  }

  _buildLensesColorWidget(
      {required BuildContext context,
      required double width,
      required double height,
      required List<GeneralItemEntity> listOfColor}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        EdgeMargin.small,
        EdgeMargin.min,
        EdgeMargin.small,
        EdgeMargin.min,
      ),
      child: Container(
        width: width,
        height: 46.h,
        decoration: BoxDecoration(
            color: globalColor.white,
            borderRadius: BorderRadius.all(Radius.circular(12.w)),
            border: Border.all(
                color: globalColor.grey.withOpacity(0.3), width: 0.5)),
        padding: const EdgeInsets.fromLTRB(
            EdgeMargin.min, EdgeMargin.sub, EdgeMargin.min, EdgeMargin.sub),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: Text(
                  Translations.of(context).translate('the_color_of_the_lens'),
                  style: textStyle.smallTSBasic.copyWith(
                      fontWeight: FontWeight.w500, color: globalColor.black),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: width * .4,
                height: 35.h,
                child: Custom2Dropdown<GeneralItemEntity>(
                  onChanged: (data) {
                    _colorSelect = data;
                    if (mounted) setState(() {});
                  },
                  value: _colorSelect,
                  borderRadius: width * .4,
                  hint: '',
                  dropdownMenuItemList: listOfColor.map((profession) {
                    return DropdownMenuItem(
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                            color: profession == _colorSelect
                                ? globalColor.primaryColor.withOpacity(0.3)
                                : globalColor.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.w))),
                        padding: EdgeInsets.all(EdgeMargin.small),
                        child: ItemColorWidget(
                          color: profession,
                        ),
                      ),
                      value: profession,
                    );
                  }).toList(),
                  selectedItemBuilder: (BuildContext context) {
                    return listOfColor.map<Widget>((item) {
                      return ItemColorWidget(
                        color: item,
                      );
                    }).toList();
                  },
                  isEnabled: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildLensesSizeForRightEyessWidget(
      {required BuildContext context,
      double? width,
      double? height,
      String? title}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        EdgeMargin.small,
        EdgeMargin.verySub,
        EdgeMargin.small,
        EdgeMargin.verySub,
      ),
      child: Container(
        width: width,
        padding:
            const EdgeInsets.fromLTRB(0.0, EdgeMargin.sub, 0.0, EdgeMargin.sub),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                title ?? '',
                style: textStyle.smallTSBasic.copyWith(
                  color: globalColor.black,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            LensSelectSizeWidget(
              onSelected: (lensesSelected) {
                _selectedForRightEye = lensesSelected;
                if (mounted) {
                  setState(() {});
                }
                print('lensesSelected is $lensesSelected');
              },
              width: width,
            )
          ],
        ),
      ),
    );
  }

  _buildLensesSizeForLeftEyessWidget({
    required BuildContext context,
    double? width,
    double? height,
    String? title,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        EdgeMargin.small,
        EdgeMargin.verySub,
        EdgeMargin.small,
        EdgeMargin.verySub,
      ),
      child: Container(
        width: width,
        padding:
            const EdgeInsets.fromLTRB(0.0, EdgeMargin.sub, 0.0, EdgeMargin.sub),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                title ?? '',
                style: textStyle.smallTSBasic.copyWith(
                  color: globalColor.black,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            LensSelectSizeWidget(
              onSelected: (lensesSelected) {
                _selectedForLeftEye = lensesSelected;
                if (mounted) {
                  setState(() {});
                }
                print('lensesSelected is $lensesSelected');
              },
              width: width,
            )
          ],
        ),
      ),
    );
  }

  _buildLensCompanyTitleWidget(
      {required BuildContext context, double? width, double? height}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        EdgeMargin.small,
        EdgeMargin.min,
        EdgeMargin.small,
        EdgeMargin.verySub,
      ),
      child: InkWell(
        onTap: () async {
          final result = await Get.Get.toNamed(LensesCompanyPage.routeName);
          if (result != null) {
            if (mounted)
              setState(() {
                companyLenses = result;
              });
          }
        },
        child: Container(
          width: width,
          height: 46.h,
          decoration: BoxDecoration(
              color: globalColor.white,
              borderRadius: BorderRadius.all(Radius.circular(12.w)),
              border: Border.all(
                  color: globalColor.grey.withOpacity(0.3), width: 0.5)),
          padding: const EdgeInsets.fromLTRB(
              EdgeMargin.min, EdgeMargin.sub, EdgeMargin.min, EdgeMargin.sub),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  child: Text(
                    Translations.of(context).translate('lens_company'),
                    style: textStyle.smallTSBasic.copyWith(
                        fontWeight: FontWeight.w500, color: globalColor.black),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      companyLenses?.name ?? '',
                      style: textStyle.smallTSBasic.copyWith(
                          fontWeight: FontWeight.w500,
                          color: globalColor.black),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 25.w,
                    color: globalColor.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildEnterDimensionsTitleWidget(
      {required BuildContext context, double? width, double? height}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        EdgeMargin.small,
        EdgeMargin.verySub,
        EdgeMargin.small,
        EdgeMargin.verySub,
      ),
      child: Container(
        width: width,
        height: 46.h,
        decoration: BoxDecoration(
            color: globalColor.white,
            borderRadius: BorderRadius.all(Radius.circular(12.w)),
            border: Border.all(
                color: globalColor.grey.withOpacity(0.3), width: 0.5)),
        padding: const EdgeInsets.fromLTRB(
            EdgeMargin.min, EdgeMargin.sub, EdgeMargin.min, EdgeMargin.sub),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: Text(
                  Translations.of(context)
                      .translate('attach_the_size_of_the_lenses'),
                  style: textStyle.smallTSBasic.copyWith(
                      fontWeight: FontWeight.w500, color: globalColor.black),
                ),
              ),
            ),
            Icon(
              utils.getLang() == 'ar'
                  ? Icons.keyboard_arrow_left
                  : Icons.keyboard_arrow_right,
              size: 25.w,
              color: globalColor.black,
            ),
          ],
        ),
      ),
    );
  }

  _buildEnterDimensionsOfLensesWidget(
      {required BuildContext context, double? width, double? height}) {
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
                      Translations.of(context).translate('enter_the_sizes'),
                      style: textStyle.smallTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(
                EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
            child: LensSelectIpdAddWidget(
              onSelected: (lensesSelected) {
                _selectedForAddIPD = lensesSelected;
                if (mounted) {
                  setState(() {});
                }
                print('lensesSelected is $lensesSelected');
              },
              width: width,
            ),
          ),
          // Container(
          //   child: Row(
          //     children: [
          //       Expanded(
          //           flex: 1,
          //           child: Padding(
          //             padding: const EdgeInsets.all(EdgeMargin.subSubMin),
          //             child: Container(
          //               child: BorderFormField(
          //                 controller: addEditingController,
          //                 validator: (value) {
          //                   return BaseValidator.validateValue(
          //                     context,
          //                     value,
          //                     [],
          //                     _addValidation,
          //                   );
          //                 },
          //                 hintText: 'ADD',
          //                 hintStyle: textStyle.smallTSBasic.copyWith(
          //                     color: globalColor.grey,
          //                     fontWeight: FontWeight.bold),
          //                 style: textStyle.smallTSBasic.copyWith(
          //                     color: globalColor.black,
          //                     fontWeight: FontWeight.bold),
          //                 filled: true,
          //                 fillColor: globalColor.white,
          //                 keyboardType: TextInputType.number,
          //                 borderRadius: 12.w,
          //                 onChanged: (value) {
          //                   setState(() {
          //                     _addValidation = true;
          //                     _add = value;
          //                   });
          //                 },
          //                 textAlign: TextAlign.center,
          //                 borderColor: globalColor.grey.withOpacity(0.3),
          //                 textInputAction: TextInputAction.next,
          //                 onFieldSubmitted: (_) {
          //                   FocusScope.of(context).nextFocus();
          //                 },
          //               ),
          //             ),
          //           )),
          //       HorizontalPadding(
          //         percentage: 0.5,
          //       ),
          //       Expanded(
          //         flex: 1,
          //         child: Padding(
          //           padding: const EdgeInsets.all(EdgeMargin.subSubMin),
          //           child: Container(
          //             child: BorderFormField(
          //               controller: ipdEditingController,
          //               validator: (value) {
          //                 return BaseValidator.validateValue(
          //                   context,
          //                   value,
          //                   [],
          //                   _ipdWidthValidation,
          //                 );
          //               },
          //               hintText: 'IPD',
          //               hintStyle: textStyle.smallTSBasic.copyWith(
          //                   color: globalColor.grey,
          //                   fontWeight: FontWeight.bold),
          //               style: textStyle.smallTSBasic.copyWith(
          //                   color: globalColor.black,
          //                   fontWeight: FontWeight.bold),
          //               filled: true,
          //               fillColor: globalColor.white,
          //               keyboardType: TextInputType.number,
          //               borderRadius: 12.w,
          //               onChanged: (value) {
          //                 setState(() {
          //                   _ipdWidthValidation = true;
          //                   _ipd = value;
          //                 });
          //               },
          //               textAlign: TextAlign.center,
          //               borderColor: globalColor.grey.withOpacity(0.3),
          //               textInputAction: TextInputAction.next,
          //               onFieldSubmitted: (_) {
          //                 FocusScope.of(context).nextFocus();
          //               },
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  _buildSelectLensesTypeWidget(
      {required BuildContext context, double? width, double? height}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        EdgeMargin.small,
        EdgeMargin.verySub,
        EdgeMargin.small,
        EdgeMargin.verySub,
      ),
      child: Container(
        width: width!,
        height: 46.h,
        decoration: BoxDecoration(
            color: globalColor.white,
            borderRadius: BorderRadius.all(Radius.circular(12.w)),
            border: Border.all(
                color: globalColor.grey.withOpacity(0.3), width: 0.5)),
        padding: const EdgeInsets.fromLTRB(
            EdgeMargin.min, EdgeMargin.sub, EdgeMargin.min, EdgeMargin.sub),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                Translations.of(context).translate('type_of_lenses'),
                style: textStyle.smallTSBasic.copyWith(
                    fontWeight: FontWeight.w500, color: globalColor.black),
              ),
            ),
            HorizontalPadding(
              percentage: 3,
            ),
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    radioButtonItem(
                        title: Translations.of(context).translate('Medical'),
                        isActive: _chooseType == TypeOfLensesChoose.Medical,
                        onTap: () {
                          if (mounted)
                            setState(() {
                              _chooseType = TypeOfLensesChoose.Medical;
                            });
                        }),
                    HorizontalPadding(
                      percentage: 2,
                    ),
                    radioButtonItem(
                        title: Translations.of(context).translate('Zenia'),
                        isActive: _chooseType == TypeOfLensesChoose.Zenia,
                        onTap: () {
                          if (mounted)
                            setState(() {
                              _chooseType = TypeOfLensesChoose.Zenia;
                            });
                        }),
                  ],
                ),
              ),
            ),
            Icon(
              utils.getLang() == 'ar'
                  ? Icons.keyboard_arrow_left
                  : Icons.keyboard_arrow_right,
              size: 25.w,
              color: globalColor.black,
            ),
          ],
        ),
      ),
    );
  }

  radioButtonItem({String? title, bool? isActive, Function? onTap}) {
    return InkWell(
      onTap: onTap!() ?? () {},
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            isActive != null && isActive
                ? Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: globalColor.goldColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1.0, color: globalColor.primaryColor)),
                    child: Icon(
                      Icons.check,
                      color: globalColor.black,
                      size: 14,
                    ),
                  )
                : Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: globalColor.backgroundGreyLight,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1.0,
                            color: globalColor.grey.withOpacity(0.3))),
                    child: Center(
                      child: Text(''),
                    ),
                  ),
            Container(
                padding: const EdgeInsets.only(
                    left: EdgeMargin.sub, right: EdgeMargin.sub),
                child: Text(
                  title ?? '',
                  style: textStyle.minTSBasic.copyWith(
                      fontWeight: FontWeight.w500, color: globalColor.black),
                ))
          ],
        ),
      ),
    );
  }

  // _buildSelectCompanyWidget({
  //   BuildContext context,
  //   double width,
  //   double height,
  //   TextEditingController controller,
  //   bool textValidation,
  //   String text,
  // }) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: globalColor.white,
  //       borderRadius: BorderRadius.all(Radius.circular(12.w)),
  //       border:
  //       Border.all(color: globalColor.grey.withOpacity(0.3), width: 0.5),
  //     ),
  //     //   margin: const EdgeInsets.only(left: EdgeMargin.verySub,),
  //     height: height,
  //     width: width,
  //
  //     child: Row(
  //       children: [
  //         Expanded(
  //           flex: 1,
  //           child: Container(
  //             child: Padding(
  //               padding: const EdgeInsets.fromLTRB(
  //                 EdgeMargin.subMin,
  //                 EdgeMargin.verySub,
  //                 EdgeMargin.subMin,
  //                 EdgeMargin.verySub,
  //               ),
  //               child: Text(
  //                 Translations.of(context)
  //                     .translate('choose_a_shipping_company'),
  //                 style:
  //                 textStyle.smallTSBasic.copyWith(color: globalColor.black),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Container(
  //           width: 1.0,
  //           color: globalColor.grey.withOpacity(0.3),
  //         ),
  //         Expanded(
  //           flex: 1,
  //           child: Container(
  //             padding: const EdgeInsets.fromLTRB(
  //               EdgeMargin.subMin,
  //               EdgeMargin.verySub,
  //               EdgeMargin.subMin,
  //               EdgeMargin.verySub,
  //             ),
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Expanded(
  //                   child: Container(
  //                     // width: widget.width * .4,
  //                     height: 35.h,
  //                     child: Custom2Dropdown<ShippingCarriersEntity>(
  //                       onChanged: (data) {
  //                         _shippingCarriers = data;
  //                         if (mounted) setState(() {});
  //                       },
  //                       value: _shippingCarriers,
  //                       borderRadius: 0,
  //                       hint: '',
  //                       dropdownMenuItemList:
  //                       _listOfShippingCarriers.map((profession) {
  //                         return DropdownMenuItem(
  //                           child: Container(
  //                             width: width,
  //                             decoration: BoxDecoration(
  //                                 color: profession == _shippingCarriers
  //                                     ? globalColor.primaryColor
  //                                     .withOpacity(0.3)
  //                                     : globalColor.white,
  //                                 borderRadius:
  //                                 BorderRadius.all(Radius.circular(12.w))),
  //                             padding: EdgeInsets.all(EdgeMargin.small),
  //                             child: Container(
  //                               child: Center(
  //                                 child: Text(
  //                                   profession.name ?? '',
  //                                   style: textStyle.smallTSBasic.copyWith(
  //                                       color: globalColor.primaryColor),
  //                                 ),
  //                               ),
  //                               alignment: AlignmentDirectional.center,
  //                             ),
  //                           ),
  //                           value: profession ?? null,
  //                         );
  //                       }).toList(),
  //                       selectedItemBuilder: (BuildContext context) {
  //                         return _listOfShippingCarriers.map<Widget>((item) {
  //                           return Center(
  //                             child: Text(
  //                               item.name ?? '',
  //                               style: textStyle.smallTSBasic
  //                                   .copyWith(color: globalColor.primaryColor),
  //                             ),
  //                           );
  //                         }).toList();
  //                       },
  //                       isEnabled: true,
  //                     ),
  //                   ),
  //                 ),
  //                 // Expanded(
  //                 //   child: Container(
  //                 //     child: Text(
  //                 //       'ارامكس',
  //                 //       style: textStyle.smallTSBasic
  //                 //           .copyWith(color: globalColor.primaryColor),
  //                 //     ),
  //                 //     alignment: AlignmentDirectional.center,
  //                 //   ),
  //                 // ),
  //                 // Container(
  //                 //   child: Icon(
  //                 //     MaterialIcons.keyboard_arrow_down,
  //                 //     color: globalColor.black,
  //                 //   ),
  //                 // ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  _buildButtonsWidget(
      {required BuildContext context, double? widthC, double? height}) {
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
                width: widthC! * .35,
                color: globalColor.primaryColor,
                onPressed: () {
                  print('_add_add_add');
                  if (_checkStatus()) {
                    Get.Get.back(
                        result: SelectLensesArgs(
                      type: _chooseType,
                      lensSize: _selectedForAddIPD,
                      colorSelect: _colorSelect,
                      companyLenses: companyLenses,
                      sizeForLeftEye: _selectedForLeftEye,
                      sizeForRightEye: _selectedForRightEye,
                    ));
                  }
                },
                borderRadius: 8.w,
                child: Container(
                  child: Center(
                    child: Text(
                      Translations.of(context).translate('continue'),
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
                onPressed: () {},
                borderRadius: 8.w,
                child: Container(
                  child: Center(
                    child: Text(
                      Translations.of(context).translate('back'),
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

  _checkStatus() {
    // print('_add ${_add}');
    // print('_ipd ${_ipd}');
    print('_selectedForLeftEye ${_selectedForLeftEye.toString()}');
    print('_selectedForRightEye ${_selectedForRightEye.toString()}');
    return _selectedForAddIPD != null &&
        _selectedForLeftEye != null &&
        _selectedForRightEye != null &&
        companyLenses != null &&
        _colorSelect != null &&
        _chooseType != null;
  }
}

enum TypeOfLensesChoose { Zenia, Medical }
