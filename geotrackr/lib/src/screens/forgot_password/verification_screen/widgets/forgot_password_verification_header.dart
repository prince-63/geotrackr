import 'package:idcard/src/utils/custom_media_query.dart';
import 'package:flutter/material.dart';

class ForgotPasswordVerificationHeader extends StatelessWidget {
  final String userEmail;

  const ForgotPasswordVerificationHeader({required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
      height: CustomMediaQuery.screenHeight(context) * 0.15,
      width: CustomMediaQuery.screenWidth(context),
      child: Center(
        child: Column(
          children: [
            Text(
              'Forgot Password Verification',
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.0),
            Text(
              'A verification code has been sent to your provided ${userEmail}',
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
}
