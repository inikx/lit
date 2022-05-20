import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:lit/constants/storage.dart';
import 'package:lit/constants/strings.dart';
import 'package:lit/data/models/booking.dart';

class BookingNetworkService {
  getBooking() async {
    String? token = await storage.read(key: 'token');

    final response = await http.get(
      Uri.parse('$BASE_URL/api/getBooking'),
      headers: {
        "Content-Type": "application/json",
        "x-access-token": token.toString()
      },
    );

    return response;
  }

  setBooking(Booking booking) async {
    String? token = await storage.read(key: 'token');
    final response = await http.post(Uri.parse('$BASE_URL/api/setBooking'),
        headers: {
          "Content-Type": "application/json",
          "x-access-token": token.toString()
        },
        body: jsonEncode({
          "title": booking.title,
          "name": booking.name,
          "timeOfBooking": booking.timeOfBooking.toString(),
          "personCount": booking.personCount,
          "comment": booking.comment,
          "phone": booking.phone
        }));

    return response;
  }
}
