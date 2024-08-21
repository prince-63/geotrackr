import 'package:flutter/material.dart';
import 'package:idcard/src/config/api_config.dart';
import 'package:idcard/src/utils/share_preferences.dart';
import 'package:http/http.dart' as http;

class LogoutService {
  static Future<void> logout(BuildContext context) async {
    Uri uri = Uri.parse(ApiConfig.authLogout);

    String? token = await SharePreferences.getString('token');

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      SharePreferences.remove('token');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged out successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushNamed(context, "/login");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to logout!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
