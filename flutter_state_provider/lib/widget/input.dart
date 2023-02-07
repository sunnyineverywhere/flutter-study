import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final String labelText;
  final void Function(String?)? onSaved;

  InputForm({required this.labelText, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      initialValue: '',
      validator: (String? value) {
        if (value!.isEmpty) {
          return '$labelText is requires';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}
