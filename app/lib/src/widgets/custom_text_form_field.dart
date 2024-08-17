import 'package:flutter/material.dart';
import 'package:idcard/src/utils/custom_color.dart';
import 'package:idcard/src/utils/custom_media_query.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String errorMessage;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.errorMessage = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CustomMediaQuery.screenWidth(context),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          _buildHintText(),
          const SizedBox(height: 6.0),
          _buildTextFieldContainer(context),
        ],
      ),
    );
  }

  Widget _buildHintText() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 4.0),
      child: Text(
        hintText,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black.withOpacity(0.75),
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildTextFieldContainer(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: _buildTextFormField(),
    );
  }

  Widget _buildTextFormField() {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: CustomColor.borderColor.withOpacity(0.9),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: CustomColor.primaryValue.withOpacity(0.5),
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
    );
  }
}
