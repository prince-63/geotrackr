import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:idcard/config/api_config.dart';
import 'package:idcard/src/utils/share_preferences.dart';
import 'package:idcard/src/utils/uri_parser.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordService {
  static Future<void> sendVerificationEmail(
      BuildContext context, String email) async {
    Uri uri = UriParser.parse(ApiConfig.authForgotPassword);

    // Prepare the request
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, String> body = {
      'email': email,
    };

    // Send the request
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );

    // Handle the response
    if (response.statusCode == 200) {
      // Success logic here
      print('Verification email sent successfully.');
      SharePreferences.saveString('email', email);

      Navigator.pushNamed(context, "/forgot-password/verification");
    } else {
      // Error handling here
      print('Failed to send verification email: ${response.body}');
      throw Exception('Failed to send verification email');
    }
  }

  static Future<void> verifyEmail(BuildContext context, String code) async {
    String? email = await SharePreferences.getString('email');

    Uri uri = UriParser.parse(ApiConfig.authForgotPasswordVerification);

    // Prepare the request
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, String> body = {
      'email': email ?? '',
      'verificationCode': code,
    };

    // Send the request
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );

    // Handle the response
    if (response.statusCode == 200) {
      // Success logic here
      print('Email verified successfully.');

      Navigator.pushNamed(context, "/home");
    } else {
      // Error handling here
      print('Failed to verify email: ${response.body}');
      throw Exception('Failed to verify email');
    }
  }
}
