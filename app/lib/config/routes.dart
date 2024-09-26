import 'package:flutter/material.dart';
import 'package:geotrackr/presentation/pages/employee_update_page.dart';
import 'package:geotrackr/presentation/pages/forgot_password_page.dart';
import 'package:geotrackr/presentation/pages/help_and_support_page.dart';
import 'package:geotrackr/presentation/pages/login_page.dart';
import 'package:geotrackr/presentation/pages/main_page.dart';
import 'package:geotrackr/presentation/pages/profile_page.dart';
import 'package:geotrackr/presentation/pages/set_new_password_page.dart';
import 'package:geotrackr/presentation/pages/verify_forgot_password_page.dart';
import 'package:geotrackr/presentation/pages/working_hours_page.dart';

/// This function builds a map of routes for the application.
/// Each route is associated with a specific page widget.
Map<String, WidgetBuilder> buildRoutes() {
  return {
    /// Route for the login page.
    '/': (context) => const LoginPage(),

    /// Route for the forgot password page.
    '/forgot-password': (context) => ForgotPasswordPage(),

    /// Route for verifying the forgot password page.
    '/verify-forgot-password': (context) => const VerifyForgotPasswordPage(),

    /// Route for setting the new password page.
    '/set-new-password': (context) => const SetNewPasswordPage(),

    /// Route for the main page.
    '/home': (context) => const MainPage(),

    /// Route for the profile page.
    '/profile': (context) => const ProfilePage(),

    /// Route for the help and support page.
    '/help-and-support': (context) => const HelpAndSupportPage(),

    /// Route for the employee update information page.
    '/employee_update_information': (context) => const EmployeeUpdatePage(),

    /// Route for the working hours page.
    '/working-hours': (context) => const WorkingHoursPage(),
  };
}
