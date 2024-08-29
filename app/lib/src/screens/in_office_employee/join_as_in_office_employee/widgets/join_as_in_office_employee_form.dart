import 'package:flutter/material.dart';
import 'package:idcard/src/utils/custom_color.dart';
import 'package:idcard/src/widgets/custom_button.dart';
import 'package:idcard/src/widgets/custom_text_form_field.dart';

class JoinAsInOfficeEmployeeForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController textController;
  final TextEditingController passwordController;
  final VoidCallback onJoin;

  const JoinAsInOfficeEmployeeForm({
    Key? key,
    required this.formKey,
    required this.textController,
    required this.passwordController,
    required this.onJoin,
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
            CustomButton(
              onPressed: onJoin,
              text: 'Join Now',
              color: CustomColor.primaryValue,
            ),
          ],
        ),
      ),
    );
  }
}
