import 'package:flutter/material.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xffF1F0F6),
    colorScheme: const ColorScheme.light(secondary: Colors.blue),
    primaryColor: const Color(0xffF1F0F6),
    indicatorColor: const Color(0xffCBDCF8),
    hintColor: const Color(0xffEECED3),
    dividerColor: const Color(0xff9D9AB4),
    focusColor: const Color(0xffA8DAB5),
    disabledColor: Colors.grey,
    iconTheme: const IconThemeData(color: Color(0xff9D9AB4)),
    cardColor: Colors.white,
    brightness: Brightness.light,
    buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: const ColorScheme.light(),
        ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Color(0xff020417)),
      headlineMedium: TextStyle(color: Color(0xff9D9AB4)),
      headlineSmall: TextStyle(color: Color(0xff9D9AB4)),
      titleMedium: TextStyle(
        color: Color(0xff9D9AB4),
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: Color(0xff9D9AB4),
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: Color(0xff9D9AB4)),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      iconTheme: IconThemeData(color: Color(0xff9D9AB4)),
    ),
  );
}
