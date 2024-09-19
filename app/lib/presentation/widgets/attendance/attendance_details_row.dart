import 'package:flutter/material.dart';

class AttendanceDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color textColor;

  const AttendanceDetailRow({
    super.key,
    required this.label,
    required this.value,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            color: textColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
            color: textColor,
          ),
        ),
      ],
    );
  }
}