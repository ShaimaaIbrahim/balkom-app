import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as Get;
import 'package:ojos_app/core/appConfig.dart';
import 'package:ojos_app/core/bloc/application_bloc.dart';
import 'package:ojos_app/core/bloc/application_events.dart';
import 'package:ojos_app/core/errors/bad_request_error.dart';
import 'package:ojos_app/core/errors/connection_error.dart';
import 'package:ojos_app/core/errors/custom_error.dart';
import 'package:ojos_app/core/errors/unauthorized_error.dart';
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
import 'package:ojos_app/core/validators/required_validator.dart';
import 'package:ojos_app/features/home/presentation/pages/home_page.dart';
import 'package:ojos_app/features/main_root.dart';
import 'package:ojos_app/features/user_management/presentation/args/verify_page_args.dart';
import 'package:ojos_app/features/user_management/presentation/blocs/login_bloc.dart';
import 'package:ojos_app/features/user_management/presentation/pages/forgot_password_page.dart';
import 'package:ojos_app/features/user_management/presentation/pages/sign_up_page.dart';
import 'package:ojos_app/features/user_management/presentation/widgets/user_management_background.dart';
import 'package:ojos_app/features/user_management/presentation/widgets/user_management_text_field_widget.dart';
import 'package:ojos_app/xternal_lib/model_progress_hud.dart';

import 'verify_page.dart';

class SignInPage extends StatelessWidget {
  static const routeName = '/features/SignInPage';

  @override
  Widget build(BuildContext context) {
    double widthC = globalSize.setWidthPercentage(100, context);
    double heightC = globalSize.setHeightPercentage(100, context);
    return Scaffold(
      body: Container(
        width: widthC,
        height: heightC,
        child: Stack(
          children: [
            // UserManagementBackground(
            //   height: heightC,
            //   image: AppAssets.backgroundSignIn,
            //   width: widthC,
            // ),
            SignInBox(),
          ],
        ),
      ),
    );
  }
}

class SignInBox extends StatefulWidget {
  @override
  _SignInBoxState createState() => _SignInBoxState();
}

class _SignInBoxState extends State<SignInBox> {
  /// phone parameters
  bool _phoneValidation = false;
  String _phone = '';
  final TextEditingController phoneEditingController =
      new TextEditingController();

  /// password parameters
  bool _passwordValidation = false;
  String _password = '';
  final TextEditingController passwordEditingController =
      new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _bloc = LoginBloc();
  final _loginCancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: globalColor.transparent,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(
        color: globalColor.black,
      ),
      title: Text(
        Translations.of(context).translate('login'),
        style: textStyle.normalTSBasic.copyWith(color: globalColor.black),
      ),
      elevation: 0,
      centerTitle: true,
    );

    double widthC = globalSize.setWidthPercentage(100, context);
    double heightC = globalSize.setHeightPercentage(100, context);

    return Scaffold(
        appBar: appBar,
        backgroundColor: globalColor.transparent,
        body: BlocListener<LoginBloc, LoginState>(
          bloc: _bloc,
          child: BlocBuilder<LoginBloc, LoginState>(
            bloc: _bloc,
            builder: (context, state) {
              return ModalProgressHUD(
                  inAsyncCall: state is LoginLoading,
                  color: globalColor.primaryColor,
                  opacity: 0.2,
                  child: Container(
                      width: widthC,
                      height: heightC,
                      child: SingleChildScrollView(
                        child: Container(
                          child: Form(
                            key: _formKey,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height /
                                        4.5,
                                    child: Image.asset(
                                      AppAssets.logo,
                                      // width: 30,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  VerticalPadding(
                                    percentage: 5.5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: EdgeMargin.min,
                                        right: EdgeMargin.min),
                                    child: UserManagementTextFieldWidget(
                                      controller: phoneEditingController,
                                      validator: (value) {
                                        return BaseValidator.validateValue(
                                          context,
                                          value!,
                                          [RequiredValidator()],
                                          _phoneValidation,
                                        );
                                      },
                                      hintText: '',
                                      prefixIcon: Container(
                                        width: 15.w,
                                        height: 15.w,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            AppAssets.phoneSvg,
                                            color: globalColor.grey,
                                            width: 15.w,
                                            height: 15.w,
                                          ),
                                        ),
                                      ),
                                      label: Translations.of(context)
                                          .translate('phone_number'),
                                      keyboardType: TextInputType.phone,
                                      borderRadius: widthC * .02,
                                      onChanged: (value) {
                                        setState(() {
                                          _phoneValidation = true;
                                          _phone = value;
                                        });
                                      },
                                      borderColor: globalColor.grey,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context).nextFocus();
                                      },
                                    ),
                                  ),
                                  VerticalPadding(
                                    percentage: 2.5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: EdgeMargin.min,
                                        right: EdgeMargin.min),
                                    child: UserManagementTextFieldWidget(
                                      style: textStyle.smallTSBasic.copyWith(
                                          color: globalColor.black,
                                          fontWeight: FontWeight.bold),

                                      controller: passwordEditingController,
                                      isPasswordField: true,
                                      validator: (value) {
                                        return BaseValidator.validateValue(
                                          context,
                                          value!,
                                          [RequiredValidator()],
                                          _passwordValidation,
                                        );
                                      },
                                      hintText: '',
                                      prefixIcon: Container(
                                        width: 15.w,
                                        height: 15.w,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            AppAssets.lockSvg,
                                            color: globalColor.grey,
                                            width: 15.w,
                                            height: 15.w,
                                          ),
                                        ),
                                      ),
                                      // maxLength: 10,
                                      inputFormat: [
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      label: Translations.of(context)
                                          .translate('password'),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      borderRadius: widthC * .02,
                                      onChanged: (value) {
                                        setState(() {
                                          _passwordValidation = true;
                                          _password = value;
                                        });
                                      },

                                      borderColor: globalColor.grey,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context).nextFocus();
                                      },
                                    ),
                                  ),
                                  VerticalPadding(
                                    percentage: 2.5,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: EdgeMargin.min,
                                          right: EdgeMargin.min),
                                      child: RoundedButton(
                                        height: 55.h,
                                        width: widthC,
                                        color: globalColor.primaryColor,
                                        onPressed: () {
                                          // Get.Get.toNamed(MainRootPage.routeName);
                                          setState(() {
                                            _phoneValidation = true;
                                            _passwordValidation = true;
                                          });
                                          if (_formKey.currentState!
                                              .validate()) {
                                            firebaseMessaging
                                                .getToken()
                                                .then((token) async {
                                              assert(token != null);
                                              var _homeScreenText;
                                              _homeScreenText =
                                                  "FCM Messaging token sign up: $token";

                                              if (appConfig
                                                  .notNullOrEmpty(token)) {
                                                _bloc.add(
                                                  LoginEvent(
                                                    username: _phone,
                                                    password: _password,
                                                    device_token: token,
                                                    isRememberMe: true,
                                                    cancelToken:
                                                        _loginCancelToken,
                                                  ),
                                                );
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: Translations.of(
                                                            context)
                                                        .translate(
                                                            'something_went_wrong_try_again'));
                                              }
                                            });
                                          }
                                        },
                                        borderRadius: 8.w,
                                        child: Container(
                                          child: Center(
                                            child: Text(
                                              Translations.of(context)
                                                  .translate('login'),
                                              style: textStyle.middleTSBasic
                                                  .copyWith(
                                                      color: globalColor.white),
                                            ),
                                          ),
                                        ),
                                      )),
                                  VerticalPadding(
                                    percentage: 1.5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.Get.toNamed(ForgotPage.routeName);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: EdgeMargin.min,
                                          right: EdgeMargin.min),
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: Text(
                                        Translations.of(context)
                                            .translate('forgot_password'),
                                        style: textStyle.smallTSBasic.copyWith(
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ),
                                  VerticalPadding(
                                    percentage: 5.5,
                                  ),
                                  _buildSignUpButton(context)
                                ],
                              ),
                            ),
                          ),
                        ),
                      )));
            },
          ),
          listener: (context, state) async {
            if (state is LoginSuccess) {
              // while (Navigator.of(context).canPop())
              //   Navigator.of(context).pop();
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (ctx) => MainPage(),
              //   ),
              // );
              ///todo fcm update token
              BlocProvider.of<ApplicationBloc>(context)
                    ..add(SetUserDataLoginEvent())
                  // ..add(GetFCMTokenAndUpdateItEvent())

                  ;
              Get.Get.offAllNamed(MainRootPage.routeName);
            }
            if (state is LoginSuccessButNeedVerify) {
              BlocProvider.of<ApplicationBloc>(context)
                    ..add(SetUserDataLoginEvent())
                  // ..add(GetFCMTokenAndUpdateItEvent())
                  ;
              // Get.Get.offAllNamed(MainRootPage.routeName);

              Get.Get.toNamed(VerifyPage.routeName,
                  arguments: VerifyPageArgs(
                      userName: state.data.mobile,
                      otpCode: state.data.otpCode));
            }
            if (state is LoginFailure) {
              final error = state.error;
              if (error is ConnectionError) {
                ErrorViewer.showCustomError(context,
                    Translations.of(context).translate('err_connection'));
              } else if (error is CustomError) {
                ErrorViewer.showCustomError(context, error.message);
              } else if (error is BadRequestError) {
                ErrorViewer.showCustomError(context, error.message);
              } else if (error is UnauthorizedHttpError) {
                ErrorViewer.showCustomError(context, error.message);
              } else {
                ErrorViewer.showUnexpectedError(context);
              }
            }
          },
        ));
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Wrap(
            children: <Widget>[
              Text(
                Translations.of(context).translate('not_you_have_account'),
                style: textStyle.middleTSBasic,
              ),
            ],
          ),
          SizedBox(width: 2),
          Wrap(
            children: <Widget>[
              InkWell(
                child: Text(
                  Translations.of(context).translate('create_account'),
                  style: textStyle.middleTSBasic,
                ),
                onTap: () {
                  Get.Get.toNamed(SignUpPage.routeName);
                },
              )
            ],
          ),
          cardDivider()
        ],
      ),
    );
  }

  cardDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Container(
        color: globalColor.white,
        height: 15.h,
        width: 1.0,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _loginCancelToken.cancel();
    _bloc.close();
  }
}
