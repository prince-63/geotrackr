import 'package:app/src/screens/welcome_screen/welcome_footer.dart';
import 'package:app/src/screens/welcome_screen/welcome_image.dart';
import 'package:app/src/utils/share_preferences.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    SharePreferences.containsKey('token').then((value) {
      if (value) {
        Navigator.pushNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Add 20 pixels of padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WelcomeImage(),
              WelcomeFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
