import 'dart:async';
import 'package:app/src/screens/home_screen/home_screen.dart';
import 'package:app/src/utils/custom_color.dart';
import 'package:app/src/utils/custom_media_query.dart';
import 'package:app/src/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool invalidOtp = false;
  int resendTime = 60;
  late Timer countdownTimer;
  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());
  late String userEmail = '';

  @override
  void initState() {
    super.initState();
    startTimer();

    // Get user email from shared preferences
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      setState(() {
        userEmail = value.getString('user_email') ?? '';
      });
    });
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendTime -= 1;
      });
      if (resendTime < 1) {
        countdownTimer.cancel();
      }
    });
  }

  void stopTimer() {
    if (countdownTimer.isActive) {
      countdownTimer.cancel();
    }
  }

  String strFormatting(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              _buildBackButton(),
              _buildHeader(),
              _buildVerificationForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Row(
      children: [
        BackButton(color: Colors.black.withOpacity(0.7)),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      height: CustomMediaQuery.screenHeight(context) * 0.25,
      width: CustomMediaQuery.screenWidth(context),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Email Verification',
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Enter the 6 digit verification code received.',
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

  Widget _buildVerificationForm() {
    return Container(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: controllers
                .map((controller) => myInputBox(context, controller))
                .toList(),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Haven't received OTP yet?",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 10),
              resendTime == 0
                  ? InkWell(
                      onTap: () {
                        // Resend OTP Code
                        setState(() {
                          invalidOtp = false;
                          resendTime = 60;
                        });
                        startTimer();
                      },
                      child: const Text(
                        'Resend',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
          const SizedBox(height: 10),
          resendTime != 0
              ? Text(
                  'You can resend OTP after ${strFormatting(resendTime)} second(s)',
                  style: const TextStyle(fontSize: 18),
                )
              : const SizedBox(),
          const SizedBox(height: 5),
          Text(
            invalidOtp ? 'Invalid OTP!' : '',
            style: const TextStyle(fontSize: 20, color: Colors.red),
          ),
          const SizedBox(height: 20),
          CustomButton(
            onPressed: () {
              final otp =
                  controllers.map((controller) => controller.text).join();
              if (otp == '198989') {
                // Go to welcome
                stopTimer();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              } else {
                setState(() {
                  invalidOtp = true;
                });
              }
            },
            text: 'Verify',
            color: CustomColor.primaryValue,
          ),
        ],
      ),
    );
  }
}

Widget myInputBox(BuildContext context, TextEditingController controller) {
  return Container(
    height: 70,
    width: 50,
    decoration: BoxDecoration(
      border: Border.all(width: 1),
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    child: TextField(
      controller: controller,
      maxLength: 1,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 42),
      decoration: const InputDecoration(
        counterText: '',
      ),
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
      },
    ),
  );
}
