import 'package:timeago/timeago.dart' as timeago;

class DatetimeFormatter {
  static String timeAgo(DateTime dateTime) {
    var dateTimeAgo = timeago.format(dateTime, locale: "en_short");

    return dateTimeAgo;
  }
}
