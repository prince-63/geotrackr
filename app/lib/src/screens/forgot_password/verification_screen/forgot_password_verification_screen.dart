import 'package:flutter/material.dart';
import 'package:idcard/src/screens/forgot_password/verification_screen/widgets/forgot_password_verification_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:idcard/src/widgets/back_button.dart'; // Assuming you have a custom back button widget
import 'package:idcard/src/screens/forgot_password/verification_screen/widgets/forgot_password_verification_form.dart'; // Create this file

class ForgotPasswordVerificationScreen extends StatefulWidget {
  const ForgotPasswordVerificationScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordVerificationScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordVerificationScreen> {
  final controller = TextEditingController();
  late String userEmail = '';

  @override
  void initState() {
    super.initState();

    // Get user email from shared preferences
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      setState(() {
        userEmail = value.getString('email') ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              BuildBackButton(),
              const SizedBox(height: 7.0),
              ForgotPasswordVerificationImage(),
              // ForgotPasswordHeader(userEmail: userEmail),
              ForgotPasswordForm(
                controller: controller,
                email: userEmail,
              ),
            ],
          ),
        ),
      ),
    );
  }
}