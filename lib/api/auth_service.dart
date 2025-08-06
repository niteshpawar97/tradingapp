import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './utils/api_utils.dart';

class AuthService {
  // 🔐 Login User
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      final response = await ApiUtils.post("/login-user", {
        'email': email,
        'password': password,
      });

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          data['success'] == true &&
          data['token'] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', data['token']);
        await prefs.setString('user_data', jsonEncode(data['user']));
        return {
          'success': true,
          'message': 'Login successful!',
          'user': data['user'],
          'token': data['token'],
        };
      } else {
        return {'success': false, 'message': data['message'] ?? 'Login failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // 📝 Register User
  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String mobile,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await ApiUtils.post("/register-user", {
        'name': name,
        'email': email,
        'mobile': mobile,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });

      // Decode the response body
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 201 && data['success'] == true) {
        return {
          'success': true,
          'message': data['message'],
          'user': data['user'],
        };
      } else {
        // Handle error response
        return {
          'success': false,
          'message': data['message'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}
