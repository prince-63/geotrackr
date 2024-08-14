import 'package:app/src/screens/biometric.dart';
import 'package:app/src/screens/home_screen.dart';
import 'package:app/src/screens/login_screen.dart';
import 'package:app/src/screens/signup_screen.dart';
import 'package:app/src/screens/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initialRoute = '/biometric';

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
      final token = prefs.getString('jwt_token');

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
      title: 'Quantum QR',
      debugShowCheckedModeBanner: false,
      theme: _buildThemeData(),
      initialRoute: initialRoute,
      routes: _buildRoutes(),
    );
  }

  ThemeData _buildThemeData() {
    return ThemeData(
      fontFamily: 'Lato',
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontFamily: 'Lato'),
        bodyMedium: TextStyle(fontFamily: 'Lato'),
        displayLarge: TextStyle(fontFamily: 'Lato'),
        displayMedium: TextStyle(fontFamily: 'Lato'),
        displaySmall: TextStyle(fontFamily: 'Lato'),
        headlineMedium: TextStyle(fontFamily: 'Lato'),
        titleLarge: TextStyle(fontFamily: 'Lato'),
        titleMedium: TextStyle(fontFamily: 'Lato'),
        titleSmall: TextStyle(fontFamily: 'Lato'),
        bodySmall: TextStyle(fontFamily: 'Lato'),
        labelLarge: TextStyle(fontFamily: 'Lato'),
        labelSmall: TextStyle(fontFamily: 'Lato'),
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      '/': (context) => const LoginScreen(),
      '/home': (context) => const HomeScreen(),
      '/signup': (context) => const SignupScreen(),
      '/verification': (context) => const VerificationScreen(),
      '/biometric': (context) => BiometricAuth(),
    };
  }
}
