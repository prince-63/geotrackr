import 'package:flutter/material.dart';

class VerificationCodeInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String errorMessage;

  VerificationCodeInput({
    required this.controller,
    required this.hintText,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      child: Center(
        child: TextFormField(
          controller: controller,
          maxLength: 6,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.9),
              ),
            ),
            counterText: '',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return errorMessage;
            } else if (value.length != 6) {
              return 'Code must be 6 digits';
            }
            return null;
          },
        ),
      ),
    );
  }
}
