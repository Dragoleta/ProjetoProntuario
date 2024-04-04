import 'package:flutter/material.dart';
import 'package:prontuario_flutter/config/themes/input_decorator.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color.fromRGBO(222, 217, 226, 1),
    primary: Color.fromRGBO(29, 120, 116, 1),
    secondary: Color.fromRGBO(7, 30, 34, 1),
    tertiary: Color.fromRGBO(222, 217, 226, 1),
  ),
);
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  inputDecorationTheme: MyInputTheme().theme(),
  colorScheme: const ColorScheme.dark(
    background: Color.fromRGBO(222, 217, 226, 1),
    primary: Color.fromRGBO(29, 120, 116, 1),
    secondary: Color.fromRGBO(7, 30, 34, 1),
    tertiary: Color.fromRGBO(222, 217, 226, 1),
    error: Color.fromRGBO(178, 110, 99, 1),
  ),
);
