import 'package:flutter/material.dart';
import 'package:geotrackr/presentation/pages/employee_update_page.dart';
import 'package:geotrackr/presentation/pages/help_and_support_page.dart';
import 'package:geotrackr/presentation/pages/login_page.dart';
import 'package:geotrackr/presentation/pages/main_page.dart';
import 'package:geotrackr/presentation/pages/profile_page.dart';
import 'package:geotrackr/presentation/pages/working_hours_page.dart';

Map<String, WidgetBuilder> buildRoutes() {
  return {
    '/': (context) => LoginPage(),
    '/home': (context) => const MainPage(),
    '/profile': (context) => const ProfilePage(),
    '/help-and-support': (context) => const HelpAndSupportPage(),
    '/employee_update_information': (context) => const EmployeeUpdatePage(),
    '/working-hours': (context) => const WorkingHoursPage(),
  };
}