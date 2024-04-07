import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;
  final String? currentValue;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final String hintText;
  final String labelText;

  const MyTextFormField(
      {super.key,
      required this.onChanged,
      required this.validator,
      required this.currentValue,
      required this.nextFocusNode,
      required this.focusNode,
      required this.hintText,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onFieldSubmitted: (_) => nextFocusNode?.requestFocus(),
      initialValue: currentValue,
      onChanged: onChanged,
      style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        hintText: hintText,
        labelText: labelText,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}
