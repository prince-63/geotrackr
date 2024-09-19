import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final double padding;
  final double elevation;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry? margin;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 50.0,
    this.padding = 12.0,
    this.elevation = 1.0,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final defaultBackgroundColor = isDarkMode ? Colors.white : Colors.black;
    final defaultTextColor = isDarkMode ? Colors.black : Colors.white;

    return Container(
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? defaultBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.all(padding),
          elevation: elevation,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? defaultTextColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
