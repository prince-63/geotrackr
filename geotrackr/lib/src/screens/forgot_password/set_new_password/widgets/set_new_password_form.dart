import 'package:flutter/material.dart';
import 'package:idcard/src/services/forgot_password/forgot_password_service.dart';
import 'package:idcard/src/utils/custom_color.dart';
import 'package:idcard/src/widgets/custom_button.dart';
import 'package:idcard/src/widgets/custom_text_form_field.dart';

class SetNewPasswordForm extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController;
  final String PasswordHintText;
  final TextEditingController confirmPasswordController;
  final String confirmPasswordHintText;
  final BuildContext context;

  SetNewPasswordForm({
    required this.context,
    required this.passwordController,
    required this.PasswordHintText,
    required this.confirmPasswordController,
    required this.confirmPasswordHintText,
  });

  Future<void> _emailVerification() async {
    if (formKey.currentState!.validate()) {
      String password = passwordController.text;
      String confirmPassword = confirmPasswordController.text;

      if (password == confirmPassword) {
        ForgotPasswordService.setNewPassword(context, password);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password does not match'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: passwordController,
                  hintText: PasswordHintText,
                  obscureText: true,
                  errorMessage: "Please enter your password",
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  hintText: confirmPasswordHintText,
                  obscureText: true,
                  errorMessage: "Please enter confirm your password",
                ),
                const SizedBox(height: 15),
                CustomButton(
                  onPressed: _emailVerification,
                  text: 'set new password',
                  color: CustomColor.primaryValue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
