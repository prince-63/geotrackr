import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'resend_timer.dart';

class ResendCode extends StatelessWidget {
  final Function onResend;
  final int initialResendTime;

  ResendCode({required this.onResend, this.initialResendTime = 5});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResendTimer(initialResendTime: initialResendTime),
      child: Consumer<ResendTimer>(
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
