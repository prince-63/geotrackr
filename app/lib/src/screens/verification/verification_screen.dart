import 'package:idcard/src/screens/verification/widgets/verification_form.dart';
import 'package:idcard/src/screens/verification/widgets/verification_header.dart';
import 'package:idcard/src/screens/verification/widgets/verification_image.dart';
import 'package:idcard/src/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final controller = TextEditingController();
  late String userEmail = '';

  @override
  void initState() {
    super.initState();

    // Get user email from shared preferences
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      setState(() {
        userEmail = value.getString('email') ?? '';
      });
    });
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
              const SizedBox(height: 60.0),
              VerificationImage(),
              VerificationHeader(userEmail: userEmail),
              VerificationForm(
                controller: controller,
                email: userEmail,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
