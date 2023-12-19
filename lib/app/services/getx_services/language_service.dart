import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/values/localization/languages/english.dart';
import '../../data/providers/shared_preferences.dart';

class LanguageService extends GetxService implements Translations {
  final _storage = Get.find<SharedPreferences>();
  final _languageModeKey = 'languageMode';

  final fallbackLocale = const Locale('en');
  final fallbackMode = 'en';

  Locale get locale => _getUsedLanguage();

  String get languageMode => _getLanguageMode();

  bool get isEnglishLanguage => Get.locale == const Locale('en');

  @override
  Map<String, Map<String, String>> get keys => {
        'en': english,
      };

  String _getLanguageMode() {
    return _storage.getString(_languageModeKey) ?? fallbackMode;
  }

  Locale _getUsedLanguage() {
    String? langMode = _storage.getString(_languageModeKey);
    return Locale(langMode ??
        Get.deviceLocale?.languageCode ??
        fallbackLocale.languageCode);
  }

  void _setUsedLanguage(String languageMode) {
    _storage.setString(_languageModeKey, languageMode);
  }

  void changeLanguage(String langMode) {
    Locale locale = Locale(langMode);
    Get.updateLocale(locale);
    _setUsedLanguage(langMode);
  }
}
