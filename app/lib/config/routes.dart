import 'package:flutter/material.dart';
import 'package:idcard/src/screens/biometric/biometric.dart';
import 'package:idcard/src/screens/forgot_password/initial_screen/forgot_password_screen.dart';
import 'package:idcard/src/screens/forgot_password/verification_screen/forgot_password_verification_screen.dart';
import 'package:idcard/src/screens/home/home_screen.dart';
import 'package:idcard/src/screens/login/login_screen.dart';
import 'package:idcard/src/screens/signup/signup_screen.dart';
import 'package:idcard/src/screens/verification/verification_screen.dart';
import 'package:idcard/src/screens/welcome/welcome_screen.dart';

Map<String, WidgetBuilder> buildRoutes() {
  return {
    '/': (context) => WelcomeScreen(),
    '/login': (context) => const LoginScreen(),
    '/signup': (context) => const SignupScreen(),
    '/home': (context) => const HomeScreen(),
    '/user-verification': (context) => const VerificationScreen(),
    '/forgot-password': (context) => ForgotPasswordScreen(),
    '/forgot-password/verification': (context) =>
        ForgotPasswordVerificationScreen(),
    '/forgot-password/set-new-password': (context) =>
        const ForgotPasswordVerificationScreen(),
    '/biometric': (context) => BiometricAuth(),
  };
}
