import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/horizontal_padding.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/features/cart/presentation/blocs/retrieve_bloc.dart';
import 'package:ojos_app/features/order/presentation/pages/my_order_page.dart';
import 'package:ojos_app/features/user_management/presentation/widgets/user_management_text_field_widget.dart';
import 'package:get/get.dart' as Get;

class RetrievePage extends StatefulWidget {
  static const routeName = "/cart/pages/retrievepage";

  const RetrievePage({Key? key}) : super(key: key);

  @override
  _RetrievePageState createState() => _RetrievePageState();
}

class _RetrievePageState extends State<RetrievePage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController reasonTextEditingController =
        new TextEditingController();
    bool reasonValidate = false;
    String _reason = "";

    final TextEditingController placeTextEditingController =
        new TextEditingController();
    bool placeValidate = false;
    String _place = "";

    final TextEditingController nameTextEditingController =
        new TextEditingController();
    bool nameValidate = false;
    String _name = "";

    final TextEditingController phoneTextEditingController =
        new TextEditingController();
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

    GlobalKey _key = GlobalKey();
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _key ,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: EdgeMargin.min, right: EdgeMargin.min),
                      child: NormalOjosTextFieldWidget(
                        controller: reasonTextEditingController,
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
                        controller: placeTextEditingController,
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
                        hintText: Translations.of(context).translate('add_place'),
                        label: Translations.of(context).translate('add_place'),
                        keyboardType: TextInputType.text,
                        borderRadius: width * .02,
                        onChanged: (value) {
                          setState(() {
                            placeValidate = true;
                            _place = value;
                          });
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
                        controller: reasonTextEditingController,
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
                        hintText: Translations.of(context).translate('add_name'),
                        label: Translations.of(context).translate('add_name'),
                        keyboardType: TextInputType.text,
                        borderRadius: width * .02,
                        onChanged: (value) {
                          setState(() {
                            reasonValidate = true;
                            _reason = value;
                          });
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
                        controller: placeTextEditingController,
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
                        hintText: Translations.of(context).translate('add_phone'),
                        label: Translations.of(context).translate('add_phone'),
                        keyboardType: TextInputType.text,
                        borderRadius: width * .02,
                        onChanged: (value) {
                          setState(() {
                            placeValidate = true;
                            _place = value;
                          });
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
                      onTap: () {
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
                      onTap: () {
                        _bloc.add(ApplyRetrieveEvent(
                          cancelToken: CancelToken(),
                          phone: '904894',
                          place: 'hdjhdjjhd',
                          name: 'gdghdgd',
                          productId: '0',
                          reason: 'hjjjj'
                        ));
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
