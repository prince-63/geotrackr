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

  static double screenPaddingLeft(BuildContext context) {
    return MediaQuery.of(context).padding.left;
  }

  static double screenPaddingRight(BuildContext context) {
    return MediaQuery.of(context).padding.right;
  }

  static double screenPaddingHorizontal(BuildContext context) {
    return MediaQuery.of(context).padding.left +
        MediaQuery.of(context).padding.right;
  }

  static double screenPaddingVertical(BuildContext context) {
    return MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
  }

  static double screenPadding(BuildContext context) {
    return MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom +
        MediaQuery.of(context).padding.left +
        MediaQuery.of(context).padding.right;
  }

  static double screenSafeAreaHeight(BuildContext context) {
    return MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
  }

  static double screenSafeAreaWidth(BuildContext context) {
    return MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
  }

  static double screenSafeAreaHorizontal(BuildContext context) {
    return MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
  }

  static double screenSafeAreaVertical(BuildContext context) {
    return MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
  }

  static double screenSafeArea(BuildContext context) {
    return MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom +
        MediaQuery.of(context).padding.left +
        MediaQuery.of(context).padding.right;
  }

  static double marginHorizontal(BuildContext context, double margin) {
    return MediaQuery.of(context).size.width * margin;
  }

  static double marginVertical(BuildContext context, double margin) {
    return MediaQuery.of(context).size.height * margin;
  }

  static double margin(BuildContext context, double margin) {
    return MediaQuery.of(context).size.width * margin +
        MediaQuery.of(context).size.height * margin;
  }
}
