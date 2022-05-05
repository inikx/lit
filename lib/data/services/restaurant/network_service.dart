import 'dart:convert';
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
}
