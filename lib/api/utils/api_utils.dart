import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiUtils {
  // static const String _baseUrl = "http://10.0.2.2:8000/api";

  static const String _baseUrl = "https://aelvet.com/api";

  // Static token storage for now (ideally use secure storage)
  static String? _authToken;

  static void setToken(String token) {
    _authToken = token;
  }

  static Future<http.Response> get(String endpoint, {Map<String, String>? headers}) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    return await http.get(uri, headers: _defaultHeaders(headers)).timeout(const Duration(seconds: 10));
  }

  static Future<http.Response> post(String endpoint, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    return await http.post(
      uri,
      headers: _defaultHeaders(headers),
      body: jsonEncode(body),
    ).timeout(const Duration(seconds: 10));
  }

  static Future<http.Response> put(String endpoint, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    return await http.put(
      uri,
      headers: _defaultHeaders(headers),
      body: jsonEncode(body),
    ).timeout(const Duration(seconds: 10));
  }

  static Future<http.Response> delete(String endpoint, {Map<String, String>? headers}) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    return await http.delete(uri, headers: _defaultHeaders(headers)).timeout(const Duration(seconds: 10));
  }

  static Map<String, String> _defaultHeaders([Map<String, String>? headers]) {
    final defaultHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };

    if (_authToken != null) {
      defaultHeaders['Authorization'] = 'Bearer $_authToken';
    }

    if (headers != null) {
      defaultHeaders.addAll(headers);
    }

    return defaultHeaders;
  }
}
