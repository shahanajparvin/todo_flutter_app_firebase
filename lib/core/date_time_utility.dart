
import 'package:intl/intl.dart';
import 'package:todo_app/core/base/app_settings.dart';
import 'package:todo_app/core/di/injector.dart';
import 'package:todo_app/domain/entities/language.dart';

class DateTimeUtility{

  static Future<String> getCurrentDate() async {
    AppSettings appSettings = injector();
    Language selectedLanguage = appSettings.getSelectedLanguage();
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('EEEE, dd MMMM', selectedLanguage.languageCode);
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static String stringConvertToDateLocalization({required String dateString, String? parseCode,String? lanCode}){
    AppSettings appSettings = injector();
    Language selectedLanguage = appSettings.getSelectedLanguage();
    DateTime parsedDate = DateFormat('MM/dd/yyyy', parseCode ?? selectedLanguage.languageCode ).parse(dateString);
    String formattedString = DateFormat('MM/dd/yyyy',lanCode ?? selectedLanguage.languageCode).format(parsedDate);
    print(formattedString); // Output: 12/12/2024
    return formattedString;

  }

  static String stringConvertToATimeLocalization({required String timeString, String? parseCode,String? lanCode}){
    AppSettings appSettings = injector();
    Language selectedLanguage = appSettings.getSelectedLanguage();
    DateTime parsedTime = DateFormat('h:mm a',parseCode ?? selectedLanguage.languageCode ).parse(timeString);
    String formattedTimeString = DateFormat('h:mm a',lanCode ?? selectedLanguage.languageCode).format(parsedTime);
    print(formattedTimeString); // Output: 10:12 PM
    return formattedTimeString;
  }
}