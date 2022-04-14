import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lit/constants/storage.dart';
import 'package:lit/constants/strings.dart';

class LoginNetworkService {
  login(String username, String password) async {
    final response = await http.post(Uri.parse('$BASE_URL/api/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}));
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      await storage.write(key: 'token', value: jsonResponse['token']);
      await storage.write(key: 'username', value: jsonResponse['username']);
      await storage.write(key: 'email', value: jsonResponse['email']);
    }
    return response;
  }
}
