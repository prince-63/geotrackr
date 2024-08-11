import 'package:app/src/screens/home_screen.dart';
import 'package:app/src/screens/login_screen.dart';
import 'package:app/src/screens/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quantum QR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/signup': (context) => const SignupScreen(),
      }
    );
  }
}
