import 'package:flutter/material.dart';
import 'package:app/src/utils/custom_color.dart';
import 'package:app/src/widgets/custom_button.dart';
import 'package:app/src/widgets/custom_text_form_field.dart';

class SignupForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSignup;

  const SignupForm({
    Key? key,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.onSignup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: usernameController,
              hintText: 'Username',
              errorMessage: 'Please enter unique username',
            ),
            CustomTextFormField(
              controller: emailController,
              hintText: 'Email',
              errorMessage: 'Please enter valid email',
            ),
            CustomTextFormField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
              errorMessage: 'Please enter valid password',
            ),
            const SizedBox(height: 20.0),
            CustomButton(
              onPressed: onSignup,
              text: 'Sign up',
              color: CustomColor.primaryValue,
            ),
          ],
        ),
      ),
    );
  }
}
