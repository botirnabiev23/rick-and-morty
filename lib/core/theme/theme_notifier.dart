import 'package:flutter/material.dart';
import 'package:rick_and_morty/db/app_database.dart';

class ThemeNotifier extends ChangeNotifier {
  final AppDatabase db;
  ThemeMode _themeMode;

  ThemeNotifier(this._themeMode, this.db);

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() async {
    _themeMode =
    _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    await db.saveTheme(_themeMode == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners();
  }
}


