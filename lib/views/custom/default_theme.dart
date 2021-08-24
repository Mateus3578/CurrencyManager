import 'package:flutter/material.dart';
import 'package:currency_manager/controllers/theme_provider.dart';

ThemeData getDefaultTheme(ThemeProvider theme) {
  return ThemeData(
    // Cores principais
    primaryColor: theme.primaryColor,
    accentColor: theme.alterColor,
    highlightColor: theme.alterColor,
    hoverColor: theme.alterColor,
    // Cores de fundo
    backgroundColor: theme.backgroundColor,
    scaffoldBackgroundColor: theme.backgroundColor,
    canvasColor: theme.backgroundColor,
    // Cores do texto
    hintColor: theme.textColor.withAlpha(150),
    inputDecorationTheme: InputDecorationTheme(
      counterStyle: TextStyle(color: theme.textColor),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: theme.alterColor, width: 1),
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: theme.textColor),
      bodyText2: TextStyle(color: theme.textColor),
      headline1: TextStyle(color: theme.textColor),
      headline2: TextStyle(color: theme.textColor),
      headline3: TextStyle(color: theme.textColor),
      headline4: TextStyle(color: theme.textColor),
      headline5: TextStyle(color: theme.textColor),
      headline6: TextStyle(color: theme.textColor),
      subtitle1: TextStyle(color: theme.textColor),
      subtitle2: TextStyle(color: theme.textColor),
    ),
    // Cores de pop-ups
    dialogTheme: DialogTheme(
      backgroundColor: theme.backgroundColor,
      titleTextStyle: TextStyle(color: theme.textColor),
      contentTextStyle: TextStyle(color: theme.textColor),
    ),
    colorScheme: ColorScheme.light(
      primary: theme.primaryColor,
      onPrimary: theme.textColor,
      onSurface: theme.textColor,
      secondary: theme.alterColor,
    ),
    // Cores de outros itens
    scrollbarTheme: ScrollbarThemeData(
      trackColor: MaterialStateProperty.all(theme.backgroundColor),
      thumbColor: MaterialStateProperty.all(theme.alterColor),
    ),
  );
}
