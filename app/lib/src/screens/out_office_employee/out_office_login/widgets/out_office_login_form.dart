import 'package:flutter/material.dart';
import 'package:idcard/src/utils/custom_color.dart';
import 'package:idcard/src/widgets/custom_button.dart';
import 'package:idcard/src/widgets/custom_text_form_field.dart';

class OutOfficeLoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController textController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;

  const OutOfficeLoginForm({
    Key? key,
    required this.formKey,
    required this.textController,
    required this.passwordController,
    required this.onLogin,
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
              controller: textController,
              hintText: 'Email',
              errorMessage: "Please enter correct email",
            ),
            CustomTextFormField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
              errorMessage: "Please enter correct password",
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/forgot-password');
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.75),
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14.0),
            CustomButton(
              onPressed: onLogin,
              text: 'Log in',
              color: CustomColor.primaryValue,
            ),
          ],
        ),
      ),
    );
  }
}
