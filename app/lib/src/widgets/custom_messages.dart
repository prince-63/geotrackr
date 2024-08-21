import 'package:flutter/material.dart';

class CustomMessages {
  static void showBeautifulMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 27, 154, 244),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
