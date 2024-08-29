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
            Navigator.pushNamed(context, '/join-as-in-office-employee');
          },
          text: 'Join as In-Office Employee',
          color: CustomColor.primaryValue,
        ),
        const SizedBox(height: 20),
        CustomButton(
          onPressed: () {
            Navigator.pushNamed(context, '/join-as-out-of-office-employee');
          },
          text: 'Join as Out-Office Employee',
          color: CustomColor.primaryValue,
        ),
      ],
    );
  }
}
