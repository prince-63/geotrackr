import 'package:flutter/material.dart';
import 'package:geotrackr/presentation/widgets/custom_button.dart';

/// The [CheckBox] widget is a stateless widget that represents a custom checkbox with additional information.
/// It displays a title, date, status, and a button if the checkbox is not checked.
class CheckBox extends StatelessWidget {
  final BuildContext context;
  final String title;
  final bool isChecked;
  final VoidCallback onPressed;
  final String date;
  final String status;
  final Color backgroundColor;
  final Color textColor;

  /// Constructor for [CheckBox].
  /// It initializes the class with the given parameters.
  const CheckBox({
    super.key,
    required this.context,
    required this.title,
    required this.isChecked,
    required this.onPressed,
    required this.date,
    required this.status,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const Spacer(),
              Icon(
                isChecked ? Icons.check_circle : Icons.error,
                color: isChecked ? Colors.green : Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            'Date: $date',
            style: TextStyle(fontSize: 16.0, color: textColor),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Status: $status',
            style: TextStyle(fontSize: 16.0, color: textColor),
          ),
          const SizedBox(height: 14.0),
          isChecked
              ? const SizedBox()
              : SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: title,
                    onPressed: onPressed,
                  ),
                ),
        ],
      ),
    );
  }
}