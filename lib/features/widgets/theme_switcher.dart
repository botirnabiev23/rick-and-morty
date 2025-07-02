import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/core/theme/theme_notifier.dart';

class ThemeSwitcher extends StatelessWidget {
  final Widget child;

  const ThemeSwitcher({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => context.read<ThemeNotifier>().toggleTheme(),
      child: child,
    );
  }
}
