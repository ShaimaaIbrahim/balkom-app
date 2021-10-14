import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/res/text_size.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ojos_app/core/res/utils.dart';
import 'package:ojos_app/core/ui/widget/general_widgets/error_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'errors/connection_error.dart';
import 'errors/custom_error.dart';
import 'errors/forbidden_error.dart';
import 'errors/internal_server_error.dart';
import 'errors/unauthorized_error.dart';

typedef void LocaleChangeCallback(Locale locale);

class AppConfig {
  // Supported languages.
  final supportedLanguages = [LANG_AR, LANG_EN];

  // Supported locales
  Iterable<Locale> get supportedLocales => supportedLanguages.map(
        (language) => Locale(language, ''),
      );

  // Function() to be invoked when changing the working language
  late LocaleChangeCallback onLocaleChanged;

  Future<String> get currentLanguage async {
    final prefs = await SharedPreferences.getInstance();
    var lang = prefs.getString(KEY_LANG);
    if (lang == null || lang.isEmpty) {
      await prefs.setString(KEY_LANG, LANG_AR);
      lang = LANG_AR;
    }
    return lang;
  }

  Future<void> setLanguage(String lang) async {
    if (await currentLanguage == lang) return;

    utils.setLang(lang);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_LANG, lang);
    this.onLocaleChanged(Locale(lang, ''));
  }

  Future<void> setArabicLanguage() async {
    await setLanguage(LANG_AR);
  }

  Future<void> setEnglishLanguage() async {
    await setLanguage(LANG_EN);
  }

  bool notNullOrEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }

  Future<bool> canLaunchLink(String linkToOpen, BuildContext context) async =>
      await canLaunch(linkToOpen);

  launchURL(String urlPath) async {
    var url = urlPath;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  showToast({
    required String msg,
    Toast? toastLength,
    Color? backgroundColor,
    Color? textColor,
  }) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: textSize.small);
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  showError({
    required BaseError error,
    required BuildContext context,
    required ScaffoldState scaffoldState,
    required callback,
  }) {
    if (error is ConnectionError) {
      ErrorViewer.showConnectionError(
        context,
        callback,
        scaffoldState: scaffoldState,
      );
    } else if (error is CustomError) {
      ErrorViewer.showCustomError(
        context,
        error.message,
        //      callback,
        scaffoldState: scaffoldState,
      );
    } else if (error is UnauthorizedHttpError) {
      ErrorViewer.showCustomError(
        context,
        error.message,
        //      callback,
        scaffoldState: scaffoldState,
      );
    } else if (error is ForbiddenError) {
      ErrorViewer.showCustomError(
        context,
        error.message,
        //      callback,
        scaffoldState: scaffoldState,
      );
    } else if (error is InternalServerError) {
      ErrorViewer.showCustomError(
        context,
        error.message,
        //      callback,
        scaffoldState: scaffoldState,
      );
    } else {
      print(error);
      ErrorViewer.showUnexpectedError(
        context,
        scaffoldState: scaffoldState,
      );
    }
  }

  callMobile(String phoneNumber) async {
    // Android
    if (Platform.isAndroid) {
      //final String uri = 'tel:+963 949 954 951';
      final String uri = 'tel:+$phoneNumber';
      if (await canLaunch(uri)) await launch(uri);
    } else if (Platform.isIOS) {
      // iOS
      // final String uri = 'tel:+963-949-954-951';
      final String uri = 'tel:$phoneNumber';
      if (await canLaunch(uri)) await launch(uri);
    } else {
      final String uri = 'tel:$phoneNumber';
      if (await canLaunch(uri))
        await launch(uri);
      else {}
    }
  }
}

AppConfig appConfig = AppConfig();
