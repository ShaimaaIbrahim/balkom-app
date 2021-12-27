import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ojos_app/core/appConfig.dart';
import 'package:ojos_app/core/errors/bad_request_error.dart';
import 'package:ojos_app/core/errors/connection_error.dart';
import 'package:ojos_app/core/errors/custom_error.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/ui/widget/button/rounded_button.dart';
import 'package:ojos_app/core/ui/widget/general_widgets/error_widgets.dart';
import 'package:ojos_app/core/validators/base_validator.dart';
import 'package:ojos_app/core/validators/required_validator.dart';
import 'package:ojos_app/features/profile/domin/entities/profile_entity.dart';
import 'package:ojos_app/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:ojos_app/features/user_management/presentation/widgets/user_management_text_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ojos_app/xternal_lib/model_progress_hud.dart';

import '../../../main_root.dart';

class BasicInfoPage extends StatefulWidget {
  final double? width;
  final double? height;
  const BasicInfoPage({this.width, this.height});
  @override
  _BasicInfoPageState createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends State<BasicInfoPage> with AutomaticKeepAliveClientMixin<BasicInfoPage> {
  var _cancelToken = CancelToken();

  /// message parameters
  bool _messageValidation = false;
  String _message = '';
  TextEditingController? messageEditingController;

  /// phone parameters
  bool _phoneValidation = false;
  String _phone = '';
  TextEditingController? phoneEditingController;

  /// fullName parameters
  bool _fullNameValidation = false;
  String _fullName = '';
  TextEditingController? fullNameEditingController;

  /// city parameters
  bool _cityValidation = false;
  String _city = '';
  TextEditingController? cityEditingController;

  String _image = '';
  ProfileEntity? _profile;
  final _formKey = GlobalKey<FormState>();
  var _profileBloc = ProfileBloc();
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _profileBloc.add(GetProfileEvent(cancelToken: _cancelToken));

    cityEditingController = new TextEditingController();
    fullNameEditingController = new TextEditingController();
    phoneEditingController = new TextEditingController();
    messageEditingController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<ProfileBloc, ProfileState>(
      bloc: _profileBloc,
      listener: (BuildContext context, state) async {
        if (state is ProfileDoneState) {
          fullNameEditingController!.text = state.profile!.name ?? '';
          _fullName = state.profile!.name ?? '';
          phoneEditingController!.text = state.profile!.phone ?? '';
          _phone = state.profile!.mobile ?? '';
          cityEditingController!.text = state.profile!.address ?? 'مكة المكرمة';
          _city = state.profile!.address ?? '';
          messageEditingController!.text = state.profile!.aboutMe ?? '';
          _message = state.profile!.aboutMe ?? '';
          _image = state.profile!.photo ?? '';
          _profile = state.profile;
          print('name $_fullName');
          print('phone $_phone');
        }
        if (state is ProfileFailureState) {
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
        if (state is UpdateProfileDoneState) {
          ErrorViewer.showCustomError(
              context,
              Translations.of(context)
                  .translate('msg_information_successfully_updated'));
        }
        if (state is UpdateProfileFailureState) {
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
      child: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: _profileBloc,
          builder: (BuildContext context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is ProfileLoadingState,
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
                        // _buildImage(),
                        // VerticalPadding(
                        //   percentage: 2.0,
                        // ),

                        Container(
                          padding: const EdgeInsets.only(
                              left: EdgeMargin.min, right: EdgeMargin.min),
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
                            withShadow: true,
                            labelBackgroundColor: globalColor.white,
                            validator: (value) {
                              return BaseValidator.validateValue(
                                context,
                                value!,
                                [RequiredValidator()],
                                _fullNameValidation,
                              );
                            },
                            hintText: 'عبدالرحمن محمد أحمد المطيري',
                            label:
                                Translations.of(context).translate('full_name'),
                            keyboardType: TextInputType.text,
                            borderRadius: widget.width! * .02,
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
                            borderColor: globalColor.grey.withOpacity(0.3),
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
                            controller: phoneEditingController,
                            // maxLines: 4,
                            filled: true,
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
                            readOnly: true,
                            borderRadius: widget.width! * .02,
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
                            borderColor: globalColor.grey.withOpacity(0.3),
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
                            controller: cityEditingController,
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
                            withShadow: true,
                            labelBackgroundColor: globalColor.white,
                            validator: (value) {
                              return BaseValidator.validateValue(
                                context,
                                value!,
                                [RequiredValidator()],
                                _cityValidation,
                              );
                            },
                            hintText: '',
                            label: Translations.of(context).translate('city'),
                            keyboardType: TextInputType.text,
                            borderRadius: widget.width! * .02,
                            // prefixIcon: Container(
                            //   width: 15.w,
                            //   height: 15.w,
                            //   child: Center(
                            //     child: SvgPicture.asset(
                            //       AppAssets.userSvg,
                            //       color: globalColor.black,
                            //       width: 15.w,
                            //       height: 15.w,
                            //     ),
                            //   ),
                            // ),
                            onChanged: (value) {
                              setState(() {
                                _cityValidation = true;
                                _city = value;
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
                          percentage: 1.0,
                        ),

                        Container(
                          padding: const EdgeInsets.only(
                              left: EdgeMargin.min, right: EdgeMargin.min),
                          child: NormalOjosTextFieldWidget(
                            controller: messageEditingController,
                            maxLines: 4,
                            filled: true,
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
                            label: Translations.of(context).translate('notes'),
                            keyboardType: TextInputType.text,
                            borderRadius: widget.width! * .02,
                            onChanged: (value) {
                              setState(() {
                                _messageValidation = true;
                                _message = value;
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
                          percentage: 4.0,
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
                                if (!_formKey.currentState!.validate()) {
                                  _scrollController.animateTo(
                                    0,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.bounceInOut,
                                  );
                                } else {
                                  firebaseMessaging
                                      .getToken()
                                      .then((token) async {
                                    assert(token != null);
                                    /*   var _homeScreenText;
                                    _homeScreenText =
                                        "FCM Messaging token sign up: $token";*/

                                    if (appConfig.notNullOrEmpty(token)) {
                                      _profileBloc.add(UpdateProfileEvent(
                                          name: _fullName,
                                          device_token: token,
                                          mobile: _phone,
                                          aboutMe: _message,
                                          address: _city,
                                          email: '',
                                          cancelToken: _cancelToken));
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: Translations.of(context).translate(
                                              'something_went_wrong_try_again'));
                                    }
                                  });
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

  /*_buildImage() {
    return Container(
      width: widget.height * .245,
      height: widget.height * .245,
      child: Stack(
        children: <Widget>[
          Container(
            width: widget.height * .245,
            height: widget.height * .245,
            alignment: AlignmentDirectional.centerEnd,
            child: Container(
              width: widget.height * .23,
              height: widget.height * .23,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.height * .204),
                    side: BorderSide(color: globalColor.primaryColor)),
                color: Colors.white,
                child: Container(
                  width: widget.height! * .204,
                  height: widget.height! * .204,
                  child: Container(
                    width: widget.height! * .204,
                    height: widget.height! * .204,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.height * .204),
                      border: Border.all(
                        color: Colors.white,
                        width: 6.0,
                      ),
                    ),
                    child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(widget.height * .20),
                        child: GestureDetector(
                          onTap: () {
                            // _changeImageProfile(state.profile.image ?? '');
                            _changeImageProfile(
                                _image ?? '',
                                ProfileEntity(
                                  photo: _image,
                                  mobile: _phone,
                                  name: _fullName,
                                  phone: _phone,
                                  aboutMe: _message,
                                  address: _city,
                                  email: '',
                                  id: _profile.id ?? 0,
                                ));
                          },
                          child: appConfig.notNullOrEmpty(_image)
                              ? ImageCacheWidget(
                                  imageUrl: _image ?? '',
                                  imageHeight: widget.height * .204,
                                  imageWidth: widget.height * .204,
                                  imageBorderRadius: widget.height * .20,
                                )
                              : NormalAssetsImage(
                                  imageUrl: AppAssets.defualt_image,
                                  height: widget.height * .204,
                                  width: widget.height * .204,
                                  imageBorderRadius: widget.height * .20,
                                ),
                        )),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: GestureDetector(
              onTap: () {
                // _changeImageProfile(state.profile.image ?? '');
                _changeImageProfile(
                    _image ?? '',
                    ProfileEntity(
                      photo: _image,
                      mobile: _phone,
                      name: _fullName,
                      phone: _phone,
                      aboutMe: _message,
                      address: _city,
                      email: '',
                      id: _profile.id ?? 0,
                    ));
              },
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: globalColor.goldColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: globalColor.white, width: 2)),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.edit_icon_svg,
                    width: 15,
                    color: globalColor.black,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }*/

/*
  void _changeImageProfile(String imgUrl, ProfileEntity profile) {
    showModalBottomSheetCustom(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(8)),

              //=================
              //   take_photo
              //=================
              ListTile(
                onTap: () async {
                  final image =
                      await ImagePicker.pickImage(source: ImageSource.camera);
                  if (image == null) return;
                  await Get.Get.toNamed(UpdateProfileImagePage.routeName,
                      arguments: UpdateProfileImagePageArgs(
                          image: image, profile: profile));
                  // Get.Get.back();
                },
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 8),
                    Icon(
                      EvilIcons.camera,
                      color: globalColor.black,
                      size: IconSize.large,
                    ),
                    SizedBox(width: 8),
                    Text(
                      Translations.of(context).translate('take_photo'),
                      style: textStyle.middleTSBasic
                          .copyWith(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),

              //==========================
              //   upload_from_gallery
              //==========================
              ListTile(
                onTap: () async {
                  final image = await ImagePicker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image == null) return;
                  await Get.Get.toNamed(UpdateProfileImagePage.routeName,
                      arguments: UpdateProfileImagePageArgs(
                          image: image, profile: profile));
                  // await Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return UpdateProfileImagePage();
                  //     },
                  //     settings: RouteSettings(
                  //       arguments: UpdateProfileImagePageArgs(
                  //         image: image,
                  //       ),
                  //     ),),
                  // );
                  // Navigator.of(context).pop();
                },
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 8),
                    Icon(
                      EvilIcons.image,
                      color: globalColor.black,
                      size: IconSize.large,
                    ),
                    SizedBox(width: 8),
                    Text(
                      Translations.of(context).translate('upload_from_gallery'),
                      style: textStyle.middleTSBasic
                          .copyWith(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),

              //=================
              //   view image
              //=================
              appConfig.notNullOrEmpty(imgUrl)
                  ? ListTile(
                      onTap: () async {
                        final page = PhotoDetailPage(
                          image: imgUrl,
                          tag: imgUrl,
                        );
                        await Navigator.of(context).push(
                          PageRouteBuilder<Null>(
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) {
                              return FadeTransition(
                                opacity: animation,
                                child: page,
                              );
                            },
                            transitionDuration: Duration(milliseconds: 700),
                          ),
                        );
                      },
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(width: 8),
                          Icon(
                            EvilIcons.user,
                            color: globalColor.black,
                            size: IconSize.large,
                          ),
                          SizedBox(width: 8),
                          Text(
                            Translations.of(context)
                                .translate('view_profile_picture'),
                            style: textStyle.middleTSBasic
                                .copyWith(fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    )
                  : Container(),

              SizedBox(height: ScreenUtil().setHeight(2)),
            ],
          ),
        );
      },
    );
  }
*/

  @override
  void dispose() {
    _profileBloc.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
