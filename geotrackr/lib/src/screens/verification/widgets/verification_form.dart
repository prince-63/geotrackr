import 'package:idcard/src/services/user_verification/resend_code_service.dart';
import 'package:idcard/src/services/user_verification/user_verification_service.dart';
import 'package:idcard/src/screens/verification/widgets/resend_code.dart';
import 'package:idcard/src/utils/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:idcard/src/screens/verification/widgets/verification_code_input.dart';
import 'package:idcard/src/widgets/custom_button.dart';

class VerificationForm extends StatefulWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String email;

  VerificationForm({
    required this.controller,
    required this.email,
  });

  @override
  _VerificationFormState createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  Future<void> onResend() async {
    ResendCodeService.resendCode(context);
  }

  Future<void> _verifyCode() async {
    if (widget.formKey.currentState!.validate()) {
      String code = widget.controller.text;

      UserVerificationService.verifyUser(code, context);
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
                const SizedBox(height: 13),
                ResendCode(onResend: onResend),
                const SizedBox(height: 20),
                CustomButton(
                  onPressed: _verifyCode,
                  text: 'Submit',
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
