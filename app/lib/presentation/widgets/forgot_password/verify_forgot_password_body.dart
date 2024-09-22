import 'package:flutter/material.dart';
import 'package:geotrackr/presentation/widgets/default_app_bar.dart';
import 'package:geotrackr/presentation/widgets/forgot_password/verify_forgot_password_form.dart';

/// The [VerifyForgotPasswordBody] widget is a stateless widget that represents the verify forgot password body of the application.
class VerifyForgotPasswordBody extends StatelessWidget {
  final TextEditingController codeController = TextEditingController();

  VerifyForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
          title: 'Verify Forgot Password',
          onBackButtonPressed: () {
            Navigator.pop(context);
          }),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 140),
            Image.asset(
              'assets/images/verification.webp',
              height: 270,
            ),
            const SizedBox(height: 30),
            VerifyForgotPasswordForm(
              codeController: codeController,
            ),
          ],
        ),
      ),
    );
  }
}
