import 'dart:convert';

import 'package:app/config/api_config.dart';
import 'package:app/src/helper/error_handler.dart';
import 'package:app/src/utils/share_preferences.dart';
import 'package:app/src/utils/uri_parser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginHandler {
  static void login(String text, String password, BuildContext context) async {
    final url = UriParser.parse(ApiConfig.authLogin);
    late String username = '';
    late String email = '';

    if (text.contains('@')) {
      email = text;
    } else {
      username = text;
    }

    if (email.isEmpty && username.isEmpty) {
      ErrorHandler.displayError(
          context, "Please enter a valid email or username");
      return;
    }

    if (password.isEmpty) {
      ErrorHandler.displayError(context, "Please enter a valid password");
      return;
    }

    if (email.isNotEmpty && username.isEmpty) {
      await _postRequest(url, {'email': email, 'password': password}, context);
      Navigator.pushNamed(context, '/singup');
    } else {
      await _postRequest(
          url, {'username': username, 'password': password}, context);
      Navigator.pushNamed(context, '/singup');
    }
  }

  static Future<void> _postRequest(
      Uri url, Map<String, String> body, BuildContext context) async {
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        
        final token = responseBody['data']['token'];
        final email = responseBody['data']['email'];

        if (token != null && email != null) {
          SharePreferences.saveString('token', token);
          SharePreferences.saveString('email', email);
          Navigator.pushNamed(context, '/home');
        } else {
          ErrorHandler.displayError(
              context, "Login failed: token or email is null");
          throw Exception('Login failed: token or email is null');
        }
      } else {
        ErrorHandler.displayError(context,
            "Failed to login: ${response.statusCode} ${response.reasonPhrase}");
        throw Exception(
            'Failed to login: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      ErrorHandler.displayError(context, "Login Failed: $e");
      throw Exception('Login Failed: $e');
    }
  }
}
