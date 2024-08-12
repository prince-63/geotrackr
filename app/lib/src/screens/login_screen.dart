import 'package:app/api/auth_api.dart';
import 'package:app/src/utils/custom_color.dart';
import 'package:app/src/utils/custom_media_query.dart';
import 'package:app/src/widgets/custom_button.dart';
import 'package:app/src/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        final response = await AuthApi.login(email, password);
        _handleLoginResponse(response);
      } catch (e) {
        _handleLoginError(e);
      }
    }
  }

  void _handleLoginResponse(Map<String, dynamic> response) {
    if (response['status'] == 'success') {
      _verifyPreferences();
    } else {
      _showErrorMessage('Login Failed: ${response['message']}');
    }
  }

    void _verifyPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token != null) {
      Navigator.pushNamed(context, '/home');
    }
  }

  void _handleLoginError(Object error) {
    _showErrorMessage('Login Failed: $error');
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildLoginForm(),
              const SizedBox(height: 80.0),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.all(22.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
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
              onPressed: _login,
              text: 'Log in',
              color: CustomColor.primaryValue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
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
                  text: 'Don’t have an account? you can open account by ',
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
    );
  }
}