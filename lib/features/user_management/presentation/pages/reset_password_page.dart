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
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/core/errors/connection_error.dart';
import 'package:ojos_app/core/errors/custom_error.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/providers/auth_service.dart';
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
import 'package:ojos_app/features/user_management/presentation/args/forget_args.dart';
import 'package:ojos_app/features/user_management/presentation/blocs/forgot_password_bloc.dart';
import 'package:ojos_app/features/user_management/presentation/blocs/reset_password_bloc.dart';
import 'package:ojos_app/features/user_management/presentation/pages/sign_up_page.dart';
import 'package:ojos_app/features/user_management/presentation/widgets/user_management_background.dart';
import 'package:ojos_app/features/user_management/presentation/widgets/user_management_text_field_widget.dart';
import 'package:ojos_app/xternal_lib/model_progress_hud.dart';

import '../../../main_root.dart';
import 'sign_in_page.dart';

class ResetPage extends StatefulWidget {
  static const routeName = '/features/ResetPage';

  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final args = Get.Get.arguments as ForgetArgs;

  @override
  Widget build(BuildContext context) {
    double widthC = globalSize.setWidthPercentage(100, context);
    double heightC = globalSize.setHeightPercentage(100, context);
    return Container(
      width: widthC,
      height: heightC,
      child: ResetPageBox(
        mobile: args.mobile,
        otpCode: args.code,
      ),

      // Stack(
      //   children: [
      //     UserManagementBackground(
      //       height: heightC,
      //       image: AppAssets.backgroundVerify,
      //       width: widthC,
      //     ),
      //   ],
      // ),
    );
  }
}

class ResetPageBox extends StatefulWidget {
  final String? mobile;
  final int? otpCode;

  const ResetPageBox({this.mobile, this.otpCode});
  @override
  _ResetPageBoxState createState() => _ResetPageBoxState();
}

class _ResetPageBoxState extends State<ResetPageBox> {
  /// message parameters
  bool _newPasswordValidation = false;
  String _newPassword = '';
  final TextEditingController newPasswordEditingController =
      new TextEditingController();

  /// phone parameters
  bool _codeValidation = false;
  String _code = '';
  final TextEditingController codeEditingController =
      new TextEditingController();

  /// fullName parameters
  bool _confirmPasswordValidation = false;
  String _confirmPassword = '';
  final TextEditingController confirmPasswordEditingController =
      new TextEditingController();

  final _bloc = ResetPasswordBloc();
  final _forgotPasswordCancelToken = CancelToken();

  final _formKey = GlobalKey<FormState>();
  String phoneNuumberWithCode = '';
  final AuthService firebaseAuth = AuthService();
  @override
  void dispose() {
    super.dispose();
    _forgotPasswordCancelToken.cancel();
    _bloc.close();
    firebaseAuth.signOut();
  }

  @override
  void initState() {
    super.initState();
    if (widget.mobile != null && widget.mobile![0] == '0') {
      phoneNuumberWithCode = GMS + widget.mobile!.substring(1);
    } else {
      phoneNuumberWithCode = GMS + widget.mobile!;
    }
    firebaseAuth.sendingSMSForProvidedPhoneNumber(
      //     phoneNumber: '00963'+widget.mobileNumber,
      phoneNumber: GMS + widget.mobile!,
      // phoneNumber: widget.mobile,

      onSendSMSDone: _onSendSMSDone,
    );
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
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      iconTheme: IconThemeData(
        color: globalColor.black,
      ),
      title: Text(
        '',
        style: textStyle.middleTSBasic.copyWith(color: globalColor.white),
      ),
      elevation: 0,
      centerTitle: true,
    );

    double widthC = globalSize.setWidthPercentage(100, context);
    double heightC = globalSize.setHeightPercentage(100, context);

    return Scaffold(
        appBar: appBar,
        // backgroundColor: globalColor.transparent,
        body: BlocListener<ResetPasswordBloc, ResetPasswordState>(
          bloc: _bloc,
          child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
            bloc: _bloc,
            builder: (context, state) {
              return ModalProgressHUD(
                  inAsyncCall: state is ResetPasswordLoading,
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
                                  //
                                  VerticalPadding(
                                    percentage: 5.5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: EdgeMargin.min,
                                        right: EdgeMargin.min),
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      Translations.of(context)
                                          .translate('password_recovery'),
                                      style: textStyle.bigTSBasic.copyWith(
                                          color: globalColor.goldColor),
                                    ),
                                  ),

                                  VerticalPadding(
                                    percentage: 7.5,
                                  ),

                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: EdgeMargin.min,
                                        right: EdgeMargin.min),
                                    child: UserManagementTextFieldWidget(
                                      controller: codeEditingController,
                                      validator: (value) {
                                        return BaseValidator.validateValue(
                                          context,
                                          value!,
                                          [RequiredValidator()],
                                          _codeValidation,
                                        );
                                      },
                                      hintText: '',
                                      prefixIcon: Container(
                                        width: 15.w,
                                        height: 15.w,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            AppAssets.phoneSvg,
                                            color: globalColor.white,
                                            width: 15.w,
                                            height: 15.w,
                                          ),
                                        ),
                                      ),
                                      label: Translations.of(context)
                                          .translate('verification_code'),
                                      keyboardType: TextInputType.number,
                                      borderRadius: widthC * .02,
                                      onChanged: (value) {
                                        setState(() {
                                          _codeValidation = true;
                                          _code = value;
                                        });
                                      },
                                      borderColor: globalColor.white,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context).nextFocus();
                                      },
                                    ),
                                  ),

                                  VerticalPadding(
                                    percentage: 1.0,
                                  ),

                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: EdgeMargin.min,
                                        right: EdgeMargin.min),
                                    child: UserManagementTextFieldWidget(
                                      controller: newPasswordEditingController,
                                      isPasswordField: true,
                                      validator: (value) {
                                        return BaseValidator.validateValue(
                                          context,
                                          value!,
                                          [RequiredValidator()],
                                          _newPasswordValidation,
                                        );
                                      },
                                      hintText: '',
                                      inputFormat: [
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      prefixIcon: Container(
                                        width: 15.w,
                                        height: 15.w,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            AppAssets.lockSvg,
                                            color: globalColor.white,
                                            width: 15.w,
                                            height: 15.w,
                                          ),
                                        ),
                                      ),
                                      label: Translations.of(context)
                                          .translate('new_password'),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      borderRadius: widthC * .02,
                                      onChanged: (value) {
                                        setState(() {
                                          _newPasswordValidation = true;
                                          _newPassword = value;
                                        });
                                      },
                                      borderColor: globalColor.white,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context).nextFocus();
                                      },
                                    ),
                                  ),

                                  VerticalPadding(
                                    percentage: 1.0,
                                  ),

                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: EdgeMargin.min,
                                        right: EdgeMargin.min),
                                    child: UserManagementTextFieldWidget(
                                      controller:
                                          confirmPasswordEditingController,
                                      isPasswordField: true,
                                      validator: (value) {
                                        return BaseValidator.validateValue(
                                          context,
                                          value!,
                                          [RequiredValidator()],
                                          _confirmPasswordValidation,
                                        );
                                      },
                                      hintText: '',
                                      inputFormat: [
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      prefixIcon: Container(
                                        width: 15.w,
                                        height: 15.w,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            AppAssets.lockSvg,
                                            color: globalColor.white,
                                            width: 15.w,
                                            height: 15.w,
                                          ),
                                        ),
                                      ),
                                      label: Translations.of(context)
                                          .translate('confirm_new_password'),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      borderRadius: widthC * .02,
                                      onChanged: (value) {
                                        setState(() {
                                          _confirmPasswordValidation = true;
                                          _confirmPassword = value;
                                        });
                                      },
                                      borderColor: globalColor.white,
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
                                        borderRadius: 8.w,
                                        onPressed: () {
                                          setState(() {
                                            _codeValidation = true;
                                            _newPasswordValidation = true;
                                            _confirmPasswordValidation = true;
                                          });
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // firebaseMessaging.getToken().then((token) async {
                                            //   assert(token != null);
                                            //   var _homeScreenText;
                                            //   _homeScreenText = "FCM Messaging token sign up: $token";
                                            //
                                            //   if(appConfig.notNullOrEmpty(token)){
                                            //
                                            //   }
                                            //   else{
                                            //     Fluttertoast.showToast(
                                            //         msg: Translations.of(context)
                                            //             .translate('something_went_wrong_try_again'));
                                            //   }
                                            //
                                            // });

                                            firebaseAuth.signInWithPhoneNumber(
                                                smsCode: _code,
                                                onVerifyDone: (result) {
                                                  /// result is true then the process done successfully
                                                  /// you can make your own request here.
                                                  if (result) {
                                                    if (_code != null &&
                                                        _code.isNotEmpty &&
                                                        _code.length == 6) {
                                                      _bloc.add(
                                                        ResetPasswordEvent(
                                                          mobile:
                                                              widget.mobile!,
                                                          otp_code: widget
                                                              .otpCode
                                                              .toString(),
                                                          password:
                                                              _newPassword,
                                                          cancelToken:
                                                              _forgotPasswordCancelToken,
                                                        ),
                                                      );
                                                      // _bloc.add(
                                                      //   VerifyEvent(
                                                      //     mobile: widget.mobileNumber,
                                                      //     code: widget.otpCode.toString(),
                                                      //     cancelToken: _verifyCancelToken,
                                                      //   ),
                                                      // );
                                                    } else {
                                                      ErrorViewer.showCustomError(
                                                          context,
                                                          Translations.of(
                                                                  context)
                                                              .translate(
                                                                  'msg_code_missing'));
                                                    }
                                                  }

                                                  /// otherwise no
                                                  else {
                                                    appConfig.showToast(
                                                        msg: Translations.of(
                                                                context)
                                                            .translate(
                                                                'the_code_is_wrong'),
                                                        backgroundColor:
                                                            globalColor
                                                                .primaryColor,
                                                        textColor:
                                                            globalColor.white);
                                                  }
                                                });
                                          }
                                        },
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
                                    percentage: 2.5,
                                  ),

                                  _buildTryAgainButton(context)
                                ],
                              ),
                            ),
                          ),
                        ),
                      )));
            },
          ),
          listener: (context, state) async {
            if (state is ResetPasswordSuccess) {
              Get.Get.offAllNamed(SignInPage.routeName);
            }
            if (state is ResetPasswordFailure) {
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
        ));
  }

  Widget _buildTryAgainButton(BuildContext context) {
    return Column(
      children: <Widget>[
        Wrap(
          children: <Widget>[
            Text(
              '${Translations.of(context).translate('did_not_get_the_code')} ',
              style: textStyle.smallTSBasic.copyWith(color: globalColor.black),
            ),
            InkWell(
              child: Text(Translations.of(context).translate('send_back'),
                  style: textStyle.smallTSBasic),
              onTap: () {
                firebaseAuth.sendingSMSForProvidedPhoneNumber(
                  // phoneNumber: '00963'+widget.mobileNumber,
                  phoneNumber: GMS + widget.mobile!,
                  //  phoneNumber: widget.mobile,
                  onSendSMSDone: _onSendSMSDone,
                );
                appConfig.showToast(
                    msg: Translations.of(context)
                        .translate('new_code_is_being_requested_please wait'),
                    backgroundColor: globalColor.primaryColor,
                    textColor: globalColor.white);
                // firebaseMessaging.getToken().then((token) async {
                //   assert(token != null);
                //   var _homeScreenText;
                //   _homeScreenText = "FCM Messaging token sign up: $token";
                //
                //   if(appConfig.notNullOrEmpty(token)){
                //     _bloc.add(
                //       ResendCodeEvent(
                //         username:widget.mobile,
                //         device_token: token,
                //         cancelToken: _forgotPasswordCancelToken,
                //       ),
                //     );
                //   }
                //   else{
                //     Fluttertoast.showToast(
                //         msg: Translations.of(context)
                //             .translate('something_went_wrong_try_again'));
                //   }
                //
                // });
              },
            )
          ],
        ),
      ],
    );
  }

  _onSendSMSDone(bool result) {
    /// result is true then the process done successfully
    if (result) {
      appConfig.showToast(
          msg: Translations.of(context)
              .translate('The_verification_code_is_being_requested'),
          backgroundColor: globalColor.primaryColor,
          textColor: globalColor.white);
    }

    /// otherwise does not succeeded for some reasons
    else {
      appConfig.showToast(
          msg: Translations.of(context).translate('please_try_later'),
          backgroundColor: globalColor.primaryColor,
          textColor: globalColor.white);
    }
  }
}
