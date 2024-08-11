import 'package:flutter/material.dart';

class CustomMediaQuery {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenPaddingTop(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double screenPaddingBottom(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }
}