import 'package:flutter/material.dart';
import 'package:geotrackr/presentation/widgets/login/login_form.dart';
import 'package:geotrackr/utils/custom_color.dart';

/// LoginPageBody is a stateless widget that represents the body of the login page.
/// It contains the login form.
class LoginPageBody extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? CustomColor.darkBackgroundColor
        : CustomColor.lightBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/logo.png',
                  height: 400,
                ),
                const SizedBox(height: 10),
                LoginForm(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
