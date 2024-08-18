import 'package:flutter/material.dart';
import 'package:idcard/src/screens/forgot_password/set_new_password/widgets/set_new_password_form.dart';
import 'package:idcard/src/screens/forgot_password/set_new_password/widgets/set_new_password_header.dart';
import 'package:idcard/src/screens/forgot_password/set_new_password/widgets/set_new_password_image.dart';
import 'package:idcard/src/widgets/back_button.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({Key? key}) : super(key: key);

  @override
  _SetNewPasswordScreenState createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // SharePreferences.containsKey('token').then((value) {
    //   if (value) {
    //     Navigator.pushNamed(context, '/home');
    //   }
    // });
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
              const SizedBox(height: 50.0),
              SetNewPasswordImage(),
              SetNewPasswordHeader(),
              SetNewPasswordForm(
                context: context,
                passwordController: _passwordController,
                PasswordHintText: 'Password',
                confirmPasswordController: _confirmPasswordController,
                confirmPasswordHintText: 'Confirm password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
