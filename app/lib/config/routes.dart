import 'package:flutter/material.dart';
import 'package:idcard/src/screens/biometric/biometric.dart';
import 'package:idcard/src/screens/forgot_password/initial_screen/forgot_password_screen.dart';
import 'package:idcard/src/screens/forgot_password/set_new_password/set_new_password_screen.dart';
import 'package:idcard/src/screens/forgot_password/verification_screen/forgot_password_verification_screen.dart';
import 'package:idcard/src/screens/home/home_screen.dart';
import 'package:idcard/src/screens/login/login_screen.dart';
import 'package:idcard/src/screens/profile/profile_create/profile_details/profile_details_upload_screen.dart';
import 'package:idcard/src/screens/profile/profile_create/profile_image/profile_image_upload_screen.dart';
import 'package:idcard/src/screens/signup/signup_screen.dart';
import 'package:idcard/src/screens/verification/verification_screen.dart';
import 'package:idcard/src/screens/welcome/welcome_screen.dart';

Map<String, WidgetBuilder> buildRoutes() {
  return {
    '/': (context) => const WelcomeScreen(),
    '/login': (context) => const LoginScreen(),
    '/signup': (context) => const SignupScreen(),
    '/home': (context) => const HomeScreen(),
    '/user-verification': (context) => const VerificationScreen(),
    '/upload/profile-image': (context) => ProfileImageUploadScreen(),
    '/upload/profile-details': (context) => ProfileDetailsUploadScreen(),
    '/forgot-password': (context) => const ForgotPasswordScreen(),
    '/forgot-password/verification': (context) =>
        const ForgotPasswordVerificationScreen(),
    '/forgot-password/set-new-password': (context) =>
        const SetNewPasswordScreen(),
    '/biometric': (context) => BiometricAuth(),
  };
}
