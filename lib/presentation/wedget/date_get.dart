import 'package:intl/intl.dart';

String getCurrentDate() {
  final format = DateFormat('yyyy-MM-dd');
  final now = DateTime.now();
  return format.format(now);
}
