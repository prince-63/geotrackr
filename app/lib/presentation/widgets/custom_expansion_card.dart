import 'package:flutter/material.dart';

class CustomExpansionCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData leadingIcon;
  final Color textColor;
  final Color backgroundColor;
  final bool isDarkMode;

  const CustomExpansionCard({
    super.key,
    required this.title,
    required this.content,
    required this.leadingIcon,
    required this.textColor,
    required this.backgroundColor,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      margin: const EdgeInsets.only(top: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      child: ExpansionTile(
        leading: Icon(leadingIcon, color: textColor),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
