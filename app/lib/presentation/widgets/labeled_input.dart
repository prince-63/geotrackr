import 'package:flutter/material.dart';

/// A custom labeled input widget that includes a label, hint text, and various customization options.
class LabeledInput extends StatelessWidget {
  final String label; // The label text for the input field.
  final String hintText; // The hint text for the input field.
  final TextEditingController controller; // The controller for the input field.
  final TextInputType keyboardType; // The keyboard type for the input field.
  final bool obscureText; // Whether the input text should be obscured.
  final Widget? prefixIcon; // The prefix icon for the input field.
  final Widget? suffixIcon; // The suffix icon for the input field.
  final String? Function(String?)?
      validator; // The validator function for the input field.

  /// Constructor for [LabeledInput].
  /// It initializes the class with the given parameters.
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
