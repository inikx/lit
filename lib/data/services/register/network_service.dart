import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lit/constants/storage.dart';
import 'package:lit/constants/strings.dart';

class RegisterNetworkService {
  register(String username, String email, String password) async {
    final response = await http.post(Uri.parse('$BASE_URL/api/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {"username": username, "email": email, "password": password}));
    return response;
  }
}
