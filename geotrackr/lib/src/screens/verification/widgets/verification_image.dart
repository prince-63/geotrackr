import 'package:flutter/material.dart';

class VerificationImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/verification.png',
            width: 225,
            height: 225,
          )
        ],
      ),
    );
  }
}