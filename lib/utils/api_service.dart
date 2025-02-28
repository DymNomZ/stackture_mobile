import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://stackture.eloquenceprojects.org/auth";

  /// Login API
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "token": data["token"]};
      } else {
        final errorData = jsonDecode(response.body);
        return {"success": false, "error": errorData["error"] ?? "Login failed"};
      }
    } catch (e) {
      return {"success": false, "error": "Username or Password is incorrect"};
    }
  }

  /// Signup API
  Future<Map<String, dynamic>> signup(String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "message": data["message"] ?? "Account created successfully"};
      } else {
        final errorData = jsonDecode(response.body);
        return {"success": false, "error": errorData["error"] ?? "Signup failed"};
      }
    } catch (e) {
      print(e);
      return {"success": false, "error": "Network error. Please try again."};
    }
  }
}
