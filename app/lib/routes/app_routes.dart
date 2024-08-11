import 'package:flutter/material.dart';
import '../src/screens/home_screen.dart';
import '../src/screens/login_screen.dart';
import '../src/screens/signup_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String scan = '/scan';
  static const String login = '/login';
  static const String signup = '/signup';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignupScreen(),
  };
}