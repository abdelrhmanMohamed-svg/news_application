import 'package:intl/intl.dart';

String getFormattedDate(String? date) {
  final parsedDate = DateTime.parse(date ?? DateTime.now().toString());
  final fromattedDate = DateFormat.yMMMd().format(parsedDate);
  return fromattedDate;
}
