import 'package:flutter/material.dart';
import 'package:geotrackr/utils/custom_color.dart';

class DataDisplay extends StatelessWidget {
  final String data;
  final String label;
  final Color? textColor;
  final Color? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final IconData? icon;

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
