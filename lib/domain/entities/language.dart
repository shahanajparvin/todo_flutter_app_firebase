
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/core_utils.dart';


enum Language {
  english("en", "English"), arabic("ar", "Arabic");

  final String languageCode;
  final String languageName;

  const Language(this.languageCode, this.languageName);

  static Language getLanguageByName(String languageName) {
    switch (languageName) {
      case "Arabic": return Language.arabic;
      default: return Language.english;
    }
  }

  static Language getLanguageByCode(String code) {
    switch (code) {
      case "ar": return Language.arabic;
      default: return Language.english;
    }
  }

  static String getLocalizedLanguageName(BuildContext context, String code) {
    switch (code) {
      case "ar": return context.text.arabic;
      default: return context.text.english;
    }
  }

  List<String> getLanguageNames() {
    return [Language.arabic.languageName, Language.english.languageName];
  }

  get locale {
    return Locale(languageCode, _getCountryCodeForLocale());
  }

  String _getCountryCodeForLocale() {
    switch (languageCode) {
      case 'ar': return 'AR';
      default : return 'US';
    }
  }
}