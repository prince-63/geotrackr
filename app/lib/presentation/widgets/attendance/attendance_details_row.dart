import 'package:flutter/material.dart';

/// The [AttendanceDetailRow] widget is a stateless widget that displays a label and a value in a row.
/// It is used to show details of attendance records.
class AttendanceDetailRow extends StatelessWidget {
  final String label; // The label to display.
  final String value; // The value to display.
  final Color textColor; // The color of the text.

  /// Constructor for [AttendanceDetailRow].
  /// It initializes the class with the given label, value, and text color.
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
