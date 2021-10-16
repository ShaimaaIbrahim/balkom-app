import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ojos_app/core/appConfig.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/widget/button/rounded_button.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:ojos_app/core/validators/base_validator.dart';
import 'package:ojos_app/core/validators/required_validator.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';
import 'package:ojos_app/features/product/domin/usecases/add_review.dart';
import 'package:ojos_app/features/reviews/data/models/review_model.dart';
import 'package:ojos_app/features/user_management/presentation/widgets/user_management_text_field_widget.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/xternal_lib/model_progress_hud.dart';
import '../../../../main.dart';

class AddReviewPage extends StatefulWidget {
  static const routeName = '/review/pages/AddReviewPage';

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  List<ReviewModel>? _list;

  initList() {
    _list = [
      ReviewModel(
          title: ' نظارات شركة ايكيا الطبية',
          image: AppAssets.product_1,
          comment:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني بنصحكم تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم',
          gender: 'نسائية',
          isLensesFree: true,
          isNew: true,
          rate: 4.3,
          numOfRaters: 32,
          sales: '32'),
      ReviewModel(
          title: ' نظارات شركة ايكيا الطبية',
          image: AppAssets.product_1,
          comment:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني بنصحكم تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم',
          gender: 'نسائية',
          isLensesFree: false,
          isNew: true,
          rate: 4.3,
          numOfRaters: 32,
          sales: '32'),
      ReviewModel(
          title: ' نظارات شركة ايكيا الطبية',
          image: AppAssets.product_1,
          comment:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني بنصحكم تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم',
          gender: 'نسائية',
          isLensesFree: false,
          isNew: false,
          rate: 4,
          numOfRaters: 32,
          sales: '32'),
      ReviewModel(
          title: ' نظارات شركة ايكيا الطبية',
          image: AppAssets.product_1,
          comment:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني بنصحكم تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم',
          gender: 'نسائية',
          isLensesFree: true,
          isNew: false,
          rate: 5,
          numOfRaters: 32,
          sales: '32'),
    ];
  }

  /// revie parameters
  bool _reviewValidation = false;
  String _review = '';
  final TextEditingController reviewEditingController =
      new TextEditingController();

  double _rating = 2.0;
  final _formKey = GlobalKey<FormState>();

  final args = Get.Get.arguments as ProductEntity;
  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _cancelToken = CancelToken();

  bool send = false;

  @override
  Widget build(BuildContext context) {
    initList();
    //=========================================================================

    AppBar appBar = AppBar(
      backgroundColor: globalColor.appBar,
      brightness: Brightness.light,
      elevation: 0,
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      title: Text(
        Translations.of(context).translate('product_review'),
        style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
      ),
      centerTitle: true,
    );

    double width = globalSize.setWidthPercentage(100, context);
    double height = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    double priceAfterDiscount =
        (args.price ?? 0.0) - (args.discountPrice ?? 0.0);

    return Scaffold(
        appBar: appBar,
        key: _scaffoldKey,
        backgroundColor: globalColor.scaffoldBackGroundGreyColor,
        body: ModalProgressHUD(
          inAsyncCall: send,
          color: globalColor.primaryColor,
          opacity: 0.2,
          child: Container(
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Card(
                        color: globalColor.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0.w))),
                        child: Column(
                          children: [
                            _buildTopWidget(
                                context: context,
                                width: width,
                                height: height,
                                discountPrice: args.discountPrice,
                                discountType: args.discountTypeInt,
                                product: args),
                            _buildTitleAndPriceWidget(
                                context: context,
                                width: width,
                                height: height,
                                price: args.price,
                                priceAfterDiscount:
                                    priceAfterDiscount.toString(),
                                discountPrice: args.discountPrice,
                                discountType: args.discountTypeInt,
                                name: args.name,
                                isFree: args.lensesFree),
                            Divider(
                              color: globalColor.grey.withOpacity(0.3),
                              height: 2.0,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: EdgeMargin.subMin,
                                  right: EdgeMargin.subMin),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 126.h,
                                      // decoration: BoxDecoration(
                                      //     color: globalColor.white,
                                      //     borderRadius: BorderRadius.all(Radius.circular(12.0.w)),
                                      //     border: Border.all(
                                      //         color: globalColor.grey.withOpacity(0.3),
                                      //         width: 0.5
                                      //     )
                                      // ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            EdgeMargin.sub),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '${appConfig.notNullOrEmpty(args.rate) ? args.rate : '-'}',
                                              style: textStyle.lagerTSBasic
                                                  .copyWith(
                                                      color:
                                                          globalColor.goldColor,
                                                      fontWeight:
                                                          FontWeight.w400),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            Text(
                                              '${Translations.of(context).translate('producer_reviews')}',
                                              style: textStyle.minTSBasic
                                                  .copyWith(
                                                      color: globalColor.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            Text(
                                              '${Translations.of(context).translate('average')} ${args.productReviews?.length} ${Translations.of(context).translate('reviews')}',
                                              style: textStyle.sub2MinTSBasic
                                                  .copyWith(
                                                      color: globalColor.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // HorizontalPadding(
                                  //   percentage: 2.5,
                                  // ),
                                  Expanded(
                                      flex: 4,
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            _buildRateRow(
                                              rate: 5,
                                            ),
                                            VerticalPadding(
                                              percentage: 1,
                                            ),
                                            _buildRateRow(rate: 4),
                                            VerticalPadding(
                                              percentage: 1,
                                            ),
                                            _buildRateRow(rate: 3),
                                            VerticalPadding(
                                              percentage: 1,
                                            ),
                                            _buildRateRow(rate: 2),
                                            VerticalPadding(
                                              percentage: 1,
                                            ),
                                            _buildRateRow(rate: 1),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      VerticalPadding(
                        percentage: 2.0,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: EdgeMargin.min, right: EdgeMargin.min),
                        child: _buildDimensionsInputWidget(
                          width: width,
                          height: 60.h,
                          context: context,
                        ),
                      ),
                      VerticalPadding(
                        percentage: 2.0,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: EdgeMargin.min, right: EdgeMargin.min),
                        child: NormalOjosTextFieldWidget(
                          controller: reviewEditingController,
                          maxLines: 4,
                          filled: true,
                          style: textStyle.smallTSBasic.copyWith(
                              color: globalColor.black,
                              fontWeight: FontWeight.bold),
                          contentPadding: const EdgeInsets.fromLTRB(
                            EdgeMargin.small,
                            EdgeMargin.middle,
                            EdgeMargin.small,
                            EdgeMargin.small,
                          ),
                          fillColor: globalColor.white,
                          backgroundColor: globalColor.white,
                          labelBackgroundColor: globalColor.white,
                          validator: (value) {
                            return BaseValidator.validateValue(
                              context,
                              value!,
                              [RequiredValidator()],
                              _reviewValidation,
                            );
                          },
                          hintText: '',
                          label: Translations.of(context)
                              .translate('write_review'),
                          keyboardType: TextInputType.text,
                          borderRadius: width * .02,
                          onChanged: (value) {
                            setState(() {
                              _reviewValidation = true;
                              _review = value;
                            });
                          },
                          borderColor: globalColor.grey.withOpacity(0.3),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).nextFocus();
                          },
                        ),
                      ),
                      VerticalPadding(
                        percentage: 2.0,
                      ),
                      Container(
                          padding: const EdgeInsets.only(
                              left: EdgeMargin.min, right: EdgeMargin.min),
                          child: RoundedButton(
                            height: 55.h,
                            width: width,
                            color: globalColor.primaryColor,
                            onPressed: () async {
                              setState(() {
                                _reviewValidation = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                if (mounted)
                                  setState(() {
                                    send = true;
                                  });
                                final result = await AddReview(
                                    locator<ProductRepository>())(
                                  AddReviewParams(
                                      cancelToken: _cancelToken,
                                      productId: args.id!,
                                      rate: _rating,
                                      review: _review),
                                );
                                if (result.hasDataOnly) {
                                  if (mounted)
                                    setState(() {
                                      send = false;
                                    });
                                  Fluttertoast.showToast(
                                      msg: Translations.of(context)
                                          .translate('msg_success_review'));
                                  Get.Get.back();
                                } else if (result.hasErrorOnly ||
                                    result.hasDataAndError) {
                                  if (mounted)
                                    setState(() {
                                      send = false;
                                    });
                                  Fluttertoast.showToast(
                                      msg: Translations.of(context).translate(
                                          'something_went_wrong_try_again'));
                                }
                              }
                            },
                            borderRadius: 8.w,
                            child: Container(
                              child: Center(
                                child: Text(
                                  Translations.of(context).translate('review'),
                                  style: textStyle.middleTSBasic
                                      .copyWith(color: globalColor.white),
                                ),
                              ),
                            ),
                          )),
                      VerticalPadding(
                        percentage: 4.0,
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }

  _buildTopWidget(
      {required BuildContext context,
      double? width,
      double? height,
      int? discountType,
      double? discountPrice,
      ProductEntity? product}) {
    return Container(
      width: width,
      height: 236.h,
      padding: const EdgeInsets.fromLTRB(EdgeMargin.sub, EdgeMargin.verySub,
          EdgeMargin.sub, EdgeMargin.verySub),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: width,
                  height: 236.h,
                  child: ImageCacheWidget(
                    imageUrl: product!.image ?? '',
                    imageWidth: width!,
                    imageHeight: 236.h,
                    boxFit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: 4.0,
                  top: 4.0,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: globalColor.white,
                          borderRadius: BorderRadius.circular(12.0.w),
                        ),
                        height: height! * .035,
                        constraints: BoxConstraints(minWidth: width * .09),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: EdgeMargin.verySub,
                              right: EdgeMargin.verySub),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 2,
                              ),
                              SvgPicture.asset(
                                AppAssets.star,
                                width: 12,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '${appConfig.notNullOrEmpty(product.rate) ? product.rate : '-'}',
                                style: textStyle.smallTSBasic.copyWith(
                                    color: globalColor.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      product.isNew!
                          ? Container(
                              decoration: BoxDecoration(
                                color: globalColor.primaryColor,
                                borderRadius: BorderRadius.circular(12.0.w),
                              ),
                              height: height * .035,
                              constraints:
                                  BoxConstraints(minWidth: width * .15),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: EdgeMargin.verySub,
                                    right: EdgeMargin.verySub),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // SizedBox(
                                    //   width: 2,
                                    // ),
                                    SvgPicture.asset(
                                      AppAssets.newww,
                                      width: 12,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '${Translations.of(context).translate('new')}',
                                      style: textStyle.smallTSBasic.copyWith(
                                          color: globalColor.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              child: Text(''),
                            ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 4.0,
                  right: 4.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: globalColor.white,
                      borderRadius: BorderRadius.circular(12.0.w),
                    ),
                    height: height * .035,
                    constraints: BoxConstraints(minWidth: width * .1),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 2,
                          ),
                          SvgPicture.asset(
                            AppAssets.user,
                            width: 16,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            product.genderId == 38
                                ? '${Translations.of(context).translate('men')}'
                                : '${Translations.of(context).translate('women')}',
                            style: textStyle.minTSBasic.copyWith(
                              color: globalColor.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4.0,
                  left: 4.0,
                  child: discountType != null
                      ? Container(
                          decoration: BoxDecoration(
                              color: globalColor.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.w)),
                              border: Border.all(
                                  color: globalColor.grey.withOpacity(0.3),
                                  width: 0.5)),
                          padding: const EdgeInsets.fromLTRB(
                              EdgeMargin.subSubMin,
                              EdgeMargin.verySub,
                              EdgeMargin.subSubMin,
                              EdgeMargin.verySub),
                          child: discountType == 1
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${discountPrice ?? '-'} ${Translations.of(context).translate('rail')}',
                                      style: textStyle.smallTSBasic.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: globalColor.primaryColor),
                                    ),
                                    Text(
                                        ' ${Translations.of(context).translate('discount')}',
                                        style: textStyle.minTSBasic.copyWith(
                                            color: globalColor.black)),
                                  ],
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${discountPrice ?? '-'} %',
                                      style: textStyle.smallTSBasic.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: globalColor.primaryColor),
                                    ),
                                    Text(
                                        ' ${Translations.of(context).translate('discount')}',
                                        style: textStyle.minTSBasic.copyWith(
                                            color: globalColor.black)),
                                  ],
                                ),
                        )
                      : Container(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildTitleAndPriceWidget(
      {required BuildContext context,
      required double width,
      required double height,
      required double? price,
      String? priceAfterDiscount,
      double? discountPrice,
      int? discountType,
      String? name,
      bool? isFree}) {
    return Container(
      width: width,
      padding:
          const EdgeInsets.fromLTRB(EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Text(
                        '${name ?? ''}',
                        style: textStyle.middleTSBasic.copyWith(
                          color: globalColor.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          isFree != null && isFree
                              ? Container(
                                  width: 15.w,
                                  height: 15.w,
                                  decoration: BoxDecoration(
                                      color: globalColor.goldColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1.0,
                                          color: globalColor.primaryColor)),
                                  child: Icon(
                                    Icons.check,
                                    color: globalColor.black,
                                    size: 10.w,
                                  ),
                                )
                              : Container(
                                  width: 15.w,
                                  height: 15.w,
                                  decoration: BoxDecoration(
                                      color: globalColor.grey,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1.0,
                                          color: globalColor.grey
                                              .withOpacity(0.3))),
                                  child: Center(
                                    child: Text(''),
                                  ),
                                ),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: EdgeMargin.sub, right: EdgeMargin.sub),
                              child: Text(
                                '${Translations.of(context).translate('free_lenses')}',
                                style: textStyle.minTSBasic.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: globalColor.grey),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  padding: const EdgeInsets.fromLTRB(EdgeMargin.verySub,
                      EdgeMargin.sub, EdgeMargin.verySub, EdgeMargin.sub),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        // decoration: BoxDecoration(
                        //     color: globalColor.white,
                        //     borderRadius: BorderRadius.all(Radius.circular(12.w)),
                        //     border: Border.all(
                        //         color: globalColor.grey.withOpacity(0.3),
                        //         width: 0.5)),
                        padding: const EdgeInsets.fromLTRB(
                            EdgeMargin.subSubMin,
                            EdgeMargin.verySub,
                            EdgeMargin.subSubMin,
                            EdgeMargin.verySub),
                        child: _buildPriceWidget(
                            discountPrice: discountPrice!,
                            price: price!,
                            priceAfterDiscount: priceAfterDiscount!),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }

  _buildPriceWidget(
      {required double price,
      required double discountPrice,
      required String priceAfterDiscount}) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          discountPrice != null && discountPrice != 0.0
              ? Container(
                  child: FittedBox(
                  child: RichText(
                    text: TextSpan(
                      text: '${price.toString()}',
                      style: textStyle.middleTSBasic.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                          color: globalColor.grey),
                      children: <TextSpan>[
                        new TextSpan(
                            text:
                                ' ${Translations.of(context).translate('rail')}',
                            style: textStyle.smallTSBasic
                                .copyWith(color: globalColor.grey)),
                      ],
                    ),
                  ),
                ))
              : Container(
                  child: FittedBox(
                  child: RichText(
                    text: TextSpan(
                      text: price.toString(),
                      style: textStyle.middleTSBasic.copyWith(
                          fontWeight: FontWeight.bold,
                          color: globalColor.primaryColor),
                      children: <TextSpan>[
                        new TextSpan(
                            text:
                                ' ${Translations.of(context).translate('rail')}',
                            style: textStyle.smallTSBasic
                                .copyWith(color: globalColor.black)),
                      ],
                    ),
                  ),
                )),
          discountPrice != null && discountPrice != 0.0
              ? Container(
                  child: FittedBox(
                  child: RichText(
                    text: TextSpan(
                      text: priceAfterDiscount,
                      style: textStyle.middleTSBasic.copyWith(
                          fontWeight: FontWeight.bold,
                          color: globalColor.primaryColor),
                      children: <TextSpan>[
                        new TextSpan(
                            text:
                                ' ${Translations.of(context).translate('rail')}',
                            style: textStyle.smallTSBasic
                                .copyWith(color: globalColor.black)),
                      ],
                    ),
                  ),
                ))
              : Container(),
        ],
      ),
    );
  }

  _buildDimensionsInputWidget({
    required BuildContext context,
    required double width,
    required double height,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.white.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        border:
            Border.all(color: globalColor.grey.withOpacity(0.3), width: 0.5),
      ),
      //   margin: const EdgeInsets.only(left: EdgeMargin.verySub,),
      height: height,
      width: width,

      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: globalColor.white.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(12.w)),
                    border: Border.all(
                        color: globalColor.grey.withOpacity(0.3), width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      EdgeMargin.subMin,
                      EdgeMargin.verySub,
                      EdgeMargin.subMin,
                      EdgeMargin.verySub,
                    ),
                    child: Text(
                      Translations.of(context).translate('product_review'),
                      style: textStyle.minTSBasic
                          .copyWith(color: globalColor.black),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 1.0,
            color: globalColor.grey.withOpacity(0.3),
          ),
          Expanded(
            flex: 6,
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _rating.toString(),
                  style:
                      textStyle.bigTSBasic.copyWith(color: globalColor.black),
                ),
                HorizontalPadding(
                  percentage: 1,
                ),
                RatingBar.builder(
                  initialRating: 2,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  unratedColor: globalColor.grey.withOpacity(0.3),
                  itemCount: 5,
                  itemSize: 25.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });

                    print('_rating$_rating');
                  },
                  updateOnDrag: true,
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }

  _buildRateRow({required double rate, double? width}) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RatingBarIndicator(
            rating: rate,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 15.0,
            unratedColor: globalColor.grey.withOpacity(0.3),
            direction: Axis.horizontal,
          ),
          HorizontalPadding(
            percentage: 1.5,
          ),
          Expanded(
              child: Container(
            height: 1.0,
            color: globalColor.grey.withOpacity(0.3),
          )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }
}
