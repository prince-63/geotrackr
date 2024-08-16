import 'package:flutter/material.dart';

class WelcomeImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/welcome.png', // Path to your PNG file
            width: 225,
            height: 225,
          ),
          SizedBox(height: 20),
          Text(
            'Create Your Perfect Identity Card',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
