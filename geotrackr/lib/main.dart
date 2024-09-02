import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idcard/src/config/routes.dart';
import 'package:idcard/src/utils/text_theme.dart';

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
