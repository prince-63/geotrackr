import 'package:idcard/src/screens/in_office_employee/join_as_in_office_employee/widgets/join_as_in_office_employee_form.dart';
import 'package:idcard/src/screens/in_office_employee/join_as_in_office_employee/widgets/join_as_in_office_employee_header.dart';
import 'package:idcard/src/services/in_office/in_office_service.dart';
import 'package:idcard/src/utils/share_preferences.dart';
import 'package:flutter/material.dart';

class JoinAsInOfficeEmployeeScreen extends StatefulWidget {
  const JoinAsInOfficeEmployeeScreen({super.key});

  @override
  _JoinAsInOfficeEmployeeScreenState createState() =>
      _JoinAsInOfficeEmployeeScreenState();
}

class _JoinAsInOfficeEmployeeScreenState
    extends State<JoinAsInOfficeEmployeeScreen> {
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

  void _joinAsInOfficeEmployee() async {
    if (_formKey.currentState!.validate()) {
      final email = _textController.text;
      final password = _passwordController.text;

      await InOfficeService.joinAsInOfficeEmployee(context, email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const JoinAsInOfficeEmployeeHeader(),
              JoinAsInOfficeEmployeeForm(
                formKey: _formKey,
                textController: _textController,
                passwordController: _passwordController,
                onJoin: _joinAsInOfficeEmployee,
              ),
              const SizedBox(height: 70.0),
            ],
          ),
        ),
      ),
    );
  }
}
