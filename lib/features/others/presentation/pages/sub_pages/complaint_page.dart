import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojos_app/core/appConfig.dart';
import 'package:ojos_app/core/errors/connection_error.dart';
import 'package:ojos_app/core/errors/custom_error.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:ojos_app/core/ui/widget/button/rounded_button.dart';
import 'package:ojos_app/core/ui/widget/general_widgets/error_widgets.dart';
import 'package:ojos_app/core/validators/base_validator.dart';
import 'package:ojos_app/core/validators/email_validator.dart';
import 'package:ojos_app/core/validators/required_validator.dart';
import 'package:ojos_app/features/others/presentation/blocs/complaint_bloc.dart';
import 'package:ojos_app/features/user_management/presentation/widgets/user_management_text_field_widget.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/xternal_lib/model_progress_hud.dart';

class ComplaintPage extends StatefulWidget {
  static const routeName = '/others/sub_pages/pages/ComplaintPage';

  @override
  _ComplaintPageState createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _cancelToken = CancelToken();

  /// message parameters
  bool _messageValidation = false;
  String _message = '';
  final TextEditingController messageEditingController =
      new TextEditingController();

  /// phone parameters
  bool _phoneValidation = false;
  String _phone = '';
  final TextEditingController phoneEditingController =
      new TextEditingController();

  /// fullName parameters
  bool _fullNameValidation = false;
  String _fullName = '';
  final TextEditingController fullNameEditingController =
      new TextEditingController();

  /// email parameters
  bool _emailValidation = false;
  String _email = '';
  final TextEditingController emailEditingController =
      new TextEditingController();

  final _bloc = ComplaintBloc();

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
        Translations.of(context).translate('submit_a_complaint'),
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
        body: BlocListener<ComplaintBloc, ComplaintState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is ComplaintSuccess) {
              //  ErrorViewer.showCustomError(context,Translations.of(context).translate('msg_contact_us_success'));
              appConfig.showToast(
                  msg: Translations.of(context)
                      .translate('msg_contact_us_success'));
              Get.Get.back();
              // Get.Get.offAllNamed(SignInPage.routeName);
            }
            if (state is ComplaintFailure) {
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
          child: BlocBuilder<ComplaintBloc, ComplaintState>(
              bloc: _bloc,
              builder: (context, state) {
                return ModalProgressHUD(
                  inAsyncCall: state is ComplaintLoading,
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
                                  VerticalPadding(
                                    percentage: 2.0,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: EdgeMargin.min,
                                        right: EdgeMargin.min),
                                    child: NormalOjosTextFieldWidget(
                                      controller: fullNameEditingController,
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
                                      validator: (value) {
                                        return BaseValidator.validateValue(
                                          context,
                                          value!,
                                          [RequiredValidator()],
                                          _fullNameValidation,
                                        );
                                      },
                                      hintText: '',
                                      label: Translations.of(context)
                                          .translate('full_name'),
                                      keyboardType: TextInputType.text,
                                      borderRadius: width * .02,
                                      prefixIcon: Container(
                                        width: 15.w,
                                        height: 15.w,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            AppAssets.userSvg,
                                            color: globalColor.black,
                                            width: 15.w,
                                            height: 15.w,
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          _fullNameValidation = true;
                                          _fullName = value;
                                        });
                                      },
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
                                      validator: (value) {
                                        return BaseValidator.validateValue(
                                          context,
                                          value!,
                                          [RequiredValidator()],
                                          _phoneValidation,
                                        );
                                      },
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
                                      controller: emailEditingController,
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
                                      validator: (value) {
                                        return BaseValidator.validateValue(
                                          context,
                                          value!,
                                          [
                                            RequiredValidator(),
                                            EmailValidator()
                                          ],
                                          _emailValidation,
                                        );
                                      },
                                      hintText: '',
                                      label: Translations.of(context)
                                          .translate('email'),
                                      keyboardType: TextInputType.emailAddress,
                                      borderRadius: width * .02,
                                      prefixIcon: Container(
                                        width: 15.w,
                                        height: 15.w,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            AppAssets.userSvg,
                                            color: globalColor.black,
                                            width: 15.w,
                                            height: 15.w,
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          _emailValidation = true;
                                          _email = value;
                                        });
                                      },
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
                                    child: NormalOjosTextFieldWidget(
                                      controller: messageEditingController,
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
                                          _messageValidation,
                                        );
                                      },
                                      hintText: '',
                                      label: Translations.of(context)
                                          .translate('write_your_complaint'),
                                      keyboardType: TextInputType.text,
                                      borderRadius: width * .02,
                                      onChanged: (value) {
                                        setState(() {
                                          _messageValidation = true;
                                          _message = value;
                                        });
                                      },
                                      borderColor:
                                          globalColor.grey.withOpacity(0.3),
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context).nextFocus();
                                      },
                                    ),
                                  ),
                                  VerticalPadding(
                                    percentage: 5.0,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: EdgeMargin.min,
                                          right: EdgeMargin.min),
                                      child: RoundedButton(
                                        height: 55.h,
                                        width: width,
                                        color: globalColor.primaryColor,
                                        onPressed: () {
                                          setState(() {
                                            _messageValidation = true;
                                            _phoneValidation = true;
                                            _fullNameValidation = true;
                                            _emailValidation = true;
                                          });
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _bloc.add(
                                              ComplaintEvent(
                                                phone: _phone,
                                                name: _fullName,
                                                message: _message,
                                                email: _email,
                                                cancelToken: _cancelToken,
                                              ),
                                            );
                                          }
                                        },
                                        borderRadius: 8.w,
                                        child: Container(
                                          child: Center(
                                            child: Text(
                                              Translations.of(context)
                                                  .translate('send'),
                                              style: textStyle.middleTSBasic
                                                  .copyWith(
                                                      color: globalColor.white),
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
