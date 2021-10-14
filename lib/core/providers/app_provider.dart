import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ojos_app/core/appConfig.dart';
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/core/localization/specific_localization_delegate.dart';
import 'package:ojos_app/core/res/utils.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    checkLanguage();
  }

  String lang = LANG_AR;
  late SpecificLocalizationDelegate localeOverrideDelegate;

  Key? key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void setTheme(String value, c) {
    appConfig.setLanguage(value);
    lang = value;
    localeOverrideDelegate = SpecificLocalizationDelegate(Locale(value));
    notifyListeners();
  }

  String getTheme(value) {
    // return theme;
    return lang;
  }

  Future<String> checkLanguage() async {
    String language = utils.getLang();
    localeOverrideDelegate = SpecificLocalizationDelegate(Locale(language));
    lang = language;
    print("this language is $language ");
    if (language == LANG_AR) {
      utils.setLang(language);
      //  setTheme(language, LANG_AR);
    } else {
      utils.setLang(language);
      //     setTheme(language, LANG_EN);
    }

    return language;
  }
}
