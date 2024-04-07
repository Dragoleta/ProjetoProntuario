import "package:flutter/material.dart";

class MyInputTheme {
  final ColorScheme colorScheme;

  MyInputTheme(this.colorScheme);

  TextStyle _buildTextStyle(Color? color, {double size = 16.0}) {
    return TextStyle(
      color: color,
      fontSize: size,
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: color,
        width: 1.0,
      ),
    );
  }

  InputDecorationTheme theme() => InputDecorationTheme(
        contentPadding: const EdgeInsets.all(16),
        isDense: false,
        filled: true,
        fillColor: colorScheme.secondary,

        floatingLabelBehavior: FloatingLabelBehavior.never,
        constraints: const BoxConstraints(maxWidth: 500),

        // Borders
        errorBorder: _buildBorder(colorScheme.error),
        focusedBorder: _buildBorder(colorScheme.primary),
        focusedErrorBorder: _buildBorder(colorScheme.error),
        enabledBorder: _buildBorder(colorScheme.primary),
        disabledBorder: _buildBorder(Colors.grey),

        // Text styles
        suffixStyle: _buildTextStyle(colorScheme.tertiary),
        counterStyle: _buildTextStyle(colorScheme.error, size: 12),
        floatingLabelStyle: _buildTextStyle(colorScheme.tertiary),

        errorStyle: _buildTextStyle(colorScheme.error, size: 12),
        helperStyle: _buildTextStyle(colorScheme.tertiary, size: 12),
        hintStyle: _buildTextStyle(colorScheme.tertiary),
        labelStyle: _buildTextStyle(colorScheme.tertiary),
        prefixStyle: _buildTextStyle(colorScheme.tertiary),
      );
}
