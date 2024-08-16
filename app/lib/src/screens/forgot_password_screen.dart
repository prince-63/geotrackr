import 'package:flutter/material.dart';
import 'package:app/src/widgets/custom_button.dart';
import 'package:app/src/utils/custom_color.dart';
import 'package:app/src/utils/custom_media_query.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  String _errorMessage = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _forgotPassword() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = 'hello';
      });
      final text = _controller.text;
      // Add your verification logic here
      print('Input: $text');
    } else {
      setState(() {
        _errorMessage = 'Please enter your email or username';
      });
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
              _buildBackButton(),
              _buildHeader(),
              const SizedBox(height: 20.0),
              _buildForgotPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Row(
      children: [
        BackButton(color: Colors.black.withOpacity(0.7)),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      height: CustomMediaQuery.screenHeight(context) * 0.25,
      width: CustomMediaQuery.screenWidth(context),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Forgot Password',
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Enter your email or username to reset your password.',
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

  Widget _buildForgotPasswordForm() {
    return Container(
      padding: const EdgeInsets.all(22.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Email or Username',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email or username';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            if (_errorMessage.isNotEmpty)
              Row(
                children: [
                  Icon(Icons.error, color: Colors.red),
                  const SizedBox(width: 5.0),
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            const SizedBox(height: 10.0),
            CustomButton(
              onPressed: _forgotPassword,
              text: 'Verify',
              color: CustomColor.primaryValue,
            ),
          ],
        ),
      ),
    );
  }
}