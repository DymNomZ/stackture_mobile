import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stackture_mobile/utils/variables.dart';
import 'package:stackture_mobile/utils/workspace.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ApiService {
  static const String baseUrl = "http://stackture.eloquenceprojects.org";

  /// AI Chat API
  bool connectToAI(Workspace workspace) {

    bool status = false;

    channel = WebSocketChannel.connect(
      Uri.parse('ws://stackture.eloquenceprojects.org/chat'),
    );

    // Send the handshake message
    final handshakeMessage = {
      "workspace_id": workspace.id,
      "node_id": 0,
      "token": token,
    };

    channel!.sink.add(jsonEncode(handshakeMessage));

    channel!.stream.listen(
      (message) {
        try {
          final jsonResponse = jsonDecode(message);
          if (jsonResponse['status'] == 'success') {
            print('Handshake successful: ${jsonResponse['message']}');
            status = true;
          } else {
            print('Handshake failed: ${jsonResponse['message']}');
          }
        } catch (e) {
          print('Error decoding JSON: $e');
        }
      },
      onDone: () {
        print('WebSocket connection closed.');
      },
      onError: (error) {
        print('WebSocket error: $error');
      },
    );

    return status;

  }

  /// Fetch User Workspaces API
  Future<List<dynamic>> fetchWorkspaces() async {
    http.Response? test;
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/api/workspace/fetch"),
        headers: {
          "Authorization": "Bearer $token",
        }
      );

      test = response;

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        //print(data.toString());
        return data;
      } else {
        return [{"error": data["error"]}];
      }
    } catch (e) {
      //print("FETCH " + e.toString() + test!.body);
      return [{"error": "Error creating workspace."}];
    }
  }

  /// Create Workspace API
  Future<Map<String, dynamic>> createWorkspace(String title, String description) async {
    http.Response? test;
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

      test = response;

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        //print(data["workspace_id"]);
        return {"workspace_id": data["workspace_id"]};
      } else {
        return {"error": data["error"]};
      }
    } catch (e) {
      //print("CREATE " + e.toString() + test!.body);
      return {"error": "Error creating workspace."};
    }
  }

  //  Login API
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

  // Signup API
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
