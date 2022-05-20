import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lit/constants/strings.dart';

class RegisterNetworkService {
  register(String email, String password, String city) async {
    final response = await http.post(Uri.parse('$BASE_URL/api/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password, "city": city}));
    return response;
  }
}
