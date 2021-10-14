import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojos_app/core/errors/bad_request_error.dart';
import 'package:ojos_app/core/errors/connection_error.dart';
import 'package:ojos_app/core/errors/custom_error.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/icon_size.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/utils.dart';
import 'package:ojos_app/core/ui/widget/button/rounded_button.dart';
import 'package:ojos_app/core/ui/widget/general_widgets/error_widgets.dart';
import 'package:ojos_app/core/ui/widget/image/photo_profile.dart';
import 'package:ojos_app/core/ui/widget/normal_assets_image.dart';
import 'package:ojos_app/core/validators/base_validator.dart';
import 'package:ojos_app/core/validators/match_validator.dart';
import 'package:ojos_app/core/validators/min_length_validator.dart';
import 'package:ojos_app/core/validators/required_validator.dart';
import 'package:ojos_app/features/profile/presentation/blocs/cahnge_password_bloc.dart';
import 'package:ojos_app/features/user_management/presentation/widgets/user_management_text_field_widget.dart';
import 'package:ojos_app/xternal_lib/model_progress_hud.dart';

class ProfileProtectionPage extends StatefulWidget {
  final double? width;
  final double? height;

  const ProfileProtectionPage({this.width, this.height});

  @override
  _ProfileProtectionPageState createState() => _ProfileProtectionPageState();
}

class _ProfileProtectionPageState extends State<ProfileProtectionPage> {
  /// message parameters
  bool _newPasswordValidation = false;
  String _newPassword = '';
  final TextEditingController newPasswordEditingController =
      new TextEditingController();

  /// phone parameters
  bool _oldPasswordValidation = false;
  String _oldPassword = '';
  final TextEditingController oldPasswordEditingController =
      new TextEditingController();

  /// fullName parameters
  bool _confirmPasswordValidation = false;
  String _confirmPassword = '';
  final TextEditingController confirmPasswordEditingController =
      new TextEditingController();

  var _changePasswordBloc = ChangePasswordBloc();
  var _cancelToken = CancelToken();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      bloc: _changePasswordBloc,
      listener: (BuildContext context, state) async {
        if (state is ChangePasswordDoneState) {
          ErrorViewer.showCustomError(
              context,
              Translations.of(context)
                  .translate('the_password_has_been_successfully_changed'));
        }
        if (state is ChangePasswordFailureState) {
          final error = state.error;
          if (error is ConnectionError) {
            ErrorViewer.showCustomError(
                context, Translations.of(context).translate('err_connection'));
          } else if (error is CustomError) {
            ErrorViewer.showCustomError(context, error.message);
          } else if (error is BadRequestError) {
            ErrorViewer.showCustomError(context, error.message);
          } else {
            ErrorViewer.showUnexpectedError(context);
          }
        }
      },
      child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
          bloc: _changePasswordBloc,
          builder: (BuildContext context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is ChangePasswordLoadingState,
              color: globalColor.primaryColor,
              opacity: 0.2,
              child: SingleChildScrollView(
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        VerticalPadding(
                          percentage: 2.0,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: EdgeMargin.min, right: EdgeMargin.min),
                          child: NormalOjosTextFieldWidget(
                            controller: oldPasswordEditingController,
                            style: textStyle.smallTSBasic.copyWith(
                                color: globalColor.black,
                                fontWeight: FontWeight.bold),
                            withShadow: true,
                            contentPadding: const EdgeInsets.fromLTRB(
                              EdgeMargin.small,
                              EdgeMargin.middle,
                              EdgeMargin.small,
                              EdgeMargin.small,
                            ),
                            fillColor: globalColor.white,
                            iconVisibilityColor: globalColor.black,
                            backgroundColor: globalColor.white,
                            labelBackgroundColor: globalColor.white,
                            borderColor: globalColor.grey.withOpacity(0.3),
                            isPasswordField: true,
                            validator: (value) {
                              return BaseValidator.validateValue(
                                context,
                                value!,
                                [RequiredValidator()],
                                _oldPasswordValidation,
                              );
                            },
                            hintText: '',
                            prefixIcon: Container(
                              width: 15.w,
                              height: 15.w,
                              child: Center(
                                child: SvgPicture.asset(
                                  AppAssets.lockSvg,
                                  color: globalColor.black,
                                  width: 15.w,
                                  height: 15.w,
                                ),
                              ),
                            ),
                            // maxLength: 10,
                            // inputFormat: [
                            //   LengthLimitingTextInputFormatter(10),
                            // ],
                            label: Translations.of(context)
                                .translate('old_password'),
                            keyboardType: TextInputType.visiblePassword,
                            borderRadius: widget.width! * .02,
                            onChanged: (value) {
                              setState(() {
                                _oldPasswordValidation = true;
                                _oldPassword = value;
                              });
                            },

                            //borderColor: globalColor.white,
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
                              left: EdgeMargin.min, right: EdgeMargin.min),
                          child: NormalOjosTextFieldWidget(
                            controller: newPasswordEditingController,
                            withShadow: true,
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
                            iconVisibilityColor: globalColor.black,
                            backgroundColor: globalColor.white,
                            labelBackgroundColor: globalColor.white,
                            borderColor: globalColor.grey.withOpacity(0.3),
                            isPasswordField: true,
                            validator: (value) {
                              return BaseValidator.validateValue(
                                context,
                                value!,
                                [
                                  RequiredValidator(),
                                  //  MinLengthValidator(minLength: 10),
                                ],
                                _newPasswordValidation,
                              );
                            },
                            hintText: '',
                            prefixIcon: Container(
                              width: 15.w,
                              height: 15.w,
                              child: Center(
                                child: SvgPicture.asset(
                                  AppAssets.lockSvg,
                                  color: globalColor.black,
                                  width: 15.w,
                                  height: 15.w,
                                ),
                              ),
                            ),
                            // maxLength: 10,
                            // inputFormat: [
                            //   LengthLimitingTextInputFormatter(10),
                            // ],
                            label: Translations.of(context)
                                .translate('new_password'),
                            keyboardType: TextInputType.visiblePassword,
                            borderRadius: widget.width! * .02,
                            onChanged: (value) {
                              setState(() {
                                _newPasswordValidation = true;
                                _newPassword = value;
                              });
                            },

                            //borderColor: globalColor.white,
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
                              left: EdgeMargin.min, right: EdgeMargin.min),
                          child: NormalOjosTextFieldWidget(
                            controller: confirmPasswordEditingController,
                            withShadow: true,
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
                            iconVisibilityColor: globalColor.black,
                            backgroundColor: globalColor.white,
                            labelBackgroundColor: globalColor.white,
                            borderColor: globalColor.grey.withOpacity(0.3),
                            isPasswordField: true,
                            validator: (value) {
                              return BaseValidator.validateValue(
                                context,
                                value!,
                                [
                                  RequiredValidator(),
                                  //MinLengthValidator(minLength: 10),
                                  MatchValidator(value: _newPassword)
                                ],
                                _confirmPasswordValidation,
                              );
                            },
                            hintText: '',
                            prefixIcon: Container(
                              width: 15.w,
                              height: 15.w,
                              child: Center(
                                child: SvgPicture.asset(
                                  AppAssets.lockSvg,
                                  color: globalColor.black,
                                  width: 15.w,
                                  height: 15.w,
                                ),
                              ),
                            ),
                            // maxLength: 10,
                            // inputFormat: [
                            //   LengthLimitingTextInputFormatter(10),
                            // ],
                            label: Translations.of(context)
                                .translate('confirm_new_password'),
                            keyboardType: TextInputType.visiblePassword,
                            borderRadius: widget.width! * .02,
                            onChanged: (value) {
                              setState(() {
                                _confirmPasswordValidation = true;
                                _confirmPassword = value;
                              });
                            },

                            //borderColor: globalColor.white,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                        ),
                        VerticalPadding(
                          percentage: 1.0,
                        ),
                        Spacer(),
                        Container(
                            padding: const EdgeInsets.only(
                                left: EdgeMargin.min, right: EdgeMargin.min),
                            child: RoundedButton(
                              height: 55.h,
                              width: widget.width,
                              color: globalColor.primaryColor,
                              onPressed: () {
                                setState(() {
                                  _oldPasswordValidation = true;
                                  _newPasswordValidation = true;
                                  _confirmPasswordValidation = true;
                                });
                                if (_formKey.currentState!.validate()) {
                                  _changePasswordBloc.add(
                                    ApplyChangePasswordEvent(
                                      newPassword: _newPassword,
                                      oldPassword: _oldPassword,
                                      cancelToken: _cancelToken,
                                    ),
                                  );
                                }
                              },
                              borderRadius: 8.w,
                              child: Container(
                                child: Center(
                                  child: Text(
                                    Translations.of(context).translate('send'),
                                    style: textStyle.middleTSBasic
                                        .copyWith(color: globalColor.white),
                                  ),
                                ),
                              ),
                            )),
                        VerticalPadding(
                          percentage: 1.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    _changePasswordBloc.close();
    _cancelToken.cancel();
    super.dispose();
  }
}
