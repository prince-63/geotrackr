import 'package:flutter/material.dart';
import 'package:idcard/src/utils/custom_color.dart';
import 'package:idcard/src/widgets/custom_button.dart';

class WelcomeFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          text: 'Login',
          color: CustomColor.primaryValue,
        ),
        SizedBox(height: 20),
        CustomButton(
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
          text: 'Sign up',
          color: CustomColor.primaryValue,
        ),
      ],
    );
  }
}
