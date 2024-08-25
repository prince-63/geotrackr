import 'package:idcard/src/services/login/login_service.dart';
import 'package:idcard/src/screens/login/widgets/login_footer.dart';
import 'package:idcard/src/screens/login/widgets/login_form.dart';
import 'package:idcard/src/screens/login/widgets/login_header.dart';
import 'package:idcard/src/utils/share_preferences.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
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
    _textController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final text = _textController.text;
      final password = _passwordController.text;

      LoginService.login(text, password, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const LoginHeader(),
              LoginForm(
                formKey: _formKey,
                textController: _textController,
                passwordController: _passwordController,
                onLogin: _login,
              ),
              const SizedBox(height: 70.0),
              LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}