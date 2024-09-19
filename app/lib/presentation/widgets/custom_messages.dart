import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomMessages {
  static void showBeautifulMessage(BuildContext context, String message) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Flushbar(
      duration: const Duration(seconds: 3),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      messageText: Text(
        message,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      icon: Icon(
        Icons.info_outline,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      leftBarIndicatorColor: Colors.blue[300],
    ).show(context);
  }

  static void showErrorMessage(BuildContext context, String message) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Flushbar(
      duration: const Duration(seconds: 3),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      messageText: Text(
        message,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      icon: Icon(
        Icons.error_outline,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      leftBarIndicatorColor: Colors.red[300],
    ).show(context);
  }
}
