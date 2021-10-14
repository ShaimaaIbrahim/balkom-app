import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/repositories/repository.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/features/user_management/data/api_requests/forgot_password_request.dart';
import 'package:ojos_app/features/user_management/data/api_requests/login_request.dart';
import 'package:ojos_app/features/user_management/data/api_requests/register_request.dart';
import 'package:ojos_app/features/user_management/data/api_requests/reset_password_request.dart';
import 'package:ojos_app/features/user_management/data/api_requests/verify_request.dart';
import 'package:ojos_app/features/user_management/data/models/login_result_model.dart';
import 'package:ojos_app/features/user_management/domain/entities/forget_result.dart';
import 'package:ojos_app/features/user_management/domain/entities/login_result.dart';
import 'package:ojos_app/features/user_management/domain/entities/register_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main_root.dart';

abstract class UserRepository extends Repository {
  static SharedPreferences? prefs;

  static initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<Result<BaseError, RegisterResult>> register({
    @required RegisterRequest data,
    CancelToken cancelToken,
  });

  Future<Result<BaseError, Object>> resendCode({
    @required Map<String, dynamic> queryParameters,
    @required String urlResendCode,
    CancelToken cancelToken,
  });

  Future<Result<BaseError, Object>> verify({
    @required VerifyRequest data,
    CancelToken cancelToken,
  });

  Future<Result<BaseError, LoginResult>> login({
    @required LoginRequest data,
    CancelToken cancelToken,
  });

  Future<Result<BaseError, Object>> forgetPassword({
    @required Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
  });

  Future<Result<BaseError, Object>> verifiedForgotPassword({
    @required Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
  });

  Future<Result<BaseError, Object>> changePassword({
    @required Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
  });

  ///****

  Future<Result<BaseError, ForgetResult>> forgotPassword({
    @required ForgotPasswordRequest data,
    CancelToken cancelToken,
  });

  Future<Result<BaseError, Object>> resetPassword({
    @required ResetPasswordRequest data,
    CancelToken cancelToken,
  });

  Future<Result<BaseError, Object>> reSendCode({
    @required String username,
    @required String device_token,
    CancelToken cancelToken,
  });

  Future<Result<BaseError, Object>> changeUserNamePhoneNumberOrEmail({
    @required Map<String, dynamic> queryParameters,
    @required String changeUserNameUrl,
    CancelToken cancelToken,
  });

  Future<void> logout() async {
    if (prefs == null) initSharedPreferences();
    await this.deleteToken();

    ///todo delete notification intance
    //  await this.deleteFcmToken();
    await this.deleteProfile();
    //await this.deleteInstanceIDFcmToken();
  }

  Future<bool> deleteProfile() async {
    if (prefs == null) initSharedPreferences();
    return prefs!.remove(USER_DATA_LOGIN);
  }

  Future<void> deleteToken() async {
    if (prefs == null) initSharedPreferences();
    await prefs!.remove(KEY_TOKEN);
    return;
  }

  Future<void> persistToken(String token) async {
    if (prefs == null) initSharedPreferences();
    await prefs!.setString(KEY_TOKEN, token);
    return;
  }

  static Future<bool> persistUserDataLogin(LoginResultModel profile) async {
    if (prefs == null) initSharedPreferences();
    final profileJson = jsonEncode(profile.toJson());

    return prefs!.setString(USER_DATA_LOGIN, profileJson);
  }

  static Future<LoginResult?>? get cachedUserData async {
    if (prefs == null) initSharedPreferences();
    if (await hasToken) {
      var profileJson = prefs!.getString(USER_DATA_LOGIN);
      var profile = LoginResultModel.fromJson(jsonDecode(profileJson!));
      return profile.toEntity();
    }
    return null;
  }

  static Future<String?>? get authToken async {
    if (prefs == null) initSharedPreferences();
    return prefs!.getString(KEY_TOKEN);
  }

  static Future<bool> get hasToken async {
    if (prefs == null) initSharedPreferences();
    final token = prefs!.getString(KEY_TOKEN);
    if (token != null && token.isNotEmpty) return true;
    return false;
  }

  // static Future<RegisterResult> get cachedProfile async {
  //   if (prefs == null) initSharedPreferences();
  //   if (await hasToken) {
  //     var profileJson = prefs.getString(KEY_PROFILE);
  //     var profile = ProfileModel.fromJson(jsonDecode(profileJson));
  //     return profile.toEntity();
  //   }
  //   return null;
  // }
  static Future<bool> get hasFcmToken async {
    if (prefs == null) initSharedPreferences();
    final token = prefs!.getString(KEY_FCM_TOKEN);
    if (token != null && token.isNotEmpty) return true;
    return false;
  }

  static Future<String?>? get fcmToken async {
    if (prefs == null) initSharedPreferences();
    return prefs!.getString(KEY_FCM_TOKEN);
  }

  Future<void> persistFcmToken(String token) async {
    if (prefs == null) initSharedPreferences();
    await prefs!.setString(KEY_FCM_TOKEN, token);
    return;
  }

  static Future<String>? getFcmTokenForDevice() {
    firebaseMessaging.getToken().then((token) async {
      assert(token != null);
      var _homeScreenText;
      _homeScreenText = "FCM Messaging token: $token";

      print(_homeScreenText);
      return token;
    });
  }
}
