import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'forgot_password_resend_timer.dart';

class ForgotPasswordResendCode extends StatelessWidget {
  final Function onResend;
  final int initialResendTime;

  ForgotPasswordResendCode(
      {required this.onResend, this.initialResendTime = 60});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ForgotPasswordResendTimer(initialResendTime: initialResendTime),
      child: Consumer<ForgotPasswordResendTimer>(
        builder: (context, timer, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Didn't receive the code?",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.75),
                    fontSize: 14.0,
                  ),
                ),
                timer.canResend
                    ? GestureDetector(
                        onTap: () {
                          timer.resetTimer(initialResendTime);
                          onResend();
                        },
                        child: Text(
                          'Resend',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 7, 105, 203)
                                .withOpacity(0.75),
                            fontSize: 14.0,
                          ),
                        ),
                      )
                    : Text(
                        'Resend in ${timer.resendTime} s',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}