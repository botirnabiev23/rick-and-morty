import 'package:flutter/material.dart';

@immutable
class MyColors extends ThemeExtension<MyColors> {
  final Color cardBackground;
  final Color titleColor;

  const MyColors({
    required this.cardBackground,
    required this.titleColor,
  });

  @override
  MyColors copyWith({Color? cardBackground, Color? titleColor}) {
    return MyColors(
      cardBackground: cardBackground ?? this.cardBackground,
      titleColor: titleColor ?? this.titleColor,
    );
  }

  @override
  MyColors lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) return this;
    return MyColors(
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      titleColor: Color.lerp(titleColor, other.titleColor, t)!,
    );
  }

  static const light = MyColors(
    cardBackground: Colors.white,
    titleColor: Colors.black,
  );

  static const dark = MyColors(
    cardBackground: Color(0xFF1E1E1E),
    titleColor: Colors.white,
  );
}
