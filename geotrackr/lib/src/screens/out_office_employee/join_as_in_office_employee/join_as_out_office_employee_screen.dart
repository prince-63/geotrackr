import 'package:idcard/src/screens/out_office_employee/join_as_in_office_employee/widgets/join_as_out_office_employee_form.dart';
import 'package:idcard/src/screens/out_office_employee/join_as_in_office_employee/widgets/join_as_out_office_employee_header.dart';
import 'package:idcard/src/utils/share_preferences.dart';
import 'package:flutter/material.dart';

class JoinAsOutOfficeEmployeeScreen extends StatefulWidget {
  const JoinAsOutOfficeEmployeeScreen({super.key});

  @override
  _JoinAsOutOfficeEmployeeScreenState createState() =>
      _JoinAsOutOfficeEmployeeScreenState();
}

class _JoinAsOutOfficeEmployeeScreenState
    extends State<JoinAsOutOfficeEmployeeScreen> {
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

  void _joinAsOutOfficeEmployee() async {
    if (_formKey.currentState!.validate()) {
      final email = _textController.text;
      final password = _passwordController.text;
      // Call API to join as out office employee
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const JoinAsOutOfficeEmployeeHeader(),
              JoinAsOutOfficeEmployeeForm(
                formKey: _formKey,
                textController: _textController,
                passwordController: _passwordController,
                onJoin: _joinAsOutOfficeEmployee,
              ),
              const SizedBox(height: 70.0),
            ],
          ),
        ),
      ),
    );
  }
}
