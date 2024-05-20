import 'package:flutter/material.dart';
import 'package:prontuario_flutter/config/themes/input_decorator.dart';

ColorScheme lightColorScheme = const ColorScheme.light(
  background: Color.fromRGBO(215, 213, 215, 1),
  primary: Color.fromRGBO(32, 111, 52, 1),
  secondary: Colors.white,
  tertiary: Color.fromRGBO(7, 30, 34, 1),
  error: Color.fromRGBO(231, 58, 35, 1),
);

ColorScheme darkColorScheme = const ColorScheme.dark(
  background: Color.fromRGBO(8, 33, 32, 1),
  primary: Color.fromRGBO(29, 120, 116, 1),
  secondary: Color.fromRGBO(204, 204, 204, 1),
  tertiary: Color.fromRGBO(1, 1, 20, 1),
  error: Color.fromRGBO(231, 58, 35, 1),
);

ElevatedButtonThemeData lightButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(lightColorScheme.primary)));
ElevatedButtonThemeData darkButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
  backgroundColor: MaterialStatePropertyAll(darkColorScheme.primary),
));

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  inputDecorationTheme: MyInputTheme(lightColorScheme).theme(),
  primaryColor: lightColorScheme.primary,
  colorScheme: lightColorScheme,
  elevatedButtonTheme: lightButtonTheme,
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  inputDecorationTheme: MyInputTheme(darkColorScheme).theme(),
  primaryColor: darkColorScheme.primary,
  colorScheme: darkColorScheme,
  elevatedButtonTheme: darkButtonTheme,
);
