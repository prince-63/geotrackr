import 'package:flutter/material.dart';

class ForgotPasswordVerificationImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/forgotpassword.png', // Add your image asset
            width: 225,
            height: 225,
          )
        ],
      ),
    );
  }
}