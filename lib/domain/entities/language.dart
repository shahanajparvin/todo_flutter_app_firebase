
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/core_utils.dart';


enum Language {
  norway("no", "Norwegian"), english("en", "English"), portuguese("pt", "Portuguese");

  final String languageCode;
  final String languageName;

  const Language(this.languageCode, this.languageName);

  static Language getLanguageByName(String languageName) {
    switch (languageName) {
      case "Norway": return Language.norway;
      case "Portuguese" : return Language.portuguese;
      default: return Language.english;
    }
  }

  static Language getLanguageByCode(String code) {
    switch (code) {
      case "no": return Language.norway;
      case "pt" : return Language.portuguese;
      default: return Language.english;
    }
  }

  static String getLocalizedLanguageName(BuildContext context, String code) {
    switch (code) {
      case "no": return context.text.norwegian;
      case "pt" : return context.text.portuguese;
      default: return context.text.english;
    }
  }

  List<String> getLanguageNames() {
    return [Language.norway.languageName, Language.portuguese.languageName, Language.english.languageName];
  }

  get locale {
    return Locale(languageCode, _getCountryCodeForLocale());
  }

  String _getCountryCodeForLocale() {
    switch (languageCode) {
      case 'no': return 'NO';
      case 'pt': return 'PT';
      default : return 'US';
    }
  }
}