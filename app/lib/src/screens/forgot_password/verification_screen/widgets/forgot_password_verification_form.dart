import 'package:idcard/src/screens/verification/widgets/verification_code_input.dart';
import 'package:flutter/material.dart';
import 'package:idcard/src/services/forgot_password/forgot_password_service.dart';
import 'package:idcard/src/utils/custom_color.dart';
import 'package:idcard/src/widgets/custom_button.dart';

class ForgotPasswordForm extends StatefulWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String email;

  ForgotPasswordForm({
    required this.controller,
    required this.email,
  });

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  Future<void> _emailVerification() async {
    if (widget.formKey.currentState!.validate()) {
      String code = widget.controller.text;

      await ForgotPasswordService.verifyEmail(context, code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Form(
            key: widget.formKey,
            child: Column(
              children: [
                VerificationCodeInput(
                  controller: widget.controller,
                  hintText: "Enter 6 digit code",
                  errorMessage: "Please enter currect 6 digit code",
                ),
                const SizedBox(height: 20),
                CustomButton(
                  onPressed: _emailVerification,
                  text: 'Reset Password',
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
