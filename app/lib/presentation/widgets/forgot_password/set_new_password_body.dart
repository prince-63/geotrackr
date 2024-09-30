import 'package:flutter/material.dart';
import 'package:geotrackr/presentation/widgets/default_app_bar.dart';
import 'package:geotrackr/presentation/widgets/forgot_password/set_new_password_form.dart';

class SetNewPasswordBody extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  SetNewPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
          title: 'New Password',
          onBackButtonPressed: () {
            Navigator.pop(context);
          }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 140),
                Image.asset(
                  'assets/images/set_new_password.webp',
                  height: 270,
                ),
                const SizedBox(height: 30),
                SetNewPasswordForm(
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
