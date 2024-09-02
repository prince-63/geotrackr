import 'package:flutter/material.dart';

class CustomDisplayTextField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const CustomDisplayTextField({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.black.withOpacity(0.8),
            size: 22.0,
          ),
          const SizedBox(width: 5.0),
          _buildHintText(),
          const SizedBox(width: 16.0),
          Expanded(child: _buildTextFieldContainer(context)),
        ],
      ),
    );
  }

  Widget _buildHintText() {
    return Text(
      label,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.black.withOpacity(0.8),
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextFieldContainer(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: _buildTextFormField(),
    );
  }

  Widget _buildTextFormField() {
    return Text(
      value,
      style: TextStyle(
        color: Colors.black.withOpacity(0.8),
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
