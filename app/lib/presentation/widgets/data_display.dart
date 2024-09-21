import 'package:flutter/material.dart';
import 'package:geotrackr/utils/custom_color.dart';

/// A widget for displaying labeled data with customizable properties.
class DataDisplay extends StatelessWidget {
  final String data; // The data to display.
  final String label; // The label for the data.
  final Color? textColor; // The color of the text.
  final Color? backgroundColor; // The background color of the container.
  final double? fontSize; // The font size of the text.
  final FontWeight? fontWeight; // The font weight of the text.
  final EdgeInsetsGeometry? padding; // The padding inside the container.
  final EdgeInsetsGeometry? margin; // The margin outside the container.
  final IconData? icon; // The icon to display alongside the text.

  /// Constructor for [DataDisplay].
  /// It initializes the class with the given parameters.
  const DataDisplay({
    super.key,
    required this.label,
    required this.data,
    this.textColor,
    this.backgroundColor,
    this.fontSize,
    this.fontWeight,
    this.padding = const EdgeInsets.all(10.0),
    this.margin = const EdgeInsets.all(0.0),
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final defaultTextColor =
        isDarkMode ? CustomColor.darkTextColor : CustomColor.lightTextColor;
    final defaultBackgroundColor = isDarkMode
        ? CustomColor.darkBackgroundColor
        : CustomColor.lightBackgroundColor;

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? defaultBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor ?? defaultTextColor),
            const SizedBox(width: 10.0),
          ],
          Text(
            '$label: $data',
            style: TextStyle(
              color: textColor ?? defaultTextColor,
              fontSize: fontSize ?? 16.0,
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
