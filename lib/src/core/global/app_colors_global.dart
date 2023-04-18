import 'dart:math';
import 'package:flutter/material.dart';

abstract class AppColor {
  static const whiteSnow = Color(0xFFFFFFFF);
  static const background = Color(0xFFF5F5F5);

  static const realBlack = Color(0xFF000000);
  static const blackHardness = Color(0xFF2E2C2B);
  static const blackHardness75 = Color(0xFF626160);
  static const blackHardness50 = Color(0xFF969595);
  static const blackHardness25 = Color(0xFFCBCACA);
  static const blackHardness10 = Color(0xFFEAEAEA);

  static const redAlert = Color(0xFFEC6969);
  static const redAlertBg = Color(0xFFFDF0F0);
  static const energy = Color(0xFFE7662B);
  static const energy75 = Color(0xFFED8C60);
  static const energy50 = Color(0xFFF3B295);
  static const energy25 = Color(0xFFF9D9CA);
  static const energy10 = Color(0xFFFDF0EA);
  static const energy05 = Color(0xFFFEF7F4);

  static const evolutionGradient = [
    Color(0xFFFD6B6A),
    Color(0xFFE7665A),
    Color(0xFFE7662B),
  ];

  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  static int tintValue(int value, double factor) => max(
        0,
        min((value + ((255 - value) * factor)).round(), 255),
      );

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
        tintValue(color.red, factor),
        tintValue(color.green, factor),
        tintValue(color.blue, factor),
        1,
      );

  static int shadeValue(int value, double factor) => max(
        0,
        min(value - (value * factor).round(), 255),
      );

  static Color shadeColor(Color color, double factor) => Color.fromRGBO(
        shadeValue(color.red, factor),
        shadeValue(color.green, factor),
        shadeValue(color.blue, factor),
        1,
      );
}
