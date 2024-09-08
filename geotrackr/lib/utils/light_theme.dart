import 'package:flutter/material.dart';
import 'package:geotrackr/utils/text_theme.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Lato',
  textTheme: appTextTheme,
  colorScheme: ColorScheme(
    primary: Colors.blue,
    secondary: Colors.amber,
    surface: Colors.grey[200]!,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  useMaterial3: true,
);
