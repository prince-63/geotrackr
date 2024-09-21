import 'package:flutter/material.dart';

/// A custom button widget with customizable properties.
class CustomButton extends StatelessWidget {
  final String text; // The text to display on the button.
  final VoidCallback
      onPressed; // The callback to execute when the button is pressed.
  final Color? backgroundColor; // The background color of the button.
  final Color? textColor; // The color of the text on the button.
  final double borderRadius; // The border radius of the button.
  final double padding; // The padding inside the button.
  final double elevation; // The elevation of the button.
  final double fontSize; // The font size of the text on the button.
  final FontWeight fontWeight; // The font weight of the text on the button.
  final EdgeInsetsGeometry? margin; // The margin outside the button.

  /// Constructor for [CustomButton].
  /// It initializes the class with the given parameters.
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
