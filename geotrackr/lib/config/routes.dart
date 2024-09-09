import 'package:flutter/material.dart';
import 'package:geotrackr/presentation/pages/home_page.dart';
import 'package:geotrackr/presentation/pages/login_page.dart';

Map<String, WidgetBuilder> buildRoutes() {
  return {
    '/': (context) => LoginPage(),
    '/home': (context) => HomeScreen(),
  };
}
