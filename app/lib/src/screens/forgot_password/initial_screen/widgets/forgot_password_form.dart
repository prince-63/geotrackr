import 'package:flutter/material.dart';
import 'package:idcard/src/services/forgot_password/forgot_password_service.dart';
import 'package:idcard/src/utils/custom_color.dart';
import 'package:idcard/src/widgets/custom_button.dart';
import 'package:idcard/src/widgets/custom_text_form_field.dart';

class ForgotPasswordForm extends StatefulWidget {
  final TextEditingController controller = TextEditingController();

  @override
  State<ForgotPasswordForm> createState() =>
      _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      final email = widget.controller.text;
      await ForgotPasswordService.sendVerificationEmail(context, email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: widget.controller,
              hintText: "Email",
              errorMessage: "Please enter valid email address.",
            ),
            const SizedBox(height: 10.0),
            CustomButton(
              onPressed: _sendEmail,
              text: "Verify Email",
              color: CustomColor.primaryValue,
            ),
          ],
        ),
      ),
    );
  }
}
