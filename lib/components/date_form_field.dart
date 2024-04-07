import 'package:flutter/material.dart';

class DateFormField extends StatefulWidget {
  final String? currentValue;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String> onChanged;
  final String hintText;
  final String labelText;

  const DateFormField({
    super.key,
    required this.currentValue,
    required this.validator,
    required this.labelText,
    required this.onChanged,
    required this.hintText,
  });

  @override
  State<DateFormField> createState() => _DateFormFieldState();
}

class _DateFormFieldState extends State<DateFormField> {
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: () {
        _selectDate(context);
      },
      controller: _dateController,
      style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
      decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          suffixIcon: const Icon(Icons.calendar_month),
          suffixIconColor: Theme.of(context).colorScheme.primary),
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Future<void> _selectDate(context) async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: (365 * 100))),
      lastDate: DateTime.now(),
    );

    if (datePicked != null) {
      String dateFormated = datePicked.toString().split(" ")[0];
      widget.onChanged(dateFormated);
      _dateController.text = dateFormated;
    }
  }
}
