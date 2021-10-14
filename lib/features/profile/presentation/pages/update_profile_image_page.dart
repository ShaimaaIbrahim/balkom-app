import 'package:dio/dio.dart';
import 'package:ojos_app/core/ui/widget/general_widgets/error_widgets.dart';
import 'package:flutter/material.dart';
import 'package:ojos_app/core/errors/connection_error.dart';
import 'package:ojos_app/core/errors/custom_error.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/features/profile/domin/repositories/profile_repository.dart';
import 'package:ojos_app/features/profile/domin/usecases/update_user_data.dart';
import 'package:ojos_app/features/profile/presentation/args/update_profile_image_page_args.dart';
import 'package:ojos_app/main.dart';
import 'package:get/get.dart' as Get;

class UpdateProfileImagePage extends StatefulWidget {
  static const routeName = '/update_profile_image';

  @override
  _UpdateProfileImagePageState createState() => _UpdateProfileImagePageState();
}

class _UpdateProfileImagePageState extends State<UpdateProfileImagePage> {
  final _updateProfileImageCancelToken = CancelToken();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final args = Get.Get.arguments as UpdateProfileImagePageArgs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () async {
            final path = args.image.path;
            await _updateUserProfile(context, path);
          },
        );
      }),
      body: Center(child: Image.file(args.image)),
    );
  }

  Future<void> _updateUserProfile(
      BuildContext context, String imagePath) async {
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(globalColor.primaryColor)),
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              Translations.of(context).translate('please_wait'),
              style: textStyle.smallTSBasic.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
    final profile = args.profile;
    final result = await UpdateUserData(locator<ProfileRepository>())(
      UpdateUserDataParams(
        name: profile.name,
        aboutMe: profile.aboutMe,
        address: profile.address,
        email: profile.email,
        //phone: profile.mobile,
        cancelToken: _updateProfileImageCancelToken,
        photo: imagePath,
//        cancelToken: _updateProfileImageCancelToken,
      ),
    );
    if (mounted) _scaffoldKey.currentState!.hideCurrentSnackBar();
    if (result.hasErrorOnly) {
      final error = result.error;
      if (error is ConnectionError) {
        ErrorViewer.showConnectionError(
          context,
          () {
            _updateUserProfile(context, imagePath);
          },
        );
      } else if (error is CustomError) {
        ErrorViewer.showCustomError(context, error.message);
      } else {
        ErrorViewer.showUnexpectedError(context);
      }
    } else {
      if (mounted) {
        //BlocProvider.of<ApplicationBloc>(context).add(SetUserProfileEvent());
        Get.Get.back();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _updateProfileImageCancelToken.cancel();
  }
}
