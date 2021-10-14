import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as Get;
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
import 'package:ojos_app/core/validators/required_validator.dart';
import 'package:ojos_app/features/user_management/presentation/args/forget_args.dart';
import 'package:ojos_app/features/user_management/presentation/blocs/forgot_password_bloc.dart';
import 'package:ojos_app/features/user_management/presentation/pages/reset_password_page.dart';
import 'package:ojos_app/features/user_management/presentation/pages/sign_up_page.dart';
import 'package:ojos_app/features/user_management/presentation/widgets/user_management_background.dart';
import 'package:ojos_app/features/user_management/presentation/widgets/user_management_text_field_widget.dart';
import 'package:ojos_app/xternal_lib/model_progress_hud.dart';

import '../../../main_root.dart';

class ForgotPage extends StatelessWidget {
  static const routeName = '/features/ForgotPage';

  @override
  Widget build(BuildContext context) {
    double widthC = globalSize.setWidthPercentage(100, context);
    double heightC = globalSize.setHeightPercentage(100, context);
    return Container(
      width: widthC,
      height: heightC,
      child: ForgotBox(),

      // Stack(
      // children:

      // [
      //   UserManagementBackground(
      //     height: heightC,
      //     image: AppAssets.backgroundVerify,
      //     width: widthC,
      //   ),
      // ],
      // ),
    );
  }
}

class ForgotBox extends StatefulWidget {
  @override
  _ForgotBoxState createState() => _ForgotBoxState();
}

class _ForgotBoxState extends State<ForgotBox> {
  /// phone parameters
  bool _phoneValidation = false;
  String _phone = '';
  final TextEditingController phoneEditingController =
      new TextEditingController();

  final _bloc = ForgotPasswordBloc();
  final _forgotPasswordCancelToken = CancelToken();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _forgotPasswordCancelToken.cancel();
    _bloc.close();
  }

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
        body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          bloc: _bloc,
          child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            bloc: _bloc,
            builder: (context, state) {
              return ModalProgressHUD(
                  inAsyncCall: state is ForgotPasswordLoading,
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
                                    percentage: .5,
                                  ),

                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: EdgeMargin.normal,
                                        right: EdgeMargin.normal),
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      Translations.of(context)
                                          .translate('text_foroget_password'),
                                      style: textStyle.smallTSBasic,
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
                                            color: globalColor.white,
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
                                            _phoneValidation = true;
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
                                                  ForgotPasswordEvent(
                                                    mobile: _phone,
                                                    device_token: token,
                                                    cancelToken:
                                                        _forgotPasswordCancelToken,
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

                                  // _buildTryAgainButton(context)
                                ],
                              ),
                            ),
                          ),
                        ),
                      )));
            },
          ),
          listener: (context, state) async {
            if (state is ForgotPasswordSuccess) {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (ctx) => ResetPasswordPage(),
              //     settings: RouteSettings(
              //       arguments: ResetPasswordPageArgs(
              //         email: _email,
              //       ),
              //     ),
              //   ),
              // );
              Get.Get.toNamed(ResetPage.routeName,
                  arguments:
                      ForgetArgs(mobile: state.mobile!, code: state.code!));
            }
            if (state is ForgotPasswordFailure) {
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

// Widget _buildTryAgainButton(BuildContext context) {
//   return Column(
//     children: <Widget>[
//       Wrap(
//         children: <Widget>[
//           Text(
//             '${Translations.of(context).translate('did_not_get_the_code')} ',
//             style: textStyle.smallTSBasic.copyWith(
//                 color: globalColor.white
//             ),
//           ),
//           InkWell(
//             child: Text(
//               Translations.of(context).translate('send_back'),
//               style: textStyle.smallTSBasic.copyWith(
//                 //  decoration: TextDecoration.underline,
//                   color: globalColor.white
//               ),
//             ),
//             onTap: () {
//               Get.Get.back();
//             },
//           )
//         ],
//       ),
//     ],
//   );
// }
}
