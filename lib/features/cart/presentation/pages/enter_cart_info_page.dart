import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojos_app/core/appConfig.dart';
import 'package:ojos_app/core/bloc/application_bloc.dart';
import 'package:ojos_app/core/errors/connection_error.dart';
import 'package:ojos_app/core/errors/custom_error.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/providers/cart_provider.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/widget/button/rounded_button.dart';
import 'package:ojos_app/core/ui/widget/general_widgets/error_widgets.dart';
import 'package:ojos_app/features/cart/presentation/args/check_and_pay_args.dart';
import 'package:ojos_app/features/cart/presentation/args/enter_info_cart_args.dart';
import 'package:ojos_app/features/order/data/requests/order_request.dart';
import 'package:ojos_app/features/order/presentation/blocs/send_order_bloc.dart';
import 'package:ojos_app/features/user_management/presentation/widgets/user_management_text_field_widget.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/xternal_lib/model_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../../main_root.dart';
import 'check_pay_page.dart';

class EnterCartInfoPage extends StatefulWidget {
  static const routeName = '/cart/sub_pages/pages/EnterCartInfoPage';

  @override
  _EnterCartInfoPageState createState() => _EnterCartInfoPageState();
}

class _EnterCartInfoPageState extends State<EnterCartInfoPage> {
  final args = Get.Get.arguments as CheckAndPayArgs;

  bool sendRequest = true;

  final _bloc = SendOrderBloc();
  var _cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// message parameters
  bool _cityValidation = false;
  String _city = '';
  final TextEditingController cityEditingController =
      new TextEditingController();

  String? Astreet = "_street";

  /// phone parameters
  bool _phoneValidation = false;
  String _phone = '';
  final TextEditingController phoneEditingController =
      new TextEditingController();
  bool _phoneValidation2 = false;
  String _phone2 = '';
  final TextEditingController phoneEditingController2 =
      new TextEditingController();

  //
  // /// fullName parameters
  // bool _countryValidation = false;
  // String _country = '';
  // final TextEditingController countryEditingController =
  // new TextEditingController();
  // bool _streetValidation = false;
  // String _street = '';
  // final TextEditingController streetEditingController =
  // new TextEditingController();
  //
  // /// email parameters
  // bool _emailValidation = false;
  // String _email = '';
  // final TextEditingController emailEditingController =
  // new TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
        Translations.of(context).translate('delivery_info'),
        style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
      ),
      centerTitle: true,
    );

    double width = globalSize.setWidthPercentage(100, context);
    double height = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
        appBar: appBar,
        key: _scaffoldKey,
        backgroundColor: globalColor.scaffoldBackGroundGreyColor,
        body: BlocListener<SendOrderBloc, SendOrderState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is SendOrderDoneState) {
              //  ErrorViewer.showCustomError(context,Translations.of(context).translate('msg_contact_us_success'));
              appConfig.showToast(
                  msg: Translations.of(context)
                      .translate('order_successfully_added'));
              await Provider.of<CartProvider>(context, listen: false)
                  .initList();
              Get.Get.offAllNamed(MainRootPage.routeName);
              // Get.Get.offAllNamed(SignInPage.routeName);
            }
            if (state is SendOrderFailureState) {
              final error = state.error;
              if (error is ConnectionError) {
                ErrorViewer.showConnectionError(context, state.callback);
              } else if (error is CustomError) {
                ErrorViewer.showCustomError(context, error.message);
              } else {
                ErrorViewer.showUnexpectedError(context);
              }
            }
          },
          child: BlocBuilder<SendOrderBloc, SendOrderState>(
              bloc: _bloc,
              builder: (context, state) {
                return ModalProgressHUD(
                  inAsyncCall: state is SendOrderLoadingState,
                  color: globalColor.primaryColor,
                  opacity: 0.2,
                  child: Container(
                      height: height,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          child: Form(
                            key: _formKey,
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: EdgeMargin.min,
                                        right: EdgeMargin.min),
                                    child: NormalOjosTextFieldWidget(
                                      controller: phoneEditingController,
                                      // maxLines: 4,
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
                                      //validator: (value)=>phoneValidation(context, value),
                                      hintText: '',
                                      label: Translations.of(context)
                                          .translate('phone_number'),
                                      keyboardType: TextInputType.phone,
                                      borderRadius: width * .02,
                                      onChanged: (value) {
                                        setState(() {
                                          _phoneValidation = true;
                                          _phone = value;
                                        });
                                      },
                                      prefixIcon: Container(
                                        width: 15.w,
                                        height: 15.w,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            AppAssets.phoneSvg,
                                            color: globalColor.black,
                                            width: 15.w,
                                            height: 15.w,
                                          ),
                                        ),
                                      ),
                                      borderColor:
                                          globalColor.grey.withOpacity(0.3),
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context).nextFocus();
                                      },
                                      onTap: null,
                                    ),
                                  ),
                                  VerticalPadding(
                                    percentage: 2.0,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: EdgeMargin.min,
                                        right: EdgeMargin.min),
                                    child: NormalOjosTextFieldWidget(
                                      controller: phoneEditingController2,
                                      // maxLines: 4,
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
                                      //validator: (value)=>phoneValidation(context, value),
                                      hintText: '',
                                      label: Translations.of(context)
                                          .translate('phone_number2'),
                                      keyboardType: TextInputType.phone,
                                      borderRadius: width * .02,
                                      onChanged: (value) {
                                        setState(() {
                                          _phoneValidation2 = true;
                                          _phone2 = value;
                                        });
                                      },
                                      prefixIcon: Container(
                                        width: 15.w,
                                        height: 15.w,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            AppAssets.phoneSvg,
                                            color: globalColor.black,
                                            width: 15.w,
                                            height: 15.w,
                                          ),
                                        ),
                                      ),
                                      borderColor:
                                          globalColor.grey.withOpacity(0.3),
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
                                        left: EdgeMargin.min,
                                        right: EdgeMargin.min),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            child: RoundedButton(
                                          height: 50.h,
                                          width: width * .35,
                                          color: globalColor.primaryColor,
                                          onPressed: () {
                                            print(args.neighborhood_id);
                                            print(args.load_id);
                                            print(args.delivery_to);
                                            print(args.dest_name);
                                            print(args.guard_number);
                                            print(args.dest_type);

                                            setState(() {
                                              _phoneValidation2 = true;
                                              _phoneValidation = true;
                                              // _emailValidation = true;
                                              _cityValidation = true;
                                              // _countryValidation = true;
                                              // _streetValidation = true;
                                            });
                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (args.paymentMethods == 1) {
                                                Get.Get.toNamed(
                                                    CheckAndPayPage.routeName,
                                                    arguments:
                                                        EnterInfoCartArgs(
                                                      listOfOrder:
                                                          args.listOfOrder,
                                                      total: args.total,
                                                      city_id: args.city_id,
                                                      coupon_id: args.coupon_id,
                                                      couponcode:
                                                          args.couponcode,
                                                      note: args.note,
                                                      orginal_price:
                                                          args.orginal_price,
                                                      price_discount:
                                                          args.price_discount,
                                                      point_map: args.point_map,
                                                      shipping_fee:
                                                          args.shipping_fee,
                                                      shipping_id:
                                                          args.shipping_id,
                                                      tax: args.tax,
                                                      deliveryOrder:
                                                          DeliveryOrderRequest(
                                                        delivery_address:
                                                            BlocProvider.of<ApplicationBloc>(
                                                                        context)
                                                                    .state
                                                                    .profile
                                                                    ?.address ??
                                                                "_street",
                                                        delivery_city: _city,
                                                        delivery_email:
                                                            "_email",
                                                        delivery_mobile_1:
                                                            _phone,
                                                        delivery_mobile_2:
                                                            _phone2,
                                                        delivery_name: BlocProvider
                                                                    .of<ApplicationBloc>(
                                                                        context)
                                                                .state
                                                                .profile
                                                                ?.name ??
                                                            '',
                                                        delivery_phone:
                                                            BlocProvider.of<ApplicationBloc>(
                                                                        context)
                                                                    .state
                                                                    .profile
                                                                    ?.phone ??
                                                                '',
                                                        delivery_state:
                                                            "_street",
                                                        delivery_zipcode:
                                                            "_country",
                                                      ),
                                                      totalPrice:
                                                          args.totalPrice,
                                                      neighborhood_id:
                                                          args.neighborhood_id,
                                                      load_id: args.load_id,
                                                      delivery_to:
                                                          args.delivery_to,
                                                      dest_name: args.dest_name,
                                                      guard_number:
                                                          args.guard_number,
                                                      dest_type: args.dest_type,
                                                    ));
                                              } else {
                                                OrderRequest request =
                                                    OrderRequest(
                                                  subtotal: args.subtotal ?? 0,
                                                  total: args.total!.toInt(),
                                                  coupon_id: args.coupon_id,
                                                  tax: args.tax,
                                                  shipping_id: args.shipping_id,
                                                  shipping_fee:
                                                      args.shipping_fee,
                                                  point_map: args.point_map,
                                                  delivery_fee: 12,
                                                  discount: args.price_discount,
                                                  orginal_price:
                                                      args.orginal_price,
                                                  couponcode: args.couponcode,
                                                  city_id: args.city_id,
                                                  cartItems: args.listOfOrder!
                                                      .map((e) =>
                                                          ProductOrderRequest(
                                                              price: e
                                                                  .productEntity
                                                                  ?.price,
                                                              type_product: e
                                                                  .productEntity
                                                                  ?.type,
                                                              product_id: e
                                                                  .productEntity
                                                                  ?.id,
                                                              //  lens_size:e.lensSize==LensesIpdAddEnum.IPD?"IPD":"ADD",
                                                              quantity: e.count,
                                                              //  sizeMode: e.SizeModeId,
                                                              brand_id: e
                                                                  .productEntity
                                                                  ?.brandId,
                                                              //    color_id: e.colorId,
                                                              Is_Glasses: 1
                                                              //    lens_left_size: e.sizeForLeftEye == LensesSelectedEnum.CPH ? 'cph':e.sizeForLeftEye == LensesSelectedEnum.CYI ?'cyi' :'axis',
                                                              //    lens_right_size: e.sizeForRightEye == LensesSelectedEnum.CPH ? 'cph':e.sizeForLeftEye == LensesSelectedEnum.CYI ?'cyi' :'axis'
                                                              ))
                                                      .toList(),
                                                  note: args.note ?? '',
                                                  method_id:
                                                      args.paymentMethods ?? 0,
                                                  user_address_id: args.city_id,
                                                  card: null,
                                                  delivery:
                                                      DeliveryOrderRequest(
                                                    delivery_address: BlocProvider
                                                                .of<ApplicationBloc>(
                                                                    context)
                                                            .state
                                                            .profile
                                                            ?.address ??
                                                        "_street",
                                                    delivery_city: _city,
                                                    delivery_email: "_email",
                                                    delivery_mobile_1: _phone,
                                                    delivery_mobile_2: _phone2,
                                                    delivery_name: BlocProvider
                                                                .of<ApplicationBloc>(
                                                                    context)
                                                            .state
                                                            .profile
                                                            ?.name ??
                                                        '',
                                                    delivery_phone: BlocProvider
                                                                .of<ApplicationBloc>(
                                                                    context)
                                                            .state
                                                            .profile
                                                            ?.phone ??
                                                        '',
                                                    delivery_state: "_street",
                                                    delivery_zipcode:
                                                        "_country",
                                                  ),
                                                  neighborhood_id:
                                                      args.neighborhood_id,
                                                  load_id: args.load_id,
                                                  delivery_to: args.delivery_to,
                                                  dest_name: args.dest_name,
                                                  guard_number:
                                                      args.guard_number,
                                                  dest_type: args.dest_type,
                                                );
                                                print(
                                                    'Order Request ${request.toJson()}');

                                                _bloc.add(GetSendOrderEvent(
                                                    cancelToken: _cancelToken,
                                                    request: request));
                                              }
                                            }
                                          },
                                          borderRadius: 8.w,
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                args.paymentMethods != 8
                                                    ? Translations.of(context)
                                                        .translate('continue')
                                                    : Translations.of(context)
                                                        .translate('add'),
                                                style: textStyle.smallTSBasic
                                                    .copyWith(
                                                        color:
                                                            globalColor.white),
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
                                          width: width * .35,
                                          color:
                                              globalColor.backgroundLightPrim,
                                          onPressed: () {
                                            Get.Get.back();
                                          },
                                          borderRadius: 8.w,
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                Translations.of(context)
                                                    .translate('cancel'),
                                                style: textStyle.smallTSBasic
                                                    .copyWith(
                                                        color:
                                                            globalColor.black),
                                              ),
                                            ),
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                  VerticalPadding(
                                    percentage: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                );
              }),
        ));
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    _bloc.close();
    super.dispose();
  }
}
