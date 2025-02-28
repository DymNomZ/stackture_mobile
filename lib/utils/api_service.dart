import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stackture_mobile/utils/variables.dart';

class ApiService {
  static const String baseUrl = "http://stackture.eloquenceprojects.org";

  /// Create Workspace API
  Future<Map<String, dynamic>> createWorkspace(String title, String description) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/workspace/create"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "title": title,
          "description": description,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {"workspace_id": data["workspace_id"]};
      } else {
        return {"error": data["error"]};
      }
    } catch (e) {
      return {"error": "Error creating workspace."};
    }
  }

  /// Login API
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {"token": data["token"]};
      } else {
        return {"error": data["error"]};
      }
    } catch (e) {
      return {"error": "Username or Password is incorrect"};
    }
  }

  /// Signup API
  Future<Map<String, dynamic>> signup(String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {"token": data["token"]};
      } else {
        return {"error": data["error"]};
      }
    } catch (e) {
      return {"error": "Network error. Please try again."};
    }
  }
}
