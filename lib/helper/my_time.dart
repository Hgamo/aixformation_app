import 'package:intl/intl.dart';

class MyTime {
  static String dateToText(DateTime date) {
    if (date.isBefore(DateTime.now().subtract(Duration(days: 30)))) {
      return DateFormat('dd.MM.yyyy').format(date);
    }
    if (date.isBefore(DateTime.now().subtract(Duration(hours: 24)))) {
      return 'vor ${DateTime.now().difference(date).inDays} Tagen';
    }

    return 'vor ${DateTime.now().difference(date).inHours} Stunden';
  }
}
