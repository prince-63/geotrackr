import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idcard/config/routes.dart';
import 'package:idcard/src/utils/text_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runZonedGuarded(() {
    runApp(MyApp());
  }, (Object error, StackTrace stackTrace) {
    print('Uncaught error: $error');
    print('Stack trace: $stackTrace');
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initialRoute = '/';

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      await _checkLoginStatus();
    } catch (e) {
      _handleInitializationError(e);
    }
  }

  Future<void> _checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        setState(() {
          initialRoute = '/home';
        });
      }
    } catch (e) {
      throw Exception('Failed to check login status: $e');
    }
  }

  void _handleInitializationError(Object error) {
    print('Initialization error: $error');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Id Card',
      debugShowCheckedModeBanner: false,
      theme: _buildThemeData(),
      initialRoute: initialRoute,
      routes: buildRoutes(),
    );
  }

  ThemeData _buildThemeData() {
    return ThemeData(
      fontFamily: 'Lato',
      textTheme: appTextTheme,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
  }
}
