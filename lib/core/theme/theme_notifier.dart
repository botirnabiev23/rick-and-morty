import 'package:flutter/material.dart';
import 'package:rick_and_morty/db/app_database.dart';

class ThemeNotifier extends ChangeNotifier {
  final AppDatabase db;
  ThemeMode _themeMode;

  ThemeNotifier(this._themeMode, this.db);

  ThemeMode get themeMode => _themeMode;

  Future<void> toggleTheme() async {
    try {
      final newThemeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

      await db.saveTheme(newThemeMode == ThemeMode.dark ? 'dark' : 'light');
      _themeMode = newThemeMode;
      notifyListeners();
    } catch (e) {
      // Log error or handle it appropriately
      debugPrint('Error toggling theme: $e');
      // Optionally rethrow if you want to handle it at a higher level
      // rethrow;
    }
  }
}
