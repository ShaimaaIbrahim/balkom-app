import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/core/appConfig.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/validators/base_validator.dart';
import 'package:ojos_app/core/validators/required_validator.dart';
import 'package:ojos_app/features/cart/data/api_responses/retrieve_response.dart';
import 'package:ojos_app/features/cart/data/models/retrieve_page_arguments.dart';
import 'package:ojos_app/features/cart/domin/services/cart_api.dart';
import 'package:ojos_app/features/cart/presentation/blocs/retrieve_bloc.dart';
import 'package:ojos_app/features/cart/presentation/widgets/styled_text_field.dart';
import 'package:ojos_app/features/order/presentation/pages/my_order_page.dart';
import 'package:ojos_app/features/user_management/presentation/widgets/user_management_text_field_widget.dart';
import 'package:get/get.dart' as Get;
import 'package:shared_preferences/shared_preferences.dart';

final _formKey = GlobalKey<FormState>();

class RetrievePage extends StatefulWidget {
  static const routeName = "/cart/pages/retrievepage";

  const RetrievePage({Key? key}) : super(key: key);

  @override
  _RetrievePageState createState() => _RetrievePageState();
}

class _RetrievePageState extends State<RetrievePage> {
  TextEditingController? reasonTextEditingController;
  TextEditingController? placeTextEditingController;
  TextEditingController? nameTextEditingController;
  TextEditingController? phoneTextEditingController;
  CartApi _cartApi = CartApi();
  CancelToken _cancelToken = CancelToken();

  RetrievePageArguments? args;
  SharedPreferences? prefrences;

  @override
  void initState() {
    reasonTextEditingController = new TextEditingController();
    placeTextEditingController = new TextEditingController();
    nameTextEditingController = new TextEditingController();
    phoneTextEditingController = new TextEditingController();

    _handelSharedPrefrences();

    args = Get.Get.arguments;
    super.initState();
  }

  _handelSharedPrefrences() async {
    prefrences = await SharedPreferences.getInstance();
    String? data = prefrences!.getString('retrieve_data');
    Map<String, dynamic> map = json.decode(data!);
    print(
        'shaimaa map is ===== ${map}');

    reasonTextEditingController!.text = map['reason'];
    phoneTextEditingController!.text = map['phone'];
    nameTextEditingController!.text = map['name'];
    placeTextEditingController!.text = map['place'];
  }

  @override
  Widget build(BuildContext context) {
    if (args != null) {
      print(
          'shaimaa args is ===== ${args!.product_id}   order id is ${args!.order_id}');
    }

    bool reasonValidate = false;
    String _reason = "";

    bool placeValidate = false;
    String _place = "";

    bool nameValidate = false;
    String _name = "";

    bool phoneValidate = false;
    String _phone = "";

    AppBar appBar = AppBar(
      backgroundColor: globalColor.appBar,
      brightness: Brightness.light,
      elevation: 0,
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      title: Text(
        Translations.of(context).translate('retrieve'),
        style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
      ),
      centerTitle: true,
    );

    RetrieveBloc _bloc = RetrieveBloc();

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Form(
              //  key: _formKey,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: EdgeMargin.min, right: EdgeMargin.min),
                      child: NormalOjosTextFieldWidget(
                        controller: reasonTextEditingController,
                        // maxLines: 2,
                        filled: false,
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
                        hintText:
                            Translations.of(context).translate('add_reason'),
                        label: Translations.of(context).translate('add_reason'),
                        keyboardType: TextInputType.text,
                        borderRadius: width * .02,
                        onChanged: (value) {
                          setState(() {
                            reasonValidate = true;
                            _reason = value;
                          });
                        },
                        validator: (value) {
                          return BaseValidator.validateValue(
                            context,
                            value!,
                            [RequiredValidator()],
                            reasonValidate,
                          );
                        },
                        borderColor: globalColor.grey.withOpacity(0.3),
                        textInputAction: TextInputAction.next,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context).nextFocus();
                        // },
                        onTap: null,
                      ),
                    ),
                    VerticalPadding(
                      percentage: 2.0,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: EdgeMargin.min, right: EdgeMargin.min),
                      child: NormalOjosTextFieldWidget(
                        controller: placeTextEditingController,
                        // maxLines: 2,
                        filled: false,
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
                        hintText:
                            Translations.of(context).translate('add_place'),
                        label: Translations.of(context).translate('add_place'),
                        keyboardType: TextInputType.text,
                        borderRadius: width * .02,
                        onChanged: (value) {
                          setState(() {
                            placeValidate = true;
                            _place = value;
                          });
                        },
                        validator: (value) {
                          return BaseValidator.validateValue(
                            context,
                            value!,
                            [RequiredValidator()],
                            placeValidate,
                          );
                        },
                        borderColor: globalColor.grey.withOpacity(0.3),
                        textInputAction: TextInputAction.next,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context).nextFocus();
                        // },
                        onTap: null,
                      ),
                    ),
                    VerticalPadding(
                      percentage: 2.0,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: EdgeMargin.min, right: EdgeMargin.min),
                      child: NormalOjosTextFieldWidget(
                        controller: nameTextEditingController,
                        maxLines: 2,
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
                        hintText:
                            Translations.of(context).translate('add_name'),
                        label: Translations.of(context).translate('add_name'),
                        keyboardType: TextInputType.text,
                        borderRadius: width * .02,
                        onChanged: (value) {
                          setState(() {
                            nameValidate = true;
                            _name = value;
                          });
                        },
                        validator: (value) {
                          return BaseValidator.validateValue(
                            context,
                            value!,
                            [RequiredValidator()],
                            nameValidate,
                          );
                        },
                        borderColor: globalColor.grey.withOpacity(0.3),
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
                          left: EdgeMargin.min, right: EdgeMargin.min),
                      child: NormalOjosTextFieldWidget(
                        controller: phoneTextEditingController,
                        maxLines: 2,
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
                        hintText:
                            Translations.of(context).translate('add_phone'),
                        label: Translations.of(context).translate('add_phone'),
                        keyboardType: TextInputType.text,
                        borderRadius: width * .02,
                        onChanged: (value) {
                          setState(() {
                            phoneValidate = true;
                            _phone = value;
                          });
                        },
                        validator: (value) {
                          return BaseValidator.validateValue(
                            context,
                            value!,
                            [RequiredValidator()],
                            phoneValidate,
                          );
                        },
                        borderColor: globalColor.grey.withOpacity(0.3),
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
                    InkWell(
                      onTap: () async {
                        var data = {
                          "reason": reasonTextEditingController!.text,
                          "place": placeTextEditingController!.text,
                          "name": nameTextEditingController!.text,
                          "phone": phoneTextEditingController!.text
                        };
                        prefrences!
                            .setString('retrieve_data', json.encode(data));

                        Get.Get.toNamed(MyOrderPage.routeName);
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.add, size: 30.w, color: Colors.grey),
                            HorizontalPadding(percentage: 0.5),
                            Text(Translations.of(context)
                                .translate('add_your_product'))
                          ],
                        ),
                      ),
                    ),
                    VerticalPadding(
                      percentage: 2.0,
                    ),
                    InkWell(
                      onTap: () async {
                        if (args != null) {
                          var data = {
                            "order_id": args!.order_id,
                            "product_id": args!.product_id,
                            "reason": _reason,
                            "place": _place,
                            "name": _name,
                            "phone": _phone
                          };

                          RetrieveResponse result = await _cartApi
                              .retrieveOrder(true, {}, data, _cancelToken);
                          if (result.status == true) {
                            final snackBar = SnackBar(
                              content: Text(Translations.of(context)
                                  .translate('retrieved_successfully')),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Future.delayed(Duration(seconds: 1));
                            Get.Get.back();
                          }
                        } else {
                          appConfig.showToast(
                              msg: Translations.of(context)
                                  .translate('add_product_please'));
                        }
                      },
                      child: Container(
                          height: 50.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: globalColor.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11.w))),
                          child:
                              Text(Translations.of(context).translate('send'))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
