//import 'package:dio/dio.dart';
//import 'package:ojos_app/core/bloc/application_bloc.dart';
//import 'package:ojos_app/core/bloc/application_events.dart';
//import 'package:ojos_app/core/errors/connection_error.dart';
//import 'package:ojos_app/core/errors/custom_error.dart';
//import 'package:ojos_app/core/localization/translations.dart';
//import 'package:ojos_app/core/res/edge_margin.dart';
//import 'package:ojos_app/core/res/global_color.dart';
//import 'package:ojos_app/core/res/text_style.dart';
//import 'package:ojos_app/core/ui/widget/error_widgets.dart';
//import 'package:ojos_app/features/user_management/presentation/blocs/external_login_bloc.dart';
//import 'package:ojos_app/features/user_management/presentation/pages/register.dart';
//import 'package:ojos_app/features/user_management/presentation/pages/sign_in.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:flutter_svg/flutter_svg.dart';
// import 'package:ojos_app/extra_lip/model_progress_hud.dart';

//
//import '../../../main.dart';
//
//class GuestDialogItem extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => _GuestDialogState();
//}
//
//class _GuestDialogState extends State<GuestDialogItem>
//    with SingleTickerProviderStateMixin {
//  AnimationController controller;
//  Animation<double> scaleAnimation;
//  final _bloc = ExternalLoginBloc();
//  final _facebookLoginCancelToken = CancelToken();
//
//  @override
//  void initState() {
//    super.initState();
//
//    controller =
//        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//    scaleAnimation =
//        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
//
//    controller.addListener(() {
//      setState(() {});
//    });
//
//    controller.forward();
//  }
//
//  @override
//  void dispose() {
//    controller.dispose();
//    _bloc.close();
//    _facebookLoginCancelToken.cancel();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return BlocListener(
//        listener: (context, state) async {
//          if (state is ExternalLoginSuccess) {
//            BlocProvider.of<ApplicationBloc>(context)
//                .add(SetUserProfileEvent());
//            while (Navigator.of(context).canPop()) Navigator.of(context).pop();
//            Navigator.of(context).pushReplacementNamed(MainPage.routeName);
//          }
//          if (state is ExternalLoginFailure) {
//            final error = state.error;
//            if (error is ConnectionError) {
//              ErrorViewer.showConnectionError(context, state.callback);
//            } else if (error is CustomError) {
//              ErrorViewer.showCustomError(context, error.message);
//            } else {
//              print(error);
//              ErrorViewer.showUnexpectedError(context);
//            }
//          }
//        },
//        bloc: _bloc,
//        child: BlocBuilder<ExternalLoginBloc, ExternalLoginState>(
//            bloc: _bloc,
//            builder: (context, state) {
//              return ModalProgressHUD(
//                inAsyncCall: state is ExternalLoginLoading,
//                progressIndicator: CircularProgressIndicator(
//                  backgroundColor: globalColor.primary,
//                ),
//                child: _buildBody(context),
//              );
//            }));
//  }
//
//  Widget _buildBody(BuildContext context) {
//    return Center(
//      child: Material(
//        color: Colors.transparent,
//        child: ScaleTransition(
//          scale: scaleAnimation,
//          child: Container(
//            child: Wrap(
//              children: <Widget>[
//                Container(
//                  child: Card(
//                    color: globalColor.white,
//                    elevation: 2.0,
//                    child: Container(
//                      width: ScreenUtil().setWidth(270),
//                      padding: const EdgeInsets.all(8),
//                      child: Column(
//                        children: <Widget>[
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.end,
//                            mainAxisSize: MainAxisSize.max,
//                            children: <Widget>[
//                              IconButton(
//                                  icon: Icon(
//                                    Icons.clear,
//                                    color: globalColor.secondaryColor,
//                                  ),
//                                  onPressed: () {
//                                    Navigator.of(context).pop();
//                                  })
//                            ],
//                          ),
//                          Column(
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            mainAxisAlignment: MainAxisAlignment.spaceAround,
//                            children: <Widget>[
//                              _getImageLogo(context),
//                              _buildFacebookButton(
//                                  context, ScreenUtil().setWidth(270)),
//                              _getSignInAndSignUpOptions(context),
//                              SizedBox(
//                                height: 20,
//                              )
//                            ],
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget _getImageLogo(BuildContext context) {
//    return SizedBox(
//      width: ScreenUtil().setWidth(175),
//      height: ScreenUtil().setHeight(150),
//      child: FittedBox(
//        child: SvgPicture.asset(
//          'assets/images/splash/splash_img.svg',
//          fit: BoxFit.cover,
//        ),
//      ),
//    );
//  }
//
//  Widget _buildFacebookButton(required BuildContext context,  double width) {
//    //return ExternalLoginPage();
//    return Container(
//      height: width * 0.10,
//      width: width * .60,
//      margin:
//          const EdgeInsets.only(top: EdgeMargin.big, bottom: EdgeMargin.big),
//      child: RaisedButton(
//        color: globalColor.facebook,
//        textColor: globalColor.textButtonSend,
//        child: Row(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            SvgPicture.asset(
//              'assets/images/splash/facebook_f.svg',
//              width: width * 0.06,
//              height: width * 0.06,
//            ),
//            SizedBox(),
//            Flexible(
//              child: Text(
//                Translations.of(context).translate('continue_with_facebook'),
//                style: textStyle.minTextWhite,
//                overflow: TextOverflow.ellipsis,
//                maxLines: 1,
//              ),
//            ),
//          ],
//        ),
//        shape: OutlineInputBorder(
//            borderSide: BorderSide(
//          color: globalColor.facebook,
//        )),
//        onPressed: () {
////          Navigator.of(context).pushNamed(GeneralDocumentsPage.routeName);
//
//          _bloc.add(
//            LoginWithFacebookEvent(cancelToken: _facebookLoginCancelToken),
//          );
//        },
//      ),
//    );
//  }
//
//  Widget _getSignInAndSignUpOptions(BuildContext context) {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.center,
//      mainAxisSize: MainAxisSize.min,
//      children: <Widget>[
//        Text(
//          Translations.of(context).translate('not_you_have_account'),
//          style: textStyle.normalTextPrimary,
//          textAlign: TextAlign.center,
//        ),
//        SizedBox(
//          height: 10,
//        ),
//        Row(
//          mainAxisSize: MainAxisSize.min,
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            GestureDetector(
//              onTap: () {
//                Navigator.of(context).pop();
//                Navigator.of(context).pushNamed(SignInPage.routeName);
//              },
//              child: Text(
//                Translations.of(context).translate('login'),
//                style: textStyle.smallTextSecondry,
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 8),
//              child: Text(
//                Translations.of(context).translate('or'),
//                style: textStyle.smallTextSecondry,
//              ),
//            ),
//            GestureDetector(
//              onTap: () {
//                Navigator.of(context).pop();
//                Navigator.of(context).pushNamed(SignUpPage.routeName);
//              },
//              child: Text(
//                Translations.of(context).translate('register'),
//                style: textStyle.smallTextSecondry,
//              ),
//            ),
//          ],
//        ),
//      ],
//    );
//  }
//}
