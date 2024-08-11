import 'dart:convert';
import 'package:app/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final url = Uri.parse(ApiConfig.authLogin);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final token = responseBody['token'];

        // Store the token in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);

        return responseBody;
      } else {
        throw Exception(
            'Failed to login: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      // Log the error for debugging
      print('Login Failed: $e');
      throw Exception('Login Failed: $e');
    }
  }

  static Future<Map<String, dynamic>> signup(
      String name, String email, String password) async {
    final url = Uri.parse(ApiConfig.authSignup);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final token = responseBody['token'];

        // Store the token in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);
        
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to signup: ${response.statusCode} ${response.reasonPhrase} ${response.body}');
      }
    } catch (e) {
      throw Exception('Signup Failed: $e');
    }
  }
}
