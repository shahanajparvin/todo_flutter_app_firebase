
import 'package:intl/intl.dart';

class DateManager{

  static Future<String> getCurrentDate() async {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('EEEE, dd MMMM', 'ar');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}