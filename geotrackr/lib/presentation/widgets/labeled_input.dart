import 'package:flutter/material.dart';

class LabeledInput extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const LabeledInput({
    super.key,
    required this.label,
    required this.controller,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final labelColor = isDarkMode ? Colors.white : Colors.black;
    final hintColor = isDarkMode ? Colors.white70 : Colors.black54;
    final errorColor = isDarkMode ? Colors.redAccent : Colors.red;
    final focusedBorderColor = isDarkMode ? Colors.white : Colors.black;
    final errorBorderColor = isDarkMode ? Colors.redAccent : Colors.red;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: labelColor,
          fontSize: 16.0,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorBorderColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorBorderColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorStyle: TextStyle(color: errorColor),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      validator: validator,
    );
  }
}
