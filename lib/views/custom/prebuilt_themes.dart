import 'package:flutter/material.dart';

class PreBuiltThemeModel {
  final Color primary;
  final Color alter;
  final Color icon;
  final Color text;
  final Color background;
  final bool isDarkMode;

  /// Model para criar um tema
  PreBuiltThemeModel({
    required this.primary,
    required this.alter,
    required this.icon,
    required this.text,
    required this.background,
    required this.isDarkMode,
  });
}

/// Temas pré construidos.
class PrebuiltThemes {
  static PreBuiltThemeModel defaultTheme = PreBuiltThemeModel(
    primary: Color(0xFFFFC107),
    alter: Color(0xFFFF9800),
    icon: Color(0xFF000000),
    text: Color(0xFFFFFFFF),
    background: Color(0xFF212121),
    isDarkMode: true,
  );

  static PreBuiltThemeModel defaultThemeReverse = PreBuiltThemeModel(
    primary: Color(0xFFFFC107),
    alter: Color(0xFFFF9800),
    icon: Color(0xFF000000),
    text: Color(0xFF000000),
    background: Color(0xFFF8F8F8),
    isDarkMode: false,
  );

  static PreBuiltThemeModel magicGrey = PreBuiltThemeModel(
    primary: Color(0xFFD6ED17),
    alter: Color(0xFF606060),
    icon: Color(0xFF000000),
    text: Color(0xFFFFFFFF),
    background: Color(0xFF212121),
    isDarkMode: true,
  );

  static PreBuiltThemeModel magicGreyReverse = PreBuiltThemeModel(
    primary: Color(0xFFD6ED17),
    alter: Color(0xFF606060),
    icon: Color(0xFF000000),
    text: Color(0xFF000000),
    background: Color(0xFFF8F8F8),
    isDarkMode: false,
  );

  static PreBuiltThemeModel purple = PreBuiltThemeModel(
    primary: Color(0xFF766AFF),
    alter: Color(0xFF84B1FF),
    icon: Color(0xFF000000),
    text: Color(0xFFFFFFFF),
    background: Color(0xFF212121),
    isDarkMode: true,
  );

  static PreBuiltThemeModel purpleReverse = PreBuiltThemeModel(
    primary: Color(0xFF84B1FF),
    alter: Color(0xFF766AFF),
    icon: Color(0xFF000000),
    text: Color(0xFF000000),
    background: Color(0xFFF8F8F8),
    isDarkMode: false,
  );

  static PreBuiltThemeModel lilac = PreBuiltThemeModel(
    primary: Color(0xFFEADDFF),
    alter: Color(0xFFB599FF),
    icon: Color(0xFF000000),
    text: Color(0xFFFFFFFF),
    background: Color(0xFF212121),
    isDarkMode: true,
  );

  static PreBuiltThemeModel lilacReverse = PreBuiltThemeModel(
    primary: Color(0xFFEADDFF),
    alter: Color(0xFFB599FF),
    icon: Color(0xFF000000),
    text: Color(0xFF000000),
    background: Color(0xFFF8F8F8),
    isDarkMode: false,
  );

  static PreBuiltThemeModel blackWhite = PreBuiltThemeModel(
    primary: Color(0xFF000000),
    alter: Color(0xFF000000),
    icon: Color(0xFFFFFFFF),
    text: Color(0xFFFFFFFF),
    background: Color(0xFF212121),
    isDarkMode: true,
  );

  static PreBuiltThemeModel blackWhiteReverse = PreBuiltThemeModel(
    primary: Color(0xFFEFEFEF),
    alter: Color(0xFFDFDFDF),
    icon: Color(0xFF000000),
    text: Color(0xFF000000),
    background: Color(0xFFF8F8F8),
    isDarkMode: false,
  );

  static PreBuiltThemeModel materialBlue = PreBuiltThemeModel(
    primary: Color(0xFF00b4d8),
    alter: Color(0xFF023e8a),
    icon: Color(0xFFFFFFFF),
    text: Color(0xFFFFFFFF),
    background: Color(0xFF212121),
    isDarkMode: true,
  );

  static PreBuiltThemeModel materialBlueReverse = PreBuiltThemeModel(
    primary: Color(0xFF00b4d8),
    alter: Color(0xFF023e8a),
    icon: Color(0xFF000000),
    text: Color(0xFF000000),
    background: Color(0xFFF8F8F8),
    isDarkMode: false,
  );

  static PreBuiltThemeModel corDeVestido = PreBuiltThemeModel(
    primary: Color(0xFFCDB599),
    alter: Color(0xFF42EADD),
    icon: Color(0xFFFFFFFF),
    text: Color(0xFFFFFFFF),
    background: Color(0xFF212121),
    isDarkMode: true,
  );

  static PreBuiltThemeModel corDeVestidoReverse = PreBuiltThemeModel(
    primary: Color(0xFF42EADD),
    alter: Color(0xFFCDB599),
    icon: Color(0xFF000000),
    text: Color(0xFF000000),
    background: Color(0xFFF8F8F8),
    isDarkMode: false,
  );

  static PreBuiltThemeModel pastelPink = PreBuiltThemeModel(
    primary: Color(0xFFF8C7DB),
    alter: Color(0xFFF79AD3),
    icon: Color(0xFFB86FC9),
    text: Color(0xFF000000),
    background: Color(0xFF212121),
    isDarkMode: true,
  );

  static PreBuiltThemeModel pastelPinkReverse = PreBuiltThemeModel(
    primary: Color(0xFFF7C7DB),
    alter: Color(0xFFF79AD3),
    icon: Color(0xFFC86FC9),
    text: Color(0xFF000000),
    background: Color(0xFFE9ECEF),
    isDarkMode: false,
  );

  static PreBuiltThemeModel islandGreen = PreBuiltThemeModel(
    primary: Color(0xFF2BAE66),
    alter: Color(0xFFFCF6F5),
    text: Color(0xFFFFFFFF),
    icon: Color(0xFF000000),
    background: Color(0xFF212121),
    isDarkMode: true,
  );

  static PreBuiltThemeModel islandGreenReverse = PreBuiltThemeModel(
    primary: Color(0xFF2BAE66),
    alter: Color(0xFFFCF6F5),
    text: Color(0xFF000000),
    icon: Color(0xFF000000),
    background: Color(0xFFFCF6F5),
    isDarkMode: false,
  );

  static PreBuiltThemeModel tomato = PreBuiltThemeModel(
    primary: Color(0xFFE94B3C),
    alter: Color(0xFFE94B3C),
    text: Color(0xFFFFFFFF),
    icon: Color(0xFF000000),
    background: Color(0xFF212121),
    isDarkMode: true,
  );

  static PreBuiltThemeModel tomatoGreenReverse = PreBuiltThemeModel(
    primary: Color(0xFFE94B3C),
    alter: Color(0xFFE94B3C),
    text: Color(0xFF000000),
    icon: Color(0xFF000000),
    background: Color(0xFFFCF6F5),
    isDarkMode: false,
  );
}
