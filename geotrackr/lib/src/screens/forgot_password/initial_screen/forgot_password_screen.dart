import 'package:idcard/src/screens/forgot_password/initial_screen/widgets/forgot_password_form.dart';
import 'package:idcard/src/screens/forgot_password/initial_screen/widgets/forgot_password_header.dart';
import 'package:flutter/material.dart';
import 'package:idcard/src/widgets/back_button.dart';
import 'package:idcard/src/screens/forgot_password/verification_screen/widgets/forgot_password_verification_image.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              BuildBackButton(),
              const SizedBox(height: 60.0),
              ForgotPasswordVerificationImage(),
              ForgotPasswordHeader(),
              const SizedBox(height: 20.0),
              ForgotPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}
