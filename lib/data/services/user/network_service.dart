import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:lit/constants/storage.dart';
import 'package:lit/constants/strings.dart';

class UserNetworkService {
  showUser() async {
    String? token = await storage.read(key: 'token');
    String? _id = await storage.read(key: '_id');
    final response = await http.post(Uri.parse('$BASE_URL/api/showUser'),
        headers: {
          "Content-Type": "application/json",
          "x-access-token": token.toString()
        },
        body: jsonEncode({"_id": _id}));

    return response;
  }

  updateCity(String city) async {
    String? token = await storage.read(key: 'token');
    String? _id = await storage.read(key: '_id');
    final response = await http.post(Uri.parse('$BASE_URL/api/updateCity'),
        headers: {
          "Content-Type": "application/json",
          "x-access-token": token.toString()
        },
        body: jsonEncode({"_id": _id, "city": city}));

    return response;
  }
}
