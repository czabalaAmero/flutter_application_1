import 'package:flutter/material.dart';

enum TextFieldType { text, email }

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextFieldType type;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.type,
  });

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (type == TextFieldType.email) {
      final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
      if (!emailRegex.hasMatch(value)) {
        return 'Enter a valid email';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        validator: _validate,
        keyboardType: type == TextFieldType.email ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
