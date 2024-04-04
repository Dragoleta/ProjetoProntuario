import "package:flutter/material.dart";

class MyInputTheme {
  TextStyle _buildTextStyle(Color color, {double size = 16.0}) {
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

        floatingLabelBehavior: FloatingLabelBehavior.always,
        constraints: const BoxConstraints(maxWidth: 200),

        // Borders
        errorBorder: _buildBorder(const Color.fromRGBO(178, 110, 99, 1)),
        focusedBorder: _buildBorder(Colors.black),
        focusedErrorBorder: _buildBorder(Colors.red),
        enabledBorder: _buildBorder(Colors.black),
        disabledBorder: _buildBorder(Colors.grey),

        // Text styles

        suffixStyle: _buildTextStyle(Colors.black),
        counterStyle: _buildTextStyle(Colors.grey, size: 12),
        floatingLabelStyle: _buildTextStyle(
          Colors.black,
        ),

        errorStyle: _buildTextStyle(Colors.red, size: 12),
        helperStyle: _buildTextStyle(Colors.black, size: 12),
        hintStyle: _buildTextStyle(Colors.black),
        labelStyle: _buildTextStyle(Colors.black),
        prefixStyle: _buildTextStyle(Colors.black),
      );
}
