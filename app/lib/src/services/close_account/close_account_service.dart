import 'package:flutter/material.dart';
import 'package:idcard/src/config/api_config.dart';
import 'package:idcard/src/services/biometric/biometric_service.dart';
import 'package:idcard/src/utils/share_preferences.dart';
import 'package:http/http.dart' as http;

class CloseAccountService {
  static Future<void> closeAccount(BuildContext context) async {
    String? token = await SharePreferences.getString('token');
    BiometricService biometricService = BiometricService();
    biometricService.authenticate();

    if (token != null) {
      Uri url = Uri.parse(ApiConfig.authCloseAccount);

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Account closed successfully'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context).pushNamed('/signup');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to close account'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You are not logged in'),
          backgroundColor: Colors.red,
        ),
      );

      Navigator.of(context).pushNamed('/login');
    }
  }
}
