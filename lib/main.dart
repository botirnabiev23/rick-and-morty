import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/core/di/injection.dart';
import 'package:rick_and_morty/core/theme/theme_notifier.dart';
import 'package:rick_and_morty/db/app_database.dart';
import 'package:rick_and_morty/features/widgets/theme_switcher.dart';
import 'core/theme/themes.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await configureDependencies();
    final db = getIt<AppDatabase>();
    final savedTheme = await db.getSavedTheme();

    final initialThemeMode =
        savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;

    runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeNotifier(initialThemeMode, db),
        child: MyApp(database: db, initialThemeMode: initialThemeMode),
      ),
    );
  } catch (e) {
    runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeNotifier(ThemeMode.light, getIt<AppDatabase>()),
        child: MyApp(
          database: getIt<AppDatabase>(),
          initialThemeMode: ThemeMode.light,
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final AppDatabase database;
  final ThemeMode initialThemeMode;

  const MyApp({
    super.key,
    required this.database,
    required this.initialThemeMode,
  });

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();

    return MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeNotifier.themeMode,
      routerConfig: router,
      builder: (context, child) {
        if (child != null) {
          return ThemeSwitcher(child: child);
        }
        return const SizedBox();
      },
    );
  }
}
