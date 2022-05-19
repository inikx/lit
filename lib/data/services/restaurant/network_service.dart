import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:lit/constants/storage.dart';
import 'package:lit/constants/strings.dart';
import 'package:lit/data/models/restaurant.dart';

class RestaurantNetworkService {
  getAllRests() async {
    String? token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$BASE_URL/api/getAllRests'),
      headers: {
        "Content-Type": "application/json",
        "x-access-token": token.toString()
      },
    );

    return response;
  }

  showFav() async {
    String? token = await storage.read(key: 'token');
    String? _id = await storage.read(key: '_id');
    final response = await http.post(Uri.parse('$BASE_URL/api/showFav'),
        headers: {
          "Content-Type": "application/json",
          "x-access-token": token.toString()
        },
        body: jsonEncode({"user_id": _id}));

    return response;
  }

  addFav(String rest_id) async {
    String? token = await storage.read(key: 'token');
    String? user_id = await storage.read(key: '_id');
    final response = await http.post(Uri.parse('$BASE_URL/api/addFav'),
        headers: {
          "Content-Type": "application/json",
          "x-access-token": token.toString()
        },
        body: jsonEncode({"user_id": user_id, "rest_id": rest_id}));

    return response;
  }

  deleteFav(String rest_id) async {
    String? token = await storage.read(key: 'token');
    String? user_id = await storage.read(key: '_id');
    final response = await http.post(Uri.parse('$BASE_URL/api/deleteFav'),
        headers: {
          "Content-Type": "application/json",
          "x-access-token": token.toString()
        },
        body: jsonEncode({"user_id": user_id, "rest_id": rest_id}));

    return response;
  }
}
