import 'package:intl/intl.dart';

extension DateFormatExtension on String {
  String toFormattedDate() {
    try {
      final DateTime date = DateTime.parse(this);
      final DateFormat outputFormat = DateFormat('d MMMM yyyy');
      return outputFormat.format(date).toLowerCase();
    } catch (e) {
      return this;
    }
  }
}
