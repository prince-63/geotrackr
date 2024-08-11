import 'package:app/api/api_service.dart';
import 'package:app/src/utils/custom_color.dart';
import 'package:app/src/utils/custom_media_query.dart';
import 'package:app/src/widgets/custom_button.dart';
import 'package:app/src/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        final response = await ApiService.signup(name, email, password);
        if (response['status'] == 'created') {
          Navigator.pushNamed(context, '/home');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed: $e')),
        );
      }
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
              Row(
                children: [
                  BackButton(color: Colors.black.withOpacity(0.7)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                height: CustomMediaQuery.screenHeight(context) * 0.25,
                width: CustomMediaQuery.screenWidth(context),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Sign up with your name, email and password that you use.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.85),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(22.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _nameController,
                        hintText: 'Name',
                      ),
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                      CustomTextFormField(
                        controller: _passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 20.0),
                      CustomButton(
                        onPressed: _signup,
                        text: 'Sign up',
                        color: CustomColor.primaryValue,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}