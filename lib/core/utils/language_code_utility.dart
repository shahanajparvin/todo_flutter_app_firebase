

import 'package:todo_app/core/base/app_settings.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/domain/entities/language.dart';

class LangUtility{

  static String getLanCode(){
    AppSettings appSettings = injector();
    Language selectedLanguage = appSettings.getSelectedLanguage();
    return selectedLanguage.languageCode;
  }


}