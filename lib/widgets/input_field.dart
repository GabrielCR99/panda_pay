import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final String hint;
  final bool isObscure;
  final IconData icon;
  final TextEditingController controller;
  final Function(String) onChanged;
  final Stream<String> stream;
  final String labelText;
  final String initialValue;
  final String Function(String) validateText;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final TextCapitalization textCapitalization;

  InputField({
    Key key,
    this.hint,
    this.isObscure,
    this.icon,
    this.controller,
    this.onChanged,
    this.stream,
    this.labelText,
    this.validateText,
    this.inputFormatters,
    this.keyboardType,
    this.suffixIcon,
    this.textCapitalization,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hint,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      obscureText: isObscure,
      validator: validateText,
    );
  }
}
