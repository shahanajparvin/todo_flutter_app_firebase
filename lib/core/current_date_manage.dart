
import 'package:intl/intl.dart';
import 'package:todo_app/core/base/app_settings.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/domain/entities/language.dart';

class DateManager{

  static Future<String> getCurrentDate() async {
    AppSettings appSettings = injector();
    Language selectedLanguage = appSettings.getSelectedLanguage();
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('EEEE, dd MMMM', selectedLanguage.languageCode);
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}