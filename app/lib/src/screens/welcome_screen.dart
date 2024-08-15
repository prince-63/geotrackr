import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/welcome.svg',  // Path to your SVG file
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text("Welcome to the app!"),
          ],
        ),
      ),
    );
  }
}