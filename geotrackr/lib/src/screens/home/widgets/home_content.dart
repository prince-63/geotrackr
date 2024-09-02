import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome to the Home Screen',
          style: TextStyle(
            color: Colors.black.withOpacity(0.9),
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'This is the home screen of the app.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black.withOpacity(0.85),
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
