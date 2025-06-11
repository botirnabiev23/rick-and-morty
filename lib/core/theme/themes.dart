import 'package:flutter/material.dart';
import 'my_colors.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black),
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.black,
    onPrimary: Colors.white,
  ),
  extensions: const [MyColors.light],
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white),
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.white,
    onPrimary: Colors.black,
  ),
  extensions: const [MyColors.dark],
);
