import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Translations {
  Translations(Locale locale) {
    this.locale = locale;
    _localizedValues = null;
  }

  late Locale locale;
  static Map<dynamic, dynamic>? _localizedValues;

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations)!;
  }

  String translate(String key) {
    if (_localizedValues == null) return '';
    return _localizedValues![key] ?? '** $key not found.';
  }

  static Future<Translations> load(Locale locale) async {
    Translations translations = Translations(locale);
    String jsonContent = await rootBundle
        .loadString('assets/locales/${locale.languageCode}.json');
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  String get currentLanguage => locale.languageCode;
}
