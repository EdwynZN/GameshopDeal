import 'package:flutter/material.dart';

const lightColor = const MaterialColor(
  0xFFC91B3A,
  <int, Color>{
    50: Color(0xFFF9E4E7),
    100: Color(0xFFEFBBC4),
    200: Color(0xFFE48D9D),
    300: Color(0xFFD95F75),
    400: Color(0xFFD13D58),
    500: Color(0xFFC91B3A),
    600: Color(0xFFC91B3A),
    700: Color(0xFFBC142C),
    800: Color(0xFFB51025),
    900: Color(0xFFA90818),
  },
);
const lightAccentColor = const MaterialAccentColor(
  0xFFffa1a8,
  <int, Color>{
    100: Color(0xFFFFD4D7),
    200: Color(0xFFFFA1A8),
    400: Color(0xFFFF6E79),
    700: Color(0xFFFF5561),
  },
);

class PriceTheme extends ThemeExtension<PriceTheme> {
  final Color discountColor;
  final Color onDiscountColor;
  final Color regularColor;

  const PriceTheme({
    required this.discountColor,
    required this.onDiscountColor,
    required this.regularColor,
  });

  @override
  PriceTheme copyWith({
    Color? discountColor,
    Color? normalPriceColor,
    Color? onDiscountColor,
  }) {
    return PriceTheme(
      discountColor: discountColor ?? this.discountColor,
      regularColor: normalPriceColor ?? this.regularColor,
      onDiscountColor: onDiscountColor ?? this.onDiscountColor,
    );
  }

  @override
  PriceTheme lerp(
    covariant PriceTheme? other,
    double t,
  ) {
    if (other is! PriceTheme) {
      return this;
    }
    return PriceTheme(
      discountColor: Color.lerp(discountColor, other.discountColor, t)!,
      onDiscountColor: Color.lerp(onDiscountColor, other.onDiscountColor, t)!,
      regularColor: Color.lerp(regularColor, other.regularColor, t)!,
    );
  }
}
