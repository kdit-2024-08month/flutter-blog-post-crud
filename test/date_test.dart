import 'package:intl/intl.dart';

void main() {
  String createdAt = "2024-10-11 09:17:31";
  DateTime dt = DateTime.parse(createdAt);
  dt = dt.add(Duration(days: 1));
  String formatDt = DateFormat("yyyy.MM.dd").format(dt);
  print(formatDt);
}
