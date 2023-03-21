import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Кастомный цвет
MaterialColor myColor = MaterialColor(0xF9F9F9, color);
Map<int, Color> color = {
  50: const Color.fromRGBO(249, 249, 249, 0.05),
  100: const Color.fromRGBO(249, 249, 249, 0.1),
  200: const Color.fromRGBO(249, 249, 249, 0.2),
  300: const Color.fromRGBO(249, 249, 249, 0.3),
  400: const Color.fromRGBO(249, 249, 249, 0.4),
  500: const Color.fromRGBO(249, 249, 249, 0.5),
  600: const Color.fromRGBO(249, 249, 249, 0.6),
  700: const Color.fromRGBO(249, 249, 249, 0.7),
  800: const Color.fromRGBO(249, 249, 249, 0.8),
  900: const Color.fromRGBO(249, 249, 249, 0.9),
};

// Сколько дней назад вышла новость
String daysAgo(String publicationDate) {
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime nowDate = DateTime.parse(formattedDate);
  DateTime jsonDate = DateTime.parse(publicationDate);
  final inDays = nowDate.difference(jsonDate);
  if (inDays.inDays.toString() == "0") {
    return "today";
  }

  return "${inDays.inDays.toString()} day ago";
}
