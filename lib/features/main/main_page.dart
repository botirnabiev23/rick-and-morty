import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: _onTap,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedItemColor: const Color(0xff0ABAB5),
          unselectedItemColor: const Color(0xff8B9099).withOpacity(0.7),
          selectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Color(0xff0ABAB5),
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: const Color(0xff8B9099).withOpacity(0.7),
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
                isSelected:
                _selectedIndex == BottomNavigationItem.selected.index,
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
