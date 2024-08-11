import 'package:app/src/utils/custom_media_query.dart';
import 'package:flutter/material.dart';
import 'package:app/src/utils/custom_color.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CustomMediaQuery.screenWidth(context),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          Container(
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
          ),
          const SizedBox(height: 6.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: CustomColor.borderColor.withOpacity(0.9),
              ),
            ),
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
