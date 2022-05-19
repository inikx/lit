import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  String id;
  String title;
  String city;
  List<String> kitchen;
  String address;
  double rating;
  List<String> imagePath;
  int averagePrice;
  String shortDescription;
  String workingHours;
  String phone;
  double? latitude;
  double? longitude;

  Restaurant(
      {required this.id,
      required this.title,
      required this.city,
      required this.kitchen,
      required this.address,
      required this.rating,
      required this.imagePath,
      required this.averagePrice,
      required this.shortDescription,
      required this.workingHours,
      required this.phone,
      this.latitude,
      this.longitude});

  Restaurant copyWith(
      {String? id,
      String? title,
      String? city,
      List<String>? kitchen,
      String? address,
      double? rating,
      List<String>? imagePath,
      int? averagePrice,
      String? shortDescription,
      String? workingHours,
      String? phone}) {
    return Restaurant(
        id: id ?? this.id,
        title: title ?? this.title,
        city: city ?? this.city,
        kitchen: kitchen ?? this.kitchen,
        address: address ?? this.title,
        rating: rating ?? this.rating,
        imagePath: imagePath ?? this.imagePath,
        averagePrice: averagePrice ?? this.averagePrice,
        shortDescription: shortDescription ?? this.shortDescription,
        workingHours: workingHours ?? this.workingHours,
        phone: phone ?? this.phone);
  }

  static Map<String, dynamic> toMap(Restaurant restaurant) {
    return {
      'id': restaurant.id,
      'title': restaurant.title,
      'city': restaurant.city,
      'kitchen': restaurant.kitchen,
      'address': restaurant.address,
      'rating': restaurant.rating,
      'imagePath': restaurant.imagePath,
      'averagePrice': restaurant.averagePrice,
      'shortDescription': restaurant.shortDescription,
      'workingHours': restaurant.workingHours,
      'phone': restaurant.phone,
    };
  }

  static String encode(List<Restaurant> restaurants) => json.encode(
        restaurants
            .map<Map<String, dynamic>>(
                (restaurant) => Restaurant.toMap(restaurant))
            .toList(),
      );

  static List<Restaurant> decode(String restaurants) =>
      (json.decode(restaurants) as List<dynamic>)
          .map<Restaurant>((item) => Restaurant.fromJson(item))
          .toList();

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    List<String> images = [
      "https://img.icons8.com/wired/344/restaurant-table.png"
    ];
    if (json['imagePath'][0].toString() != "null") {
      images = List<String>.from(json['imagePath']);
    }

    return Restaurant(
      id: json['_id'] ?? "",
      title: json['title'] ?? "",
      city: json['city'] ?? "",
      kitchen: List<String>.from(json['kitchen']),
      address: json['address'] ?? "",
      rating: double.tryParse(json['rating']) ?? 0,
      imagePath: images,
      averagePrice: int.tryParse(json['averagePrice']) ?? 0,
      shortDescription: json['shortDescription'] ?? "",
      workingHours: json['workingHours'] ?? "",
      phone: json['phone'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['city'] = this.city;
    data['kitchen'] = this.kitchen;
    data['address'] = this.address;
    data['rating'] = this.rating;
    data['imagePath'] = this.imagePath;
    data['averagePrice'] = this.averagePrice;
    data['shortDescription'] = this.shortDescription;
    data['workingHours'] = this.workingHours;
    data['phone'] = this.phone;
    return data;
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        id,
        title,
        city,
        kitchen,
        address,
        rating,
        imagePath,
        averagePrice,
        shortDescription,
        workingHours,
        phone
      ];
}
