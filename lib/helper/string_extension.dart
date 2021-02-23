import 'package:intl/intl.dart';

extension StringExtension on String {
  // Called to get a formatted string displaying the day and the date.
  String getLocalDateString() {
    try {
      final localDateTime = DateTime.parse(this).toLocal();
      final date = DateFormat.yMEd().format(localDateTime);

      return date;
    } catch (e) {
      return "";
    }
  }

  // Called to get a formatted string displaying the time.
  String getLocalTimeString() {
    try {
      final localDateTime = DateTime.parse(this).toLocal();
      final time = DateFormat.jm().format(localDateTime);

      return time;
    } catch (e) {
      return "";
    }
  }

  // Called to get a string of the time difference of 'this' and the current time.
  String getTimeDifferenceToNow() {
    try {
      final now = DateTime.now().toLocal();
      final localDateTime = DateTime.parse(this).toLocal();
      final difference = now.difference(localDateTime);
      return difference.inHours.toString() + " hr";
    } catch (e) {
      return "";
    }
  }
}
