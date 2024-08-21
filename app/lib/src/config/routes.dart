import 'package:flutter/material.dart';
import 'package:idcard/src/screens/about/about_screen.dart';
import 'package:idcard/src/screens/account/account_screen.dart';
import 'package:idcard/src/screens/biometric/biometric.dart';
import 'package:idcard/src/screens/forgot_password/initial_screen/forgot_password_screen.dart';
import 'package:idcard/src/screens/forgot_password/set_new_password/set_new_password_screen.dart';
import 'package:idcard/src/screens/forgot_password/verification_screen/forgot_password_verification_screen.dart';
import 'package:idcard/src/screens/help_and_support/help_and_support_screen.dart';
import 'package:idcard/src/screens/home/home_screen.dart';
import 'package:idcard/src/screens/login/login_screen.dart';
import 'package:idcard/src/screens/profile/profile_create/profile_details/profile_details_upload_screen.dart';
import 'package:idcard/src/screens/profile/profile_create/profile_image/profile_image_upload_screen.dart';
import 'package:idcard/src/screens/scan/scan_screen.dart';
import 'package:idcard/src/screens/signup/signup_screen.dart';
import 'package:idcard/src/screens/thanks/thanks_screen.dart';
import 'package:idcard/src/screens/thanks/thanks_screen_out.dart';
import 'package:idcard/src/screens/verification/verification_screen.dart';
import 'package:idcard/src/screens/view_and_download/view_and_download_screen.dart';
import 'package:idcard/src/screens/welcome/welcome_screen.dart';

Map<String, WidgetBuilder> buildRoutes() {
  return {
    '/': (context) => const WelcomeScreen(),
    '/login': (context) => const LoginScreen(),
    '/signup': (context) => const SignupScreen(),
    '/home': (context) => const HomeScreen(),
    '/scan': (context) => const ScanScreen(),
    '/user-verification': (context) => const VerificationScreen(),
    '/upload/profile-image': (context) => ProfileImageUploadScreen(),
    '/upload/profile-details': (context) => ProfileDetailsUploadScreen(),
    '/forgot-password': (context) => const ForgotPasswordScreen(),
    '/forgot-password/verification': (context) =>
        const ForgotPasswordVerificationScreen(),
    '/forgot-password/set-new-password': (context) =>
        const SetNewPasswordScreen(),
    '/biometric': (context) => BiometricAuth(),
    '/view-and-download': (context) => ViewAndDownloadScreen(),
    '/account': (context) => const AccountScreen(),
    '/about': (context) => AboutScreen(),
    '/help-and-support': (context) => HelpAndSupportScreen(),
    '/thank-screen-in': (context) => const ThanksScreenIn(),
    '/thank-screen-out': (context) => const ThanksScreenOut(),
  };
}
