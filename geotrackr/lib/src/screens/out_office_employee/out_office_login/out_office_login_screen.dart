import 'package:idcard/src/screens/out_office_employee/out_office_login/widgets/out_office_login_footer.dart';
import 'package:idcard/src/screens/out_office_employee/out_office_login/widgets/out_office_login_form.dart';
import 'package:idcard/src/screens/out_office_employee/out_office_login/widgets/out_office_login_header.dart';
import 'package:idcard/src/services/login/login_service.dart';
import 'package:flutter/material.dart';

class OutOfficeLoginScreen extends StatefulWidget {
  const OutOfficeLoginScreen({super.key});

  @override
  _OutOfficeLoginScreenState createState() => _OutOfficeLoginScreenState();
}

class _OutOfficeLoginScreenState extends State<OutOfficeLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              const OutOfficeLoginHeader(),
              OutOfficeLoginForm(
                formKey: _formKey,
                textController: _textController,
                passwordController: _passwordController,
                onLogin: _login,
              ),
              const SizedBox(height: 70.0),
              OutOfficeLoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
