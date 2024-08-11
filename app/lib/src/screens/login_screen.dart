import 'package:app/api/api_service.dart';
import 'package:app/src/utils/custom_color.dart';
import 'package:app/src/utils/custom_media_query.dart';
import 'package:app/src/widgets/custom_button.dart';
import 'package:app/src/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      
      // ignore: avoid_print
      print('Email: $email, Password: $password');

      try {
        final response = await ApiService.login(email, password);
        if (response['status'] == 'success') {
          Navigator.pushNamed(context, '/home');
        } else {
          // ignore: avoid_print
          print('Login Failed: ${response['message']}');
        }
      } catch (e) {
        // ignore: avoid_print
        print("Login Failed: $e");
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
                height: CustomMediaQuery.screenHeight(context) * 0.3,
                width: CustomMediaQuery.screenWidth(context),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Log in with your email and password that you used for sign up.',
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
                          controller: _emailController, hintText: 'Email'),
                      CustomTextFormField(
                          controller: _passwordController,
                          hintText: 'Password'),
                      const SizedBox(height: 20.0),
                      CustomButton(
                        onPressed: _login,
                        text: 'Log in',
                        color: CustomColor.primaryValue,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 80.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: CustomMediaQuery.screenWidth(context) * 0.78,
                      alignment: Alignment.center,
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                'Don’t have an account? you can open account by ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.75),
                              fontSize: 14.0,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'sign up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.70),
                                ),
                              ),
                              TextSpan(
                                text: '.',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.85),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    CustomButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      text: 'Sign up',
                      color: CustomColor.primaryLightValue,
                    ),
                  ],
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
