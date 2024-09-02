import 'package:flutter/material.dart';
import 'package:idcard/src/screens/home/home_screen.dart';
import 'package:idcard/src/screens/in_office_employee/join_as_in_office_employee/join_as_in_office_employee_screen.dart';
import 'package:idcard/src/screens/out_office_employee/join_as_in_office_employee/join_as_out_office_employee_screen.dart';
import 'package:idcard/src/screens/welcome/welcome_screen.dart';

Map<String, WidgetBuilder> buildRoutes() {
  return {
    '/': (context) => const WelcomeScreen(),
    '/join-as-in-office-employee': (context) => const JoinAsInOfficeEmployeeScreen(),
    '/join-as-out-of-office-employee': (context) => const JoinAsOutOfficeEmployeeScreen(),
    '/home': (context) => const HomeScreen(),
  };
}
