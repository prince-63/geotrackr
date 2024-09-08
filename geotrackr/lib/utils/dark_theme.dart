import 'package:flutter/material.dart';
import 'package:geotrackr/utils/text_theme.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'Lato',
  textTheme: appTextTheme,
  colorScheme: ColorScheme(
    primary: Colors.blue,
    secondary: Colors.amber,
    surface: Colors.grey[900]!,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.white,
    onError: Colors.white,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
);
