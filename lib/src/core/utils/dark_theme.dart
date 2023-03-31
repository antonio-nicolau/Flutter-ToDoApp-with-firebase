import 'package:flutter/material.dart';

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xff000000),
    colorScheme: const ColorScheme.dark(secondary: Color(0xff2643C4)),
    primaryColor: const Color(0xff000000),
    indicatorColor: const Color(0xff0E1D36),
    hintColor: const Color(0xff280C0B),
    highlightColor: const Color(0xff372901),
    hoverColor: const Color(0xff3A3A3B),
    dividerColor: Colors.white,
    focusColor: const Color(0xff0B2512),
    disabledColor: Colors.grey,
    unselectedWidgetColor: const Color(0xff000000),
    iconTheme: const IconThemeData(color: Colors.white),
    cardColor: const Color(0xFF151515),
    brightness: Brightness.dark,
    buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: const ColorScheme.dark(),
        ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Color(0xff020417)),
      headlineSmall: TextStyle(color: Colors.white),
      titleMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: Color(0xff020417),
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Color(0xff020417),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
