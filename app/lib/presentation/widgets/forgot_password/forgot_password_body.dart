import 'package:flutter/material.dart';
import 'package:geotrackr/presentation/widgets/default_app_bar.dart';
import 'package:geotrackr/presentation/widgets/forgot_password/forgot_password_form.dart';
import 'package:geotrackr/utils/custom_color.dart';

/// The [ForgotPasswordForm] widget is a stateless widget that represents the forgot password form.
/// It uses the Bloc pattern to manage the state of the forgot password process.
class ForgotPasswordBody extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? CustomColor.darkBackgroundColor
        : CustomColor.lightBackgroundColor;

    return Scaffold(
      appBar: DefaultAppBar(
          title: 'Forgot Password',
          onBackButtonPressed: () {
            Navigator.pop(context);
          }),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 140),
                Image.asset(
                  'assets/images/forgotpassword.webp',
                  height: 270,
                ),
                const SizedBox(height: 30),
                ForgotPasswordForm(
                  emailController: emailController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
