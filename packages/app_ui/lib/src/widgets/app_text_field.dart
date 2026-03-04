import 'package:flutter/material.dart';

///Custom text field.
class AppTextField extends StatelessWidget {
  ///Creates a custom app-specific text field.
  const AppTextField({
    this.labelText,
    this.controller,
    this.validator,
    this.onChanged,
    super.key,
  });

  ///Optional label for the text field.
  final String? labelText;

  ///Optional controller for the text field's text.
  final TextEditingController? controller;

  ///An optional method that validates an input. See [TextFormField.validator].
  final String? Function(String?)? validator;

  ///Called when the user initiates a change to the TextField's value: when they
  /// have inserted or deleted text or reset the form.
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}
