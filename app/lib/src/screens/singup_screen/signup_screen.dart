import 'package:app/src/screens/singup_screen/build_back_button.dart';
import 'package:app/src/screens/singup_screen/signup_form.dart';
import 'package:app/src/screens/singup_screen/signup_handler.dart';
import 'package:app/src/screens/singup_screen/signup_header.dart';
import 'package:app/src/utils/share_preferences.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SharePreferences.containsKey('token').then((value) {
      if (value) {
        Navigator.pushNamed(context, '/home');
      }
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      SignupHandler.signup(username, email, password, context);
    }
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
              SignupHeader(),
              SignupForm(
                formKey: _formKey,
                usernameController: _usernameController,
                emailController: _emailController,
                passwordController: _passwordController,
                onSignup: _signup,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
