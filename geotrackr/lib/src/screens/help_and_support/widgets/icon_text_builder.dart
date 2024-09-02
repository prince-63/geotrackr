import 'package:flutter/material.dart';

class iconTextBuilder extends StatelessWidget {
  final Icon icon;
  final String text;

  const iconTextBuilder({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon,
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
