import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ojos_app/core/appConfig.dart';
import 'package:ojos_app/core/entities/shipping_carriers_entity.dart';
import 'package:ojos_app/core/errors/connection_error.dart';
import 'package:ojos_app/core/errors/custom_error.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/providers/cart_provider.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
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
import 'package:ojos_app/core/ui/widget/general_widgets/error_widgets.dart';
import 'package:ojos_app/core/ui/widget/text/normal_form_field.dart';
import 'package:ojos_app/core/usecases/get_cities.dart';
import 'package:ojos_app/core/usecases/get_shipping_carriers.dart';
import 'package:ojos_app/core/validators/base_validator.dart';
import 'package:ojos_app/features/cart/data/models/attrbut_cmodel.dart';
import 'package:ojos_app/features/cart/data/models/delevary_to.dart';
import 'package:ojos_app/features/cart/data/repositories/negabor_rebo.dart';
import 'package:ojos_app/features/cart/domin/entities/coupon_code_entity.dart';
import 'package:ojos_app/features/cart/presentation/args/check_and_pay_args.dart';
import 'package:ojos_app/features/cart/presentation/blocs/coupon_bloc.dart';
import 'package:ojos_app/features/cart/presentation/widgets/item_product_cart_widget.dart';
import 'package:ojos_app/features/order/domain/entities/city_order_entity.dart';
import 'package:ojos_app/features/user_management/presentation/widgets/user_management_text_field_widget.dart';
import 'package:ojos_app/xternal_lib/flutter_icon/src/material_icons.dart';
import 'package:ojos_app/xternal_lib/model_progress_hud.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart' as Get;
import '../../../../main.dart';
import 'enter_cart_info_page.dart';

class CartPage extends StatefulWidget {
  static const routeName = '/cart/pages/CartPage';
  final TabController? tabController;

  const CartPage({this.tabController});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  /// frame Height parameters
  bool _copontValidation = false;
  String _copon = '';
  TextEditingController coponEditingController = TextEditingController();

  /// phone parameters
  bool _phoneValidation = false;
  String _phone = '';
  final TextEditingController phoneEditingController =
      new TextEditingController();

  bool mosqueNameValidation = false;
  String mosqueName = '';
  final TextEditingController mosqueEditingController =
      new TextEditingController();

  bool recipientnumberValidation = false;
  String recipientnumberName = '0';
  final TextEditingController workerEditingController =
      new TextEditingController();

  late ShippingCarriersEntity _shippingCarriers; //null
  CityOrderEntity _city = CityOrderEntity(
    id: -1,
    name: '',
    shiping_time: '',
    status: false,
  );
  late var negaboor; //null

  late List<ShippingCarriersEntity> _listOfShippingCarriers;
  List<CityOrderEntity> _listOfCities = [];

  late List<ShippingCarriersEntity> _listOfPaymentMethods;
  late ShippingCarriersEntity _paymentMethods; //n

  CustomDrobDowenField deliveryTo =
      CustomDrobDowenField(ar: "المنزل", en: "home", key: "home");

  List<CustomDrobDowenField> deliveryList = [
    CustomDrobDowenField(ar: "مسجد", en: "mosque", key: "mosque"),
    CustomDrobDowenField(ar: "المنزل", en: "home", key: "home"),
    CustomDrobDowenField(ar: "العمل", en: "work", key: "work"),
    CustomDrobDowenField(ar: "استراحة", en: "reset", key: "rest"),
  ];
  GlobalKey<DropdownSearchState> _fbKey = GlobalKey();

  // Deliveryto attrbuotmodel;
  late Deliveryto prayerPlace;
  // late Deliveryto loadedAt;
  late List<Deliveryto> attrbuotmodelList = [];

  // List<CustomDrobDowenField>

  @override
  void initState() {
    super.initState();
    _getShippingCarriers(0);
    _getCities(0);

    getNega(city_id: _city.id ?? 1);
    coponEditingController = new TextEditingController();
    _listOfShippingCarriers = [
      ShippingCarriersEntity(
        id: null,
        name: utils.getLang() == 'ar' ? "غير محدد" : "Not Specified",
      )
    ];

    _listOfPaymentMethods = [
      ShippingCarriersEntity(
        id: 2,
        name: utils.getLang() == 'ar' ? "دفع عند الإستلام" : "Pay on receipt",
      ),
      ShippingCarriersEntity(
        id: 1,
        name: utils.getLang() == 'ar' ? "دفع الكتروني" : "Electronic payment",
      ),
    ];
    _paymentMethods = _listOfPaymentMethods[0];
    _listOfCities = [
      CityOrderEntity(
        id: 1,
        shiping_time: '10.00',
        status: true,
        name: utils.getLang() == 'ar' ? "غير محدد" : "Not Specified",
      )
    ];

    setCustomMapPin();
    _listenForPermissionStatus();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _cancelToken = CancelToken();

  ///===========================================================================

  Set<Marker> markers = {};

  /// initial position
  CameraPosition _initialLocation =
      CameraPosition(target: LatLng(40.712776, -74.005974), zoom: 13);
  Completer<GoogleMapController> _mapController = Completer();

  ///
  Map<PolylineId, Polyline> polylines = {};
  late BitmapDescriptor pinLocationIcon;

  ///
  late GoogleMapController mapController;

  ///
  Position? _currentPosition;
  String? _currentAddress;

  Permission _permission = Permission.location;
  PermissionStatus _permissionStatus = PermissionStatus.denied;
  final _formKey = GlobalKey<FormState>();

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              // target: LatLng(40.732128, -73.999619),
              zoom: 13.0,
            ),
          ),
        );

        markers.add(Marker(
            markerId: MarkerId('current_Postion'),
            infoWindow: InfoWindow(title: 'Current Position'),
            position: LatLng(position.latitude, position.longitude),
            icon: pinLocationIcon));
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), AppAssets.location_png);
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        // startAddressController.text = _currentAddress;
        // _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  void _listenForPermissionStatus() async {
    final status = await _permission.status;
    setState(() => _permissionStatus = status);
    if (_permissionStatus.isGranted) {
      await _getCurrentLocation();
    } else {
      requestPermission(_permission);
    }
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();

    setState(() {
      print(status);
      _permissionStatus = status;
      print(_permissionStatus);
    });
    if (_permissionStatus.isGranted) {
      await _getCurrentLocation();
    }
  }

  ///===========================================================================

  var _couponBloc = CouponBloc();
  bool _isCouponApply = false;
  CouponCodeEntity _couponInfoSuccess = CouponCodeEntity(
      discountAmount: '0.0',
      couponCode: '00',
      total: '0',
      couponId: 0,
      discount: '0.0');

  @override
  Widget build(BuildContext context) {
    //===================================================

    AppBar appBar = AppBar(
      backgroundColor: globalColor.appBar,
      brightness: Brightness.light,
      elevation: 0,
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      title: Text(
        Translations.of(context).translate('cart'),
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
        body: BlocListener<CouponBloc, CouponState>(
          bloc: _couponBloc,
          listener: (BuildContext context, state) async {
            if (state is CouponDoneState) {
              ErrorViewer.showCustomError(
                  context,
                  Translations.of(context)
                      .translate('discount_coupon_accepted'));
              _copon = '';
              coponEditingController.text = '';
              _isCouponApply = true;
              _couponInfoSuccess = state.couponInfo;
            }
            if (state is CouponFailureState) {
              final error = state.error;
              if (error is ConnectionError) {
                ErrorViewer.showCustomError(context,
                    Translations.of(context).translate('err_connection'));
              } else if (error is CustomError) {
                ErrorViewer.showCustomError(context, error.message);
              } else {
                ErrorViewer.showUnexpectedError(context);
              }
            }
          },
          child: BlocBuilder<CouponBloc, CouponState>(
              bloc: _couponBloc,
              builder: (BuildContext context, state) {
                return ModalProgressHUD(
                  inAsyncCall: state is CouponLoadingState,
                  color: globalColor.primaryColor,
                  opacity: 0.2,
                  child: Container(
                    child: Consumer<CartProvider>(
                        builder: (context, cartProvider, child) {
                      if (cartProvider.getItems() != null &&
                          cartProvider.getItems()!.isNotEmpty)
                        return _city.id == -1
                            ? Center(
                                child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.red),
                              ))
                            : Form(
                                key: _formKey,
                                child: Container(
                                    height: height,
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: cartProvider
                                                    .getItems()!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return ItemProductCartWidget(
                                                    item: cartProvider
                                                        .getItems()![index],
                                                  );
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
                                              child:
                                                  _buildDimensionsInputWidget(
                                                      width: width,
                                                      height: 60.h,
                                                      context: context,
                                                      cartProvider:
                                                          cartProvider),
                                            ),
                                            VerticalPadding(
                                              percentage: 2.0,
                                            ),
                                            _isCouponApply &&
                                                    _couponInfoSuccess != null
                                                ? Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left:
                                                                EdgeMargin.min,
                                                            right:
                                                                EdgeMargin.min),
                                                    child: _buildCoponTextWidget(
                                                        width: width,
                                                        height: 50.h,
                                                        context: context,
                                                        couponInfoSuccess:
                                                            _couponInfoSuccess),
                                                  )
                                                : Container(),
                                            VerticalPadding(
                                              percentage: 2.0,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: EdgeMargin.min,
                                                  right: EdgeMargin.min),
                                              child: _buildMap(
                                                width: width,
                                                height: height,
                                                context: context,
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
                                                controller:
                                                    phoneEditingController,
                                                maxLines: 4,
                                                filled: true,
                                                style: textStyle.smallTSBasic
                                                    .copyWith(
                                                        color:
                                                            globalColor.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                  EdgeMargin.small,
                                                  EdgeMargin.middle,
                                                  EdgeMargin.small,
                                                  EdgeMargin.small,
                                                ),
                                                fillColor: globalColor.white,
                                                backgroundColor:
                                                    globalColor.white,
                                                labelBackgroundColor:
                                                    globalColor.white,
                                                validator: (value) {
                                                  return BaseValidator
                                                      .validateValue(
                                                    context,
                                                    value!,
                                                    [],
                                                    _phoneValidation,
                                                  );
                                                },
                                                hintText:
                                                    Translations.of(context)
                                                        .translate(
                                                            'write_your_notes'),
                                                label: Translations.of(context)
                                                    .translate('add_notes'),
                                                keyboardType:
                                                    TextInputType.text,
                                                borderRadius: width * .02,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _phoneValidation = true;
                                                    _phone = value;
                                                  });
                                                },
                                                borderColor: globalColor.grey
                                                    .withOpacity(0.3),
                                                textInputAction:
                                                    TextInputAction.next,
                                                onFieldSubmitted: (_) {
                                                  FocusScope.of(context)
                                                      .nextFocus();
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
                                              child: _buildpayment_methodWidget(
                                                  context: context,
                                                  width: width,
                                                  height: 50.h),
                                            ),
                                            VerticalPadding(
                                              percentage: 2.0,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: EdgeMargin.min,
                                                  right: EdgeMargin.min),
                                              child: _buildSelectCitiesWidget(
                                                  context: context,
                                                  width: width,
                                                  height: 50.h),
                                            ),
                                            VerticalPadding(
                                              percentage: 2.0,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  20,
                                              child: DropdownSearch(
                                                validator: (value) =>
                                                    vRequired(context, value),

                                                dropdownButtonBuilder:
                                                    (context) =>
                                                        SizedBox.shrink(),
                                                mode: Mode.BOTTOM_SHEET,
                                                // showAsSuffixIcons: false,
                                                showSearchBox: true,
                                                dropdownBuilder: drobDowenB,

                                                emptyBuilder: (context,
                                                        searchEntry) =>
                                                    Text("لا يوجد بيانات الان"),
                                                onFind: (_) => getNega(
                                                    city_id: _city.id ?? 1),
                                                onChanged: (value) {
                                                  setState(() {
                                                    negaboor = value!;
                                                  });
                                                  // print(value!.id);
                                                },
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets.zero),
                                              ),
                                            ),
                                            VerticalPadding(percentage: 2.0),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  20,
                                              child: DropdownSearch<
                                                  CustomDrobDowenField>(
                                                validator: (value) =>
                                                    vRequired(context, value),
                                                dropdownButtonBuilder:
                                                    (context) =>
                                                        SizedBox.shrink(),
                                                mode: Mode.BOTTOM_SHEET,
                                                // showAsSuffixIcons: false,
                                                showSearchBox: true,
                                                dropdownBuilder: drobDowenNet,
                                                emptyBuilder: (context,
                                                        searchEntry) =>
                                                    Text("لا يوجد بيانات الان"),

                                                items: deliveryList,
                                                itemAsString: (item) =>
                                                    utils.getLang() == "ar"
                                                        ? item!.ar
                                                        : item!.ar,
                                                onChanged: (value) {
                                                  // GlobalKey<DropdownSearch> _fbKey;
                                                  setState(() {
                                                    deliveryTo = value!;
                                                  });
                                                  print(
                                                      "delivery toooooooooooooooooooooooooooooo================${deliveryTo.key}");
                                                },
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets.zero),
                                              ),
                                            ),
                                            VerticalPadding(
                                              percentage: 2.0,
                                            ),
                                            state is CouponDoneState
                                                ? SizedBox.shrink()
                                                : VerticalPadding(
                                                    percentage: 2.0,
                                                  ),
                                            state is CouponDoneState
                                                ? SizedBox.shrink()
                                                : Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left:
                                                                EdgeMargin.min,
                                                            right:
                                                                EdgeMargin.min),
                                                    child: _buildPricesWidget(
                                                        width: width,
                                                        height: 50.h,
                                                        context: context,
                                                        cartProvider:
                                                            cartProvider),
                                                  ),
                                            VerticalPadding(
                                              percentage: 2.0,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: EdgeMargin.min,
                                                  right: EdgeMargin.min),
                                              child: _buildTotalWidget(
                                                  context: context,
                                                  width: width,
                                                  height: 50.h,
                                                  cartProvider: cartProvider),
                                            ),
                                            VerticalPadding(
                                              percentage: 2.0,
                                            ),
                                            Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                padding: const EdgeInsets.only(
                                                    left: EdgeMargin.min,
                                                    right: EdgeMargin.min),
                                                child: Text(
                                                  '${Translations.of(context).translate('txt_cart_desc')} \n ${Translations.of(context).translate('the_number_of_products')} ${cartProvider.getItemsCount().toString()}',
                                                  style: textStyle.smallTSBasic
                                                      .copyWith(
                                                          color:
                                                              globalColor.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                )),
                                            VerticalPadding(
                                              percentage: 4.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              );
                      return Container(
                        height: height,
                        width: width,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${Translations.of(context).translate('the_basket_is_empty')}',
                                style: textStyle.smallTSBasic
                                    .copyWith(color: globalColor.primaryColor),
                              ),
                              VerticalPadding(
                                percentage: 4.0,
                              ),
                              Container(
                                width: width,
                                margin:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: RoundedButton(
                                  height: 55.h,
                                  width: width * 5,
                                  color: globalColor.primaryColor,
                                  onPressed: () {
                                    if (widget.tabController != null) {
                                      widget.tabController!.animateTo(0);
                                    } else {
                                      Get.Get.back();
                                    }
                                  },
                                  borderRadius: 8.w,
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        Translations.of(context)
                                            .translate('shop_now'),
                                        style: textStyle.middleTSBasic
                                            .copyWith(color: globalColor.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
        ));
  }

  _buildDimensionsInputWidget(
      {required BuildContext context,
      required double width,
      required double height,
      required CartProvider cartProvider
      // TextEditingController controller,
      // bool textValidation,
      // String text,
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
                      Translations.of(context).translate('discount_coupon'),
                      style: textStyle.middleTSBasic
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
              child: BorderFormField(
                controller: coponEditingController,
                validator: (value) {
                  return BaseValidator.validateValue(
                    context,
                    value!,
                    [],
                    _copontValidation,
                  );
                },
                hintText: '- - - - -',
                hintStyle: textStyle.smallTSBasic.copyWith(
                    color: globalColor.grey, fontWeight: FontWeight.bold),
                style: textStyle.smallTSBasic.copyWith(
                    color: globalColor.black, fontWeight: FontWeight.bold),
                filled: false,
                keyboardType: TextInputType.text,
                borderRadius: 12.w,
                onChanged: (value) {
                  setState(() {
                    _copontValidation = true;
                    _copon = value;
                  });
                  if (value.isNotEmpty && value.length == 5) {
                    _couponBloc.add(ApplyCouponEvent(
                        cancelToken: _cancelToken,
                        couponCode: _copon,
                        total:
                            cartProvider.getTotalPrices().toStringAsFixed(2)));
                    // _applyCoupon(
                    //     couponCode: _copon,
                    //     total:
                    //         cartProvider.getTotalPrices().toStringAsFixed(2));
                  }
                },
                textAlign: TextAlign.center,
                borderColor: globalColor.transparent,
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

  _buildCoponTextWidget({
    required BuildContext context,
    required double width,
    required double height,
    required CouponCodeEntity couponInfoSuccess,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        // border:
        // Border.all(color: globalColor.primaryColor.withOpacity(0.3), width: 0.5),
      ),
      //   margin: const EdgeInsets.only(left: EdgeMargin.verySub,),
      height: height,
      width: width,

      child: Wrap(
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
                color: globalColor.white,
                borderRadius: BorderRadius.circular(12.0.w),
                border: Border.all(
                    color: globalColor.grey.withOpacity(0.3), width: 0.5)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(EdgeMargin.sub, EdgeMargin.sub,
                  EdgeMargin.sub, EdgeMargin.sub),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 1.w,
                  ),
                  SvgPicture.asset(
                    AppAssets.sales_svg,
                    width: 10.w,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  // Text(
                  //   '${couponInfoSuccess.discountAmount ?? ''}',
                  //   style: textStyle.minTSBasic.copyWith(
                  //       color: globalColor.primaryColor,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  Text(
                    Translations.of(context).translate('Delivery_free'),
                    style: textStyle.smallTSBasic.copyWith(
                        color: globalColor.goldColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          // Text(
          //   Translations.of(context).translate('discounted'),
          //   style: textStyle.middleTSBasic.copyWith(
          //       color: globalColor.white, fontWeight: FontWeight.bold),
          // ),
          // Text(
          //   '${couponInfoSuccess.discount ?? ''}',
          //   style: textStyle.bigTSBasic.copyWith(
          //       color: globalColor.goldColor, fontWeight: FontWeight.bold),
          // ),
          // Text(
          //   '${Translations.of(context).translate('rail')} ${Translations.of(context).translate('from_code')} ',
          //   style: textStyle.middleTSBasic.copyWith(
          //       color: globalColor.white, fontWeight: FontWeight.bold),
          // ),
          // Text(
          //   '${couponInfoSuccess.couponCode ?? ''}',
          //   style: textStyle.bigTSBasic.copyWith(
          //       color: globalColor.goldColor, fontWeight: FontWeight.bold),
          // ),
        ],
      ),
    );
  }

  _buildPricesWidget(
      {required BuildContext context,
      required double width,
      required double height,
      required CartProvider cartProvider}) {
    return Container(
      width: width,
      child: Column(
        children: [
          _buildPricesInfoItem(
              height: height,
              width: width,
              value: cartProvider.getTotalPrices().toStringAsFixed(2),
              title:
                  Translations.of(context).translate('total_original_price')),
          VerticalPadding(
            percentage: 1.0,
          ),
          // _isCouponApply && _couponInfoSuccess != null
          //     ? Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           _buildPricesInfoItem(
          //               height: height,
          //               width: width,
          //               value: _couponInfoSuccess.total ?? '',
          //               title: Translations.of(context)
          //                   .translate('total_after_discount')),
          //           VerticalPadding(
          //             percentage: 1.0,
          //           ),
          //         ],
          //       )
          //     : Container(),
          _paymentMethods != null &&
                  _paymentMethods.id != null &&
                  _paymentMethods.id == 8
              ? _buildPricesInfoItem(
                  height: height,
                  width: width,
                  value: '25',
                  title: Translations.of(context)
                      .translate('payment_fees_on_receipt'))
              : Container(),
        ],
      ),
    );
  }

  _buildPricesInfoItem({
    required double height,
    required double width,
    required String title,
    required String value,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.white,
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        // border:
        // Border.all(color: globalColor.primaryColor.withOpacity(0.3), width: 0.5),
      ),
      padding: const EdgeInsets.only(
        left: EdgeMargin.sub,
        right: EdgeMargin.sub,
      ),
      height: height,
      width: width,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: textStyle.middleTSBasic.copyWith(
                  color: globalColor.black, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: textStyle.smallTSBasic.copyWith(
                      color: globalColor.goldColor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '${Translations.of(context).translate('rail')}',
                  style: textStyle.middleTSBasic.copyWith(
                      color: globalColor.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* _buildSelectCompanyWidget({
    BuildContext context,
    double width,
    double height,
    TextEditingController controller,
    bool textValidation,
    String text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.white,
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
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  EdgeMargin.subMin,
                  EdgeMargin.verySub,
                  EdgeMargin.subMin,
                  EdgeMargin.verySub,
                ),
                child: Text(
                  Translations.of(context)
                      .translate('choose_a_shipping_company'),
                  style:
                      textStyle.smallTSBasic.copyWith(color: globalColor.black),
                ),
              ),
            ),
          ),
          Container(
            width: 1.0,
            color: globalColor.grey.withOpacity(0.3),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                EdgeMargin.subMin,
                EdgeMargin.verySub,
                EdgeMargin.subMin,
                EdgeMargin.verySub,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      // width: widget.width * .4,
                      height: 35.h,
                      child: Custom2Dropdown<ShippingCarriersEntity>(
                        onChanged: (data) {
                          _shippingCarriers = data;
                          if (mounted) setState(() {});
                        },
                        value: _shippingCarriers,
                        borderRadius: 0,
                        hint: '',
                        dropdownMenuItemList:
                            _listOfShippingCarriers.map((profession) {
                          return DropdownMenuItem(
                            child: Container(
                              width: width,
                              decoration: BoxDecoration(
                                  color: profession == _shippingCarriers
                                      ? globalColor.primaryColor
                                          .withOpacity(0.3)
                                      : globalColor.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.w))),
                              padding: EdgeInsets.all(EdgeMargin.small),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    profession.name ?? '',
                                    style: textStyle.smallTSBasic.copyWith(
                                        color: globalColor.primaryColor),
                                  ),
                                ),
                                alignment: AlignmentDirectional.center,
                              ),
                            ),
                            value: profession ?? null,
                          );
                        }).toList(),
                        selectedItemBuilder: (BuildContext context) {
                          return _listOfShippingCarriers.map<Widget>((item) {
                            return Center(
                              child: Text(
                                item.name ?? '',
                                style: textStyle.smallTSBasic
                                    .copyWith(color: globalColor.primaryColor),
                              ),
                            );
                          }).toList();
                        },
                        isEnabled: true,
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: Container(
                  //     child: Text(
                  //       'ارامكس',
                  //       style: textStyle.smallTSBasic
                  //           .copyWith(color: globalColor.primaryColor),
                  //     ),
                  //     alignment: AlignmentDirectional.center,
                  //   ),
                  // ),
                  // Container(
                  //   child: Icon(
                  //     MaterialIcons.keyboard_arrow_down,
                  //     color: globalColor.black,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
*/
  _buildpayment_methodWidget({
    BuildContext? context,
    double? width,
    double? height,
    TextEditingController? controller,
    bool? textValidation,
    String? text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.white,
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
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  EdgeMargin.subMin,
                  EdgeMargin.verySub,
                  EdgeMargin.subMin,
                  EdgeMargin.verySub,
                ),
                child: Text(
                  Translations.of(context!).translate('payment_method'),
                  style:
                      textStyle.smallTSBasic.copyWith(color: globalColor.black),
                ),
              ),
            ),
          ),
          Container(
            width: 1.0,
            color: globalColor.grey.withOpacity(0.3),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                EdgeMargin.subMin,
                EdgeMargin.verySub,
                EdgeMargin.subMin,
                EdgeMargin.verySub,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      // width: widget.width * .4,
                      height: 35.h,
                      child: Custom2Dropdown<ShippingCarriersEntity>(
                        onChanged: (data) {
                          _paymentMethods = data!;
                          print(_paymentMethods.id);
                          if (mounted) setState(() {});
                        },
                        value: _paymentMethods,
                        borderRadius: 0,
                        hint: '',
                        dropdownMenuItemList:
                            _listOfPaymentMethods.map((profession) {
                          return DropdownMenuItem(
                            child: Container(
                              width: width,
                              decoration: BoxDecoration(
                                  color: profession == _paymentMethods
                                      ? globalColor.primaryColor
                                          .withOpacity(0.3)
                                      : globalColor.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.w))),
                              padding: EdgeInsets.all(EdgeMargin.small),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    profession.name ?? '',
                                    style: textStyle.smallTSBasic.copyWith(
                                        color: globalColor.primaryColor),
                                  ),
                                ),
                                alignment: AlignmentDirectional.center,
                              ),
                            ),
                            value: profession,
                          );
                        }).toList(),
                        selectedItemBuilder: (BuildContext context) {
                          return _listOfPaymentMethods.map<Widget>((item) {
                            return Center(
                              child: Text(
                                item.name ?? '',
                                style: textStyle.smallTSBasic
                                    .copyWith(color: globalColor.primaryColor),
                              ),
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
          ),
        ],
      ),
    );
  }

  _buildSelectCitiesWidget({
    BuildContext? context,
    double? width,
    double? height,
    TextEditingController? controller,
    bool? textValidation,
    String? text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.white,
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
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  EdgeMargin.subMin,
                  EdgeMargin.verySub,
                  EdgeMargin.subMin,
                  EdgeMargin.verySub,
                ),
                child: Text(
                  Translations.of(context!).translate('choose_a_city'),
                  style:
                      textStyle.smallTSBasic.copyWith(color: globalColor.black),
                ),
              ),
            ),
          ),
          Container(
            width: 1.0,
            color: globalColor.grey.withOpacity(0.3),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                EdgeMargin.subMin,
                EdgeMargin.verySub,
                EdgeMargin.subMin,
                EdgeMargin.verySub,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      // width: widget.width * .4,
                      height: 35.h,
                      child: Custom2Dropdown<CityOrderEntity>(
                        onChanged: (data) {
                          getNega(city_id: data!.id);
                          _city = data;
                          if (mounted) setState(() {});
                          print(data.id);
                        },
                        value: _city,
                        borderRadius: 0,
                        hint: '',
                        dropdownMenuItemList: _listOfCities.map((profession) {
                          return DropdownMenuItem(
                            child: Container(
                              width: width,
                              decoration: BoxDecoration(
                                  color: profession == _city
                                      ? globalColor.primaryColor
                                          .withOpacity(0.3)
                                      : globalColor.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.w))),
                              padding: EdgeInsets.all(EdgeMargin.small),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    profession.name ?? '',
                                    style: textStyle.smallTSBasic.copyWith(
                                        color: globalColor.primaryColor),
                                  ),
                                ),
                                alignment: AlignmentDirectional.center,
                              ),
                            ),
                            value: profession,
                          );
                        }).toList(),
                        selectedItemBuilder: (BuildContext context) {
                          return _listOfCities.map<Widget>((item) {
                            return Center(
                              child: Text(
                                item.name ?? '',
                                style: textStyle.smallTSBasic
                                    .copyWith(color: globalColor.primaryColor),
                              ),
                            );
                          }).toList();
                        },
                        isEnabled: true,
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: Container(
                  //     child: Text(
                  //       'ارامكس',
                  //       style: textStyle.smallTSBasic
                  //           .copyWith(color: globalColor.primaryColor),
                  //     ),
                  //     alignment: AlignmentDirectional.center,
                  //   ),
                  // ),
                  // Container(
                  //   child: Icon(
                  //     MaterialIcons.keyboard_arrow_down,
                  //     color: globalColor.black,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

/*  buildSelecteddeliveryTo(context, width) {
    if (deliveryTo.key == "mosque") {
      return buildMosque(context, width);
    } else if (deliveryTo.key == "home") {
      return buildHome(context, width);
    } else if (deliveryTo.key == "work") {
      return buildWork(context, width);
    } else if (deliveryTo.key == "rest") {
      return buildRest(context, width);
    } else {
      return SizedBox();
    }
  }*/

  buildRest(context, width) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
              left: EdgeMargin.min, right: EdgeMargin.min),
          child: NormalOjosTextFieldWidget(
            controller: mosqueEditingController,
            maxLines: 1,
            filled: true,
            style: textStyle.smallTSBasic.copyWith(
                color: globalColor.black, fontWeight: FontWeight.bold),
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
              if (value!.length == 0 || value == null) {
                return Translations.of(context).translate('v_required');
              } else {
                return null;
              }
            },
            hintText: Translations.of(context).translate('rest name'),
            label: Translations.of(context).translate('rest name'),
            keyboardType: TextInputType.text,
            borderRadius: width * .02,
            onChanged: (value) {
              setState(() {
                mosqueNameValidation = true;
                mosqueName = value;
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
          child: NormalOjosTextFieldWidget(
            controller: workerEditingController,
            maxLines: 1,
            filled: true,
            style: textStyle.smallTSBasic.copyWith(
                color: globalColor.black, fontWeight: FontWeight.bold),
            contentPadding: const EdgeInsets.fromLTRB(
              EdgeMargin.small,
              EdgeMargin.middle,
              EdgeMargin.small,
              EdgeMargin.small,
            ),
            fillColor: globalColor.white,
            backgroundColor: globalColor.white,
            labelBackgroundColor: globalColor.white,
            //validator: (value) => phoneValidation(context, value),
            hintText: Translations.of(context).translate('recipient number'),
            label: Translations.of(context).translate('recipient number'),
            keyboardType: TextInputType.phone,
            borderRadius: width * .02,
            onChanged: (value) {
              setState(() {
                recipientnumberValidation = true;
                recipientnumberName = value;
              });
            },
            borderColor: globalColor.grey.withOpacity(0.3),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).nextFocus();
            },
          ),
        )
      ],
    );
  }

  buildHome(context, width) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 20,
          child: DropdownSearch<Deliveryto>(
            validator: (value) => vRequired(context, value),
            dropdownButtonBuilder: (context) => SizedBox.shrink(),
            mode: Mode.BOTTOM_SHEET,
            showSearchBox: true,
            dropdownBuilder: drobDowenLocal,
            emptyBuilder: (context, searchEntry) => Text("لا يوجد بيانات الان"),
            items: attrbuotmodelList,
            itemAsString: (item) => item!.name!,
            onChanged: (value) {
              setState(() {
                //  loadedAt = value!;
              });
              print("loadedAt.id");
              //print(loadedAt.id);
            },
            onFind: (text) => getAttrbuotloadproduct(),
            dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero),
          ),
        ),
        VerticalPadding(
          percentage: 2.0,
        ),
        Container(
          padding: const EdgeInsets.only(
              left: EdgeMargin.min, right: EdgeMargin.min),
          child: NormalOjosTextFieldWidget(
            controller: workerEditingController,
            maxLines: 1,
            filled: true,
            style: textStyle.smallTSBasic.copyWith(
                color: globalColor.black, fontWeight: FontWeight.bold),
            contentPadding: const EdgeInsets.fromLTRB(
              EdgeMargin.small,
              EdgeMargin.middle,
              EdgeMargin.small,
              EdgeMargin.small,
            ),
            fillColor: globalColor.white,
            backgroundColor: globalColor.white,
            labelBackgroundColor: globalColor.white,
            //validator: (value) => phoneValidation(context, value),
            hintText: Translations.of(context).translate('recipient number'),
            label: Translations.of(context).translate('recipient number'),
            keyboardType: TextInputType.phone,
            borderRadius: width * .02,
            onChanged: (value) {
              setState(() {
                recipientnumberValidation = true;
                recipientnumberName = value;
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
      ],
    );
  }

  buildWork(context, width) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 20,
          child: DropdownSearch<Deliveryto>(
            validator: (value) => vRequired(context, value),
            dropdownButtonBuilder: (context) => SizedBox.shrink(),
            mode: Mode.BOTTOM_SHEET,
            showSearchBox: true,
            dropdownBuilder: drobDowenLocal,
            emptyBuilder: (context, searchEntry) => Text("لا يوجد بيانات الان"),
            items: attrbuotmodelList,
            itemAsString: (item) => item!.name!,
            onChanged: (value) {
              setState(() {
                //loadedAt = value!;
              });
              print("loadedAt.id");
              //print(loadedAt.id);
            },
            onFind: (text) => getAttrbuotloadproduct(),
            dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero),
          ),
        ),
        VerticalPadding(
          percentage: 2.0,
        ),
        Container(
          padding: const EdgeInsets.only(
              left: EdgeMargin.min, right: EdgeMargin.min),
          child: NormalOjosTextFieldWidget(
            controller: workerEditingController,
            maxLines: 1,
            filled: true,
            style: textStyle.smallTSBasic.copyWith(
                color: globalColor.black, fontWeight: FontWeight.bold),
            contentPadding: const EdgeInsets.fromLTRB(
              EdgeMargin.small,
              EdgeMargin.middle,
              EdgeMargin.small,
              EdgeMargin.small,
            ),
            fillColor: globalColor.white,
            backgroundColor: globalColor.white,
            labelBackgroundColor: globalColor.white,
            //validator: (value) => phoneValidation(context, value),
            hintText: Translations.of(context).translate('recipient number'),
            label: Translations.of(context).translate('recipient number'),
            keyboardType: TextInputType.phone,
            borderRadius: width * .02,
            onChanged: (value) {
              setState(() {
                recipientnumberValidation = true;
                recipientnumberName = value;
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
      ],
    );
  }

  buildMosque(context, width) {
    return Column(children: [
      Container(
        width: MediaQuery.of(context).size.width - 20,
        child: DropdownSearch<Deliveryto>(
          validator: (value) => vRequired(context, value),
          dropdownButtonBuilder: (context) => SizedBox.shrink(),
          mode: Mode.BOTTOM_SHEET,
          // showAsSuffixIcons: false,
          showSearchBox: true,
          dropdownBuilder: drobDowenLocal,

          emptyBuilder: (context, searchEntry) => Text("لا يوجد بيانات الان"),

          items: attrbuotmodelList,
          itemAsString: (item) => item!.name!,
          onFind: (text) => getAttrbuotprayerPlace(),
          onChanged: (value) {
            setState(() {
              prayerPlace = value!;
            });
            print(prayerPlace.name);
          },
          dropdownSearchDecoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero),
        ),
      ),
      VerticalPadding(
        percentage: 2.0,
      ),
      Container(
        padding:
            const EdgeInsets.only(left: EdgeMargin.min, right: EdgeMargin.min),
        child: NormalOjosTextFieldWidget(
          controller: mosqueEditingController,
          maxLines: 1,
          filled: true,
          style: textStyle.smallTSBasic
              .copyWith(color: globalColor.black, fontWeight: FontWeight.bold),
          contentPadding: const EdgeInsets.fromLTRB(
            EdgeMargin.small,
            EdgeMargin.middle,
            EdgeMargin.small,
            EdgeMargin.small,
          ),
          fillColor: globalColor.white,
          backgroundColor: globalColor.white,
          labelBackgroundColor: globalColor.white,
          //validator: (value) => requiredValidation(context, value),
          hintText: Translations.of(context).translate('mosqueName'),
          label: Translations.of(context).translate('mosqueName'),
          keyboardType: TextInputType.text,
          borderRadius: width * .02,
          onChanged: (value) {
            setState(() {
              mosqueNameValidation = true;
              mosqueName = value;
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
        padding:
            const EdgeInsets.only(left: EdgeMargin.min, right: EdgeMargin.min),
        child: NormalOjosTextFieldWidget(
          controller: workerEditingController,
          maxLines: 1,
          filled: true,
          style: textStyle.smallTSBasic
              .copyWith(color: globalColor.black, fontWeight: FontWeight.bold),
          contentPadding: const EdgeInsets.fromLTRB(
            EdgeMargin.small,
            EdgeMargin.middle,
            EdgeMargin.small,
            EdgeMargin.small,
          ),
          fillColor: globalColor.white,
          backgroundColor: globalColor.white,
          labelBackgroundColor: globalColor.white,
          //validator: (value) => phoneValidation(context, value),
          hintText: Translations.of(context).translate('recipient number'),
          label: Translations.of(context).translate('recipient number'),
          keyboardType: TextInputType.phone,
          borderRadius: width * .02,
          onChanged: (value) {
            setState(() {
              recipientnumberValidation = true;
              recipientnumberName = value;
            });
          },
          borderColor: globalColor.grey.withOpacity(0.3),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            FocusScope.of(context).nextFocus();
          },
        ),
      ),
    ]);
  }

  _buildTotalWidget(
      {BuildContext? context,
      double? width,
      double? height,
      TextEditingController? controller,
      bool? textValidation,
      String? text,
      CartProvider? cartProvider}) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12.w)),
      child: Container(
        decoration: BoxDecoration(
          color: globalColor.white,
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
              flex: 5,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    EdgeMargin.subMin,
                    EdgeMargin.verySub,
                    EdgeMargin.subMin,
                    EdgeMargin.verySub,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        Translations.of(context!).translate('final_total'),
                        style: textStyle.smallTSBasic
                            .copyWith(color: globalColor.black),
                      ),
                      HorizontalPadding(
                        percentage: 1.0,
                      ),
                      Text(
                        _finalTotalPrice(cartProvider: cartProvider),
                        style: textStyle.normalTSBasic.copyWith(
                            color: globalColor.goldColor,
                            fontWeight: FontWeight.bold),
                      ),
                      HorizontalPadding(
                        percentage: 1.0,
                      ),
                      Text(
                        '${Translations.of(context).translate('rail')}',
                        style: textStyle.middleTSBasic
                            .copyWith(color: globalColor.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 1.0,
              color: globalColor.grey.withOpacity(0.3),
            ),
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () {
                  // Get.Get.toNamed(CheckAndPayPage.routeName,
                  //     arguments: CheckAndPayArgs(
                  //         listOfOrder: cartProvider.listOfCart,
                  //         total: _finalTotalPriceint(cartProvider: cartProvider),
                  //         city_id: _city.id,
                  //         coupon_id: null,
                  //         couponcode: _copon,
                  //         note: appConfig.notNullOrEmpty(_phone)? _phone :Translations.of(context).translate('there_is_no'),
                  //         orginal_price: cartProvider.getTotalPricesint(),
                  //         price_discount:_couponInfoSuccess?.total!=null? int.parse(_couponInfoSuccess.total):0,
                  //         point_map: _city.name,
                  //         shipping_fee: 25,
                  //         shipping_id: _shippingCarriers.id,
                  //         tax: 15,
                  //         totalPrice:
                  //             _finalTotalPrice(cartProvider: cartProvider)));

                  if (_formKey.currentState!.validate()) {
                    Get.Get.toNamed(EnterCartInfoPage.routeName,
                        arguments: CheckAndPayArgs(
                            listOfOrder: cartProvider!.listOfCart,
                            subtotal: 0,
                            total:
                                _finalTotalPriceint(cartProvider: cartProvider)
                                    .toDouble(),
                            city_id: _city.id,
                            coupon_id: null,
                            couponcode: _copon,
                            note: appConfig.notNullOrEmpty(_phone)
                                ? _phone
                                : Translations.of(context)
                                    .translate('there_is_no'),
                            orginal_price: cartProvider.getTotalPricesint(),
                            price_discount: _couponInfoSuccess.total != null
                                ? int.parse(_couponInfoSuccess.total)
                                : 0,
                            point_map: _city.name,
                            shipping_fee:
                                _isCouponApply && _couponInfoSuccess != null
                                    ? 0
                                    : _paymentMethods != null &&
                                            _paymentMethods.id != null &&
                                            _paymentMethods.id == 0
                                        ? 1
                                        : 2,
                            paymentMethods: _paymentMethods.id ?? 2,
                            shipping_id: _shippingCarriers.id ?? 1,
                            tax: 15,
                            totalPrice:
                                _finalTotalPrice(cartProvider: cartProvider),
                            neighborhood_id: negaboor.id,
                            load_id: 110,
                            delivery_to: deliveryTo.key,
                            dest_name: '',
                            guard_number: recipientnumberName,
                            dest_type: 0));
                  }
                },
                child: Container(
                  color: globalColor.primaryColor,
                  padding: const EdgeInsets.fromLTRB(
                    EdgeMargin.subMin,
                    EdgeMargin.verySub,
                    EdgeMargin.subMin,
                    EdgeMargin.verySub,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          child: FittedBox(
                            child: Text(
                              Translations.of(context).translate(
                                  'adoption_of_the_basket_and_payment'),
                              style: textStyle.smallTSBasic
                                  .copyWith(color: globalColor.white),
                            ),
                          ),
                          alignment: AlignmentDirectional.center,
                        ),
                      ),
                      Container(
                        child: Icon(
                          utils.getLang() != 'ar'
                              ? Icons.keyboard_arrow_right
                              : Icons.keyboard_arrow_left,
                          color: globalColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _finalTotalPrice({cartProvider}) {
    return _isCouponApply && _couponInfoSuccess != null
        ? (double.parse(_couponInfoSuccess.total) +
                (_paymentMethods != null &&
                        _paymentMethods.id != null &&
                        _paymentMethods.id == 8
                    ? 25
                    : 0))
            .toStringAsFixed(2)
        : (cartProvider.getTotalPrices() +
                (_paymentMethods != null &&
                        _paymentMethods.id != null &&
                        _paymentMethods.id == 8
                    ? 25
                    : 0))
            .toStringAsFixed(2);
  }

  int _finalTotalPriceint({cartProvider}) {
    double p = 0;
    p = (cartProvider.getTotalPrices() +
        (_paymentMethods != null &&
                _paymentMethods.id != null &&
                _paymentMethods.id == 8
            ? 25
            : 0));
    return p.toInt();
  }

  _buildMap({
    required BuildContext context,
    required double width,
    required double height,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12.w)),
      child: Container(
        decoration: BoxDecoration(
          color: globalColor.white,
          borderRadius: BorderRadius.all(Radius.circular(12.w)),
          border:
              Border.all(color: globalColor.grey.withOpacity(0.3), width: 0.5),
        ),
        //   margin: const EdgeInsets.only(left: EdgeMargin.verySub,),
        width: width,

        child: Column(
          children: [
            VerticalPadding(
              percentage: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      EdgeMargin.subMin,
                      EdgeMargin.verySub,
                      EdgeMargin.subMin,
                      EdgeMargin.verySub,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Translations.of(context)
                              .translate('cart_txt_delivery_location'),
                          style: textStyle.smallTSBasic
                              .copyWith(color: globalColor.black),
                        ),
                        HorizontalPadding(
                          percentage: 1.0,
                        ),
                        Text(
                          Translations.of(context)
                              .translate('cart_txt_automatic_GPS_selections'),
                          style: textStyle.smallTSBasic.copyWith(
                              color: globalColor.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Icon(
                    utils.getLang() != 'ar'
                        ? Icons.keyboard_arrow_right
                        : Icons.keyboard_arrow_left,
                    color: globalColor.black,
                  ),
                ),
              ],
            ),
            //  _buildSearchWidgetForMap(context: context, width: width),
            Container(
              height: 180,
              padding: const EdgeInsets.all(EdgeMargin.small),
              child: GoogleMap(
                initialCameraPosition: _initialLocation,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                polylines: Set<Polyline>.of(polylines.values),
                markers: Set<Marker>.from(markers),
                onMapCreated: (GoogleMapController controller) async {
                  mapController = controller;
                  // controller.setMapStyle(_mapStyle);
                  // await  createMArker();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  /*_buildSearchWidgetForMap({BuildContext context, double width}) {
    return Padding(
      padding: const EdgeInsets.all(EdgeMargin.small),
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: globalColor.white,
          borderRadius: BorderRadius.circular(12.0.w),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5, // has the effect of softening the shadow
              spreadRadius: 0, // has the effect of extending the shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Center(
                        child: Icon(
                          Icons.search,
                          size: 28.w,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50.h,
                    color: globalColor.grey.withOpacity(0.2),
                    width: .5,
                  )
                ],
              ),
            ),
            Expanded(
                flex: 6,
                child: TextField(
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText:
                          Translations.of(context).translate('search_places'),
                      hintStyle: textStyle.smallTSBasic
                          .copyWith(color: globalColor.grey)),
                )),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Container(
                    height: 50.h,
                    color: globalColor.grey.withOpacity(0.2),
                    width: .5,
                  ),
                  Expanded(
                    flex: 1,
                    child: SvgPicture.asset(
                      AppAssets.filter,
                      width: 22,
                      height: 22,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }*/

  @override
  void dispose() {
    _cancelToken.cancel();
    _couponBloc.close();
    super.dispose();
  }

  Future<void> _getShippingCarriers(int reloadCount) async {
    int count = reloadCount;
    if (mounted) {
      final result = await GetShippingCarriers(locator<CoreRepository>())(
        NoParams(cancelToken: _cancelToken),
      );

      if (result.data != null) {
        setState(() {
          _listOfShippingCarriers = result.data!;
          if (result.data!.isNotEmpty) {
            _shippingCarriers = result.data![0];
          }
        });
      } else {
        if (count != 3)
          appConfig.check().then((internet) {
            if (internet != null && internet) {
              _getShippingCarriers(count + 1);
            }
            // No-Internet Case
          });
      }
    }
  }

  Future<void> _getCities(int reloadCount) async {
    int count = reloadCount;
    if (mounted) {
      final result = await GetCities(locator<CoreRepository>())(
        NoParams(cancelToken: _cancelToken),
      );

      if (result.data != null) {
        setState(() {
          _listOfCities = result.data!;
          if (result.data!.isNotEmpty) {
            _city = result.data![0];
          }
        });
      } else {
        if (count != 3)
          appConfig.check().then((internet) {
            if (internet != null && internet) {
              _getCities(count + 1);
            }
            // No-Internet Case
          });
      }
    }
  }

// Future<List<NegaItem>> getNega({city_id = 1})async {
//   Dio dio = Dio();
//   Response response= await dio.get(API_NEGA(city_id: city_id));
//
//
//     if (response.data != null) {
//       setState(() {
//         // _listOfnega = response.data;
//         if (response.data.isNotEmpty) {
//           // nega = response.data[0];
//         }
//       });
//     // _listOfnega=NegaModel.fromJson(response.data).result;
//     setState(() {
//
//     });
//     return NegaModel.fromJson(response.data).result;
//
//   }else{
//     throw "Cant get Data";
//   }
//
// }

// Future<void> _applyCoupon({String total, String couponCode}) async {
//   if (mounted) {
//     setState(() {
//       _sendRequest = true;
//     });
//     final result = await ApplyCouponCode(locator<CartRepository>())(
//       ApplyCouponCodeParams(
//           couponCode: couponCode, total: total, cancelToken: _cancelToken),
//     );
//
//     setState(() {
//       _sendRequest = false;
//     });
//     if (result.data != null) {
//       appConfig.showToast(
//         msg: 'done',
//       );
//     } else {
//       appConfig.showToast(msg: 'failed');
//     }
//   }
// }

  Widget drobDowenLocal(context, Deliveryto? selectedItem) => Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: globalColor.white.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(12.w)),
          border:
              Border.all(color: globalColor.grey.withOpacity(0.3), width: 0.5),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    EdgeMargin.subMin,
                    EdgeMargin.verySub,
                    EdgeMargin.subMin,
                    EdgeMargin.verySub,
                  ),
                  child: Text(
                    Translations.of(context).translate('title'),
                    style: textStyle.smallTSBasic
                        .copyWith(color: globalColor.black),
                  ),
                ),
              ),
            ),
            Container(
              width: 1.0,
              color: Colors.grey.withOpacity(0.3),
            ),
            Expanded(
              child: selectedItem == null
                  ? Text(
                      utils.getLang() == 'ar' ? "غير محدد" : "Not Specified",
                      style: textStyle.smallTSBasic.copyWith(
                        color: globalColor.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      "${selectedItem.name}",
                      style: textStyle.smallTSBasic.copyWith(
                        color: globalColor.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
          ],
        ),
      );

  Widget drobDowenNet(
          BuildContext context, CustomDrobDowenField? selectedItem) =>
      Container(
        height: 50.h,
        // padding: const EdgeInsets.only(
        //     // left: EdgeMargin.min,
        //     // right: EdgeMargin.min,
        // ),
        decoration: BoxDecoration(
          color: globalColor.white.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(12.w)),
          border:
              Border.all(color: globalColor.grey.withOpacity(0.3), width: 0.5),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    EdgeMargin.subMin,
                    EdgeMargin.verySub,
                    EdgeMargin.subMin,
                    EdgeMargin.verySub,
                  ),
                  child: Text(
                    Translations.of(context).translate('deliveryPlace'),
                    style: textStyle.smallTSBasic
                        .copyWith(color: globalColor.black),
                  ),
                ),
              ),
            ),
            Container(
              width: 1.0,
              color: Colors.black.withOpacity(0.3),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  selectedItem == null
                      ? Text(
                          utils.getLang() == 'ar'
                              ? "غير محدد"
                              : "Not Specified",
                          style: textStyle.middleTSBasic.copyWith(
                            color: globalColor.primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          "${utils.getLang() == "ar" ? selectedItem.ar : selectedItem.en}",
                          style: textStyle.middleTSBasic.copyWith(
                            color: globalColor.primaryColor,
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      );

  Widget drobDowenB(context, Object? selectedItem) {
    return Container(
      height: 50.h,
      // padding: const EdgeInsets.only(
      //     // left: EdgeMargin.min,
      //     // right: EdgeMargin.min,
      // ),
      decoration: BoxDecoration(
        color: globalColor.white.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        border:
            Border.all(color: globalColor.grey.withOpacity(0.3), width: 0.5),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  EdgeMargin.subMin,
                  EdgeMargin.verySub,
                  EdgeMargin.subMin,
                  EdgeMargin.verySub,
                ),
                child: Text(
                  Translations.of(context).translate('Neighborhood'),
                  style:
                      textStyle.smallTSBasic.copyWith(color: globalColor.black),
                ),
              ),
            ),
          ),
          Container(
            width: 1.0,
            color: Colors.grey.withOpacity(0.3),
          ),
          Expanded(
            child: selectedItem == null
                ? Text(
                    utils.getLang() == 'ar' ? "غير محدد" : "Not Specified",
                    style: textStyle.middleTSBasic.copyWith(
                      color: globalColor.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    "$selectedItem",
                    style: textStyle.middleTSBasic.copyWith(
                      color: globalColor.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
        ],
      ),
    );
  }
}

String? vRequired(context, value) {
  if (value != null) {
    return null;
  } else {
    return Translations.of(context).translate('v_required');
  }
}
