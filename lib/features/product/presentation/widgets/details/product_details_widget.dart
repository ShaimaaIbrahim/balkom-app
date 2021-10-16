import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ojos_app/core/bloc/application_bloc.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/providers/cart_provider.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/dailog/add_to_cart_dialog.dart';
import 'package:ojos_app/core/ui/dailog/login_first_dialog.dart';
import 'package:ojos_app/core/ui/widget/image/image_caching.dart';
import 'package:ojos_app/core/ui/widget/text/normal_form_field.dart';
import 'package:ojos_app/core/ui/widget/title_with_view_all_widget.dart';
import 'package:ojos_app/core/validators/base_validator.dart';
import 'package:ojos_app/features/product/domin/entities/cart_entity.dart';
import 'package:ojos_app/features/product/domin/entities/image_info_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_details_entity.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';
import 'package:ojos_app/features/product/domin/usecases/add_remove_favorite.dart';
import 'package:ojos_app/features/product/presentation/args/select_lenses_args.dart';
import 'package:ojos_app/features/user_management/domain/repositories/user_repository.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../main.dart';
import '../../../domin/entities/general_item_entity.dart';
import '../item_product_home_widget.dart';

class ProductDetailsWidget extends StatefulWidget {
  double? width;
  double? height;
  ProductEntity? product;
  ProductDetailsEntity? productDetails;
  CancelToken? cancelToken;

  ProductDetailsWidget(
      {this.height,
      this.width,
      this.product,
      this.productDetails,
      this.cancelToken});

  @override
  _ProductDetailsWidgetState createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  PageController controller =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  var currentPageValue = 0;

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
  bool? isAuth;
  SelectLensesArgs? selectLensesArgs;

  bool _isDisplaySizeList = true;

  List<int>? listOfColorSelected;
  GeneralItemEntity? color;
  List<int>? listOfSizeMode;
  int? SizeModeId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listOfColorSelected = [];
    listOfSizeMode = [];
    color = null;
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.width ?? globalSize.setWidthPercentage(100, context);
    final height =
        widget.height ?? globalSize.setHeightPercentage(100, context);

    isAuth =
        BlocProvider.of<ApplicationBloc>(context).state.isUserAuthenticated ||
            BlocProvider.of<ApplicationBloc>(context).state.isUserVerified;
    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            color: globalColor.white,
            // borderRadius: BorderRadius.all(Radius.circular(12.w))
          ),
          child: Column(
            children: [
              _buildTopWidget(
                  context: context,
                  width: width,
                  height: height,
                  discountPrice: widget.productDetails!.discountPrice,
                  discountType: widget.productDetails!.discountTypeInt,
                  product: widget.productDetails!,
                  productEntity: widget.product),
              _buildTitleAndPriceWidget(
                  context: context,
                  width: width,
                  height: height,
                  price: widget.productDetails!.price,
                  discountPrice: widget.productDetails!.discountPrice,
                  discountType: widget.productDetails!.discountTypeInt,
                  name: widget.productDetails!.name,
                  companyName: widget.productDetails!.shopInfo!.name),
              _divider(),
              _buildSimilarProducts(
                  context: context, width: width, height: height),
              VerticalPadding(
                percentage: 2.5,
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildTopWidget(
      {required BuildContext context,
      required double width,
      required double height,
      required int? discountType,
      required double? discountPrice,
      required ProductDetailsEntity? product,
      required ProductEntity? productEntity}) {
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
                product!.photoInfo != null && product.photoInfo!.isNotEmpty
                    ? PageView(
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: product.photoInfo!
                            .map((item) => Stack(
                                  children: [
                                    Container(
                                      width: width,
                                      height: 236.h,
                                      child: ImageCacheWidget(
                                        imageUrl: item.image ?? '',
                                        imageWidth: width,
                                        imageHeight: 236.h,
                                        boxFit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ))
                            .toList(),
                      )
                    : Container(
                        width: width,
                        height: 236.h,
                        child: ImageCacheWidget(
                          imageUrl: product.image ?? '',
                          imageWidth: width,
                          imageHeight: 236.h,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                /*       Positioned(
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
                ),*/
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
                Positioned(left: 4, top: 4, child: _buildAddFavoriteWidget()),
              ],
            ),
            product.photoInfo!.isNotEmpty
                ? Positioned(
                    bottom: 10,
                    child: _buildPageIndicator2(
                        width: width, list: product.photoInfo!))
                : Container()
          ],
        ),
      ),
    );
  }

  _buildAddFavoriteWidget() {
    return InkWell(
      onTap: () async {
        final result = await AddOrRemoveFavorite(locator<ProductRepository>())(
          AddOrRemoveFavoriteParams(
              cancelToken: widget.cancelToken!, productId: widget.product!.id!),
        );
        if (result.hasDataOnly) {
          if (mounted)
            setState(() {
              // isRemoveFromFavorite = true;
              //
              // BlocProvider.of<ApplicationBloc>(context)
              //     .state
              //     .setRefreshFavoritePath(true);
              widget.productDetails!.isFavorite =
                  !widget.productDetails!.isFavorite!;
              // widget.path.setIsFav(!widget.path.isFav);
            });
        } else if (result.hasErrorOnly || result.hasDataAndError)
          Fluttertoast.showToast(
              msg: Translations.of(context)
                  .translate('something_went_wrong_try_again'));
      },
      child: Container(
        decoration: BoxDecoration(
            color: globalColor.white,
            borderRadius: BorderRadius.circular(16.0.w),
            border: Border.all(
                width: 0.5, color: globalColor.grey.withOpacity(0.3))),
        height: 35.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              AppAssets.love,
              color: globalColor.black,
              width: 20.w,
            ),
            Text(
              Translations.of(context).translate('favorite'),
              style: textStyle.smallTSBasic.copyWith(
                  fontWeight: FontWeight.w500, color: globalColor.primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  _buildAddCartWidget(
      {required BuildContext context,
      required double width,
      required double height,
      ProductDetailsEntity? productEntity,
      bool? isAuth}) {
    return Consumer<CartProvider>(builder: (context, quizProvider, child) {
      return InkWell(
        onTap: () async {
          if (await UserRepository.hasToken && isAuth!) {
            // if((color!=null&&color.id!=null) && SizeModeId!=null ){
            //
            //
            // }else{
            //   appConfig.showToast(msg:Translations.of(context).translate('you_must_choose_size_and_color'));
            // }

            quizProvider.addItemToCart(CartEntity(
                id: productEntity!.id,
                productEntity: productEntity,
                isGlasses: productEntity.isGlasses,
                // colorId: color?.id,
                // lensSize: null,
                // sizeForLeftEye: null,
                // SizeModeId: SizeModeId,
                // sizeForRightEye: null,
                // argsForGlasses: selectLensesArgs,
                count: 1));
            print('${quizProvider.getItems()!.length}');
            showDialog(
              context: context,
              builder: (ctx) => AddToCartDialog(),
            );
          } else {
            showDialog(
              context: context,
              builder: (ctx) => LoginFirstDialog(),
            );
          }

          // quizProvider.addItemToCart(CartEntity(
          //     id: productEntity.id,
          //     productEntity: productEntity,
          //     isGlasses: productEntity.isGlasses,
          //     addSize: null,
          //     ipdSize: null,
          //     sizeForLeftEye: null,
          //     sizeForRightEye: null,
          //     count: 1));
          // print('${quizProvider.getItems().length}');
          // showDialog(
          //   context: context,
          //   builder: (ctx) => AddToCartDialog(),
          // );
        },
        child: Container(
          decoration: BoxDecoration(
              color: globalColor.white,
              borderRadius: BorderRadius.circular(16.0.w),
              border: Border.all(
                  width: 0.5, color: globalColor.grey.withOpacity(0.3))),
          height: 35.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                AppAssets.cart_nav_bar,
                color: globalColor.black,
                width: 20.w,
              ),
              Text(
                Translations.of(context).translate('add_to_cart'),
                style: textStyle.smallTSBasic.copyWith(
                    fontWeight: FontWeight.w500,
                    color: globalColor.primaryColor),
              ),
            ],
          ),
        ),
      );
    });
  }

  _buildPageIndicator2(
      {required double width, required List<ImageInfoEntity> list}) {
    return Container(
      alignment: AlignmentDirectional.center,
      width: width,
      child: SmoothPageIndicator(
          controller: controller, //// PageController
          count: list.length,
          effect: WormEffect(
            spacing: 4.0,
            radius: 10.0,
            dotWidth: 10.0,
            dotHeight: 10.0,
            dotColor: Colors.white,
            paintStyle: PaintingStyle.fill,
            strokeWidth: 2,
            activeDotColor: globalColor.primaryColor,
          ), // your preferred effect
          onDotClicked: (index) {}),
    );
  }

  _buildTitleAndPriceWidget(
      {required BuildContext context,
      required double width,
      required double height,
      required double? price,
      required double? discountPrice,
      required int? discountType,
      required String? name,
      required String? companyName}) {
    return Container(
      width: width,
      padding:
          const EdgeInsets.fromLTRB(EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                alignment: AlignmentDirectional.centerStart,
              ),
              SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.fromLTRB(
                    EdgeMargin.subSubMin,
                    EdgeMargin.verySub,
                    EdgeMargin.subSubMin,
                    EdgeMargin.verySub),
                child: _buildPrice2Widget(
                    price: price,
                    width: width,
                    discountPrice: discountPrice ?? 0.0),
              ),
            ],
          ),
          Spacer(),
          _buildAddCartWidget(
              context: context,
              width: width,
              height: height,
              productEntity: widget.productDetails,
              isAuth: isAuth)
        ],
      ),
    );
  }

  _onSelectSize(GeneralItemEntity size, bool isSelected) {
    if (isSelected) {
      if (mounted) {
        setState(() {
          SizeModeId = size.id;
          //  listOfSizeMode.add(size.id);
        });
      }
    } else {
      if (mounted)
        setState(() {
          //  listOfSizeMode.removeWhere((element) => element == size.id);
        });
    }

    // print('listOfSizeMode ${listOfSizeMode.toString()}');
  }

  _onSelectColors(GeneralItemEntity colors, bool isSelected) {
    if (isSelected) {
      if (mounted) {
        setState(() {
          color = colors;
          // listOfColorSelected.add(colors.id);
        });
      }
    } else {
      if (mounted)
        setState(() {
          // listOfColorSelected.removeWhere((element) => element == colors.id);
        });
    }

    //  print('listOfYourSelected ${listOfColorSelected.toString()}');
  }

/*  _buildAddToCartAndFavoriteWidget(
      {required BuildContext context,
      required double width,
      required double height,
      required ProductDetailsEntity productEntity,
      required bool isAuth}) {
    return Container(
      padding:
          const EdgeInsets.fromLTRB(EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () async {
                final result =
                    await AddOrRemoveFavorite(locator<ProductRepository>())(
                  AddOrRemoveFavoriteParams(
                      cancelToken: widget.cancelToken!,
                      productId: widget.product!.id!),
                );
                if (result.hasDataOnly) {
                  if (mounted)
                    setState(() {
                      setRefreshFavoritePath(true);
                      widget.productDetails!.isFavorite =
                          !widget.productDetails!.isFavorite!;
                      // widget.path.setIsFav(!widget.path.isFav);
                    });
                } else if (result.hasErrorOnly || result.hasDataAndError)
                  Fluttertoast.showToast(
                      msg: Translations.of(context)
                          .translate('something_went_wrong_try_again'));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: globalColor.white,
                    borderRadius: BorderRadius.circular(16.0.w),
                    border: Border.all(
                        width: 0.5, color: globalColor.grey.withOpacity(0.3))),
                height: 35.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      widget.productDetails!.isFavorite!
                          ? AppAssets.love_fill
                          : AppAssets.love,
                      //color: globalColor.black,
                      width: 20.w,
                    ),
                    Text(
                      Translations.of(context).translate('favorite'),
                      style: textStyle.smallTSBasic.copyWith(
                          fontWeight: FontWeight.w500,
                          color: globalColor.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          HorizontalPadding(
            percentage: 2.0,
          ),
          Consumer<CartProvider>(
            builder: (context, quizProvider, child) {
              return Expanded(
                flex: 3,
                child: InkWell(
                  onTap: () async {
                    if (await UserRepository.hasToken && isAuth) {
                      // if((color!=null&&color.id!=null) && SizeModeId!=null ){
                      //
                      //
                      // }else{
                      //   appConfig.showToast(msg:Translations.of(context).translate('you_must_choose_size_and_color'));
                      // }

                      quizProvider.addItemToCart(CartEntity(
                          id: productEntity.id,
                          productEntity: productEntity,
                          isGlasses: productEntity.isGlasses,
                          // colorId: color?.id,
                          // lensSize: null,
                          // sizeForLeftEye: null,
                          // SizeModeId: SizeModeId,
                          // sizeForRightEye: null,
                          // argsForGlasses: selectLensesArgs,
                          count: 1));
                      print('${quizProvider.getItems()!.length}');
                      showDialog(
                        context: context,
                        builder: (ctx) => AddToCartDialog(),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (ctx) => LoginFirstDialog(),
                      );
                    }

                    // quizProvider.addItemToCart(CartEntity(
                    //     id: productEntity.id,
                    //     productEntity: productEntity,
                    //     isGlasses: productEntity.isGlasses,
                    //     addSize: null,
                    //     ipdSize: null,
                    //     sizeForLeftEye: null,
                    //     sizeForRightEye: null,
                    //     count: 1));
                    // print('${quizProvider.getItems().length}');
                    // showDialog(
                    //   context: context,
                    //   builder: (ctx) => AddToCartDialog(),
                    // );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: globalColor.white,
                        borderRadius: BorderRadius.circular(16.0.w),
                        border: Border.all(
                            width: 0.5,
                            color: globalColor.grey.withOpacity(0.3))),
                    height: 35.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          AppAssets.cart_nav_bar,
                          color: globalColor.black,
                          width: 20.w,
                        ),
                        Text(
                          Translations.of(context).translate('add_to_cart'),
                          style: textStyle.smallTSBasic.copyWith(
                              fontWeight: FontWeight.w500,
                              color: globalColor.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }*/

  _buildSimilarProducts(
      {required BuildContext context,
      required double width,
      required double height}) {
    return Container(
      child: widget.productDetails!.productAsSame!.isNotEmpty
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: EdgeMargin.small, right: EdgeMargin.small),
                  child: TitleWithViewAllWidget(
                    width: width,
                    title:
                        Translations.of(context).translate('similar_products'),
                    onClickView: () {},
                    strViewAll: Translations.of(context).translate('view_all'),
                  ),
                ),
                Container(
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.productDetails!.productAsSame!.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio:
                              globalSize.setWidthPercentage(47, context) /
                                  globalSize.setWidthPercentage(60, context),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ItemProductHomeWidget(
                            height: globalSize.setWidthPercentage(60, context),
                            width: globalSize.setWidthPercentage(47, context),
                            product:
                                widget.productDetails!.productAsSame![index],
                          );
                        }))
              ],
            )
          : Container(),
    );
  }

  _divider() {
    return Divider(
      color: globalColor.grey.withOpacity(0.3),
      height: 8.h,
    );
  }

  _buildPriceWidget(
      {required double? price,
      required double? discountPrice,
      required double width,
      required double height}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          discountPrice != null && discountPrice != 0.0
              ? Container(
                  child: FittedBox(
                  child: RichText(
                    text: TextSpan(
                      text: '${price!.toString()}',
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
                      text: price!.toString(),
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
        ],
      ),
    );
  }

  _buildPrice2Widget(
      {required double? price,
      required double? discountPrice,
      required double width}) {
    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Flexible(
            child: RichText(
              text: TextSpan(
                text: '${discountPrice.toString()}',
                style: textStyle.smallTSBasic.copyWith(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough,
                    color: globalColor.grey),
                children: <TextSpan>[
                  new TextSpan(
                      text: ' ${Translations.of(context).translate('rail')}',
                      style: textStyle.subMinTSBasic
                          .copyWith(color: globalColor.grey)),
                ],
              ),
            ),
          )),
          SizedBox(width: 10),
          Container(
              child: Flexible(
            child: RichText(
              text: TextSpan(
                text: price.toString(),
                style: textStyle.smallTSBasic.copyWith(
                    fontWeight: FontWeight.bold,
                    color: globalColor.primaryColor),
                children: <TextSpan>[
                  new TextSpan(
                      text: ' ${Translations.of(context).translate('rail')}',
                      style: textStyle.subMinTSBasic
                          .copyWith(color: globalColor.black)),
                ],
              ),
            ),
          )),
          /* discountPrice != null && discountPrice.toString().isNotEmpty
              ? Container(
                  child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        discountPrice.toString(),
                        style: textStyle.smallTSBasic.copyWith(
                            fontWeight: FontWeight.bold,
                            color: globalColor.primaryColor),
                      ),
                      Text(' ${Translations.of(context).translate('rail')}',
                          style: textStyle.subMinTSBasic
                              .copyWith(color: globalColor.primaryColor)),
                    ],
                  ),
                ))
              : SizedBox.shrink(),*/
        ],
      ),
    );
  }
}
