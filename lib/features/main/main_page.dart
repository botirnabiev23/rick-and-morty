import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/core/theme/my_colors.dart';
import 'package:rick_and_morty/features/main/widgets/bottom_bar_item_widget.dart';

class MainPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({
    super.key,
    required this.navigationShell,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.navigationShell.currentIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MainPage oldWidget) {
    _selectedIndex = widget.navigationShell.currentIndex;
    super.didUpdateWidget(oldWidget);
  }

  void _onTap(int index) {
    widget.navigationShell.goBranch(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Theme(
        data: theme.copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: theme.extension<MyColors>()?.cardBackground,
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: _onTap,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: theme.hintColor,
          selectedLabelStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.primary,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: theme.hintColor,
          ),
          items: [
            BottomNavigationBarItem(
              icon: CustomBottomNavIcon(
                icon: Icons.home,
                isSelected: _selectedIndex == BottomNavigationItem.home.index,
                padding: const EdgeInsets.only(bottom: 6, top: 8),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: CustomBottomNavIcon(
                icon: Icons.star,
                isSelected: _selectedIndex == BottomNavigationItem.selected.index,
                padding: const EdgeInsets.only(bottom: 6, top: 8),
              ),
              label: 'Selected',
            ),
          ],
        ),
      ),
    );
  }
}

enum BottomNavigationItem {
  home,
  selected,
}
