import 'package:flutter/material.dart';

class CustomBottomNavIcon extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final EdgeInsetsGeometry padding;

  const CustomBottomNavIcon({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Icon(icon)
    );
  }
}
