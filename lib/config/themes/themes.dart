import 'package:flutter/material.dart';
import 'package:prontuario_flutter/config/themes/input_decorator.dart';

ColorScheme lightColorScheme = const ColorScheme.light(
  background: Color.fromRGBO(222, 217, 226, 1),
  primary: Color.fromRGBO(29, 120, 116, 1),
  secondary: Color.fromRGBO(222, 217, 226, 1),
  tertiary: Color.fromRGBO(7, 30, 34, 1),
  error: Color.fromRGBO(178, 110, 99, 1),
);

ColorScheme darkColorScheme = const ColorScheme.dark(
  background: Color.fromRGBO(7, 30, 34, 1),
  primary: Color.fromRGBO(29, 120, 116, 1),
  secondary: Color.fromRGBO(222, 217, 226, 1),
  tertiary: Color.fromRGBO(7, 30, 34, 1),
  error: Color.fromRGBO(178, 110, 99, 1),
);

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  inputDecorationTheme: MyInputTheme(lightColorScheme).theme(),
  primaryColor: const Color.fromRGBO(29, 120, 116, 1),
  colorScheme: lightColorScheme,
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  inputDecorationTheme: MyInputTheme(darkColorScheme).theme(),
  colorScheme: darkColorScheme,
);
