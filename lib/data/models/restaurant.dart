import 'dart:convert';
import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  String title;
  List<String> kitchen;
  String address;
  double rating;
  List<String> imagePath;
  int averagePrice;
  String description;
  String shortDescription;
  String workingHours;
  String phone;

  Restaurant(
      {required this.title,
      required this.kitchen,
      required this.address,
      required this.rating,
      required this.imagePath,
      required this.averagePrice,
      required this.description,
      required this.shortDescription,
      required this.workingHours,
      required this.phone});

  Restaurant copyWith(
      {String? title,
      List<String>? kitchen,
      String? address,
      double? rating,
      List<String>? imagePath,
      int? averagePrice,
      String? description,
      String? shortDescription,
      String? workingHours,
      String? phone}) {
    return Restaurant(
        title: title ?? this.title,
        kitchen: kitchen ?? this.kitchen,
        address: address ?? this.title,
        rating: rating ?? this.rating,
        imagePath: imagePath ?? this.imagePath,
        averagePrice: averagePrice ?? this.averagePrice,
        description: description ?? this.description,
        shortDescription: shortDescription ?? this.shortDescription,
        workingHours: workingHours ?? this.workingHours,
        phone: phone ?? this.phone);
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'title': title,
  //     'kitchen': kitchen,
  //     'address': address,
  //     'rating': rating,
  //     'imagePath': imagePath,
  //     'averagePrice': averagePrice,
  //     'description': description,
  //     'shortDescription': shortDescription,
  //     'workingHours': workingHours,
  //     'phone': phone
  //   };
  // }

//String toJson() => json.encode(toMap());

  static Map<String, dynamic> toMap(Restaurant restaurant) {
    return {
      'title': restaurant.title,
      'kitchen': restaurant.kitchen,
      'address': restaurant.address,
      'rating': restaurant.rating,
      'imagePath': restaurant.imagePath,
      'averagePrice': restaurant.averagePrice,
      'description': restaurant.description,
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
    return Restaurant(
      title: json['title'],
      kitchen: List<String>.from(json['kitchen']),
      address: json['address'],
      rating: double.parse(json['rating']),
      imagePath: List<String>.from(json['imagePath']),
      averagePrice: int.parse(json['averagePrice']),
      description: json['description'],
      shortDescription: json['shortDescription'],
      workingHours: json['workingHours'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['kitchen'] = this.kitchen;
    data['address'] = this.address;
    data['rating'] = this.rating;
    data['imagePath'] = this.imagePath;
    data['averagePrice'] = this.averagePrice;
    data['description'] = this.description;
    data['shortDescription'] = this.shortDescription;
    data['workingHours'] = this.workingHours;
    data['phone'] = this.phone;
    return data;
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        title,
        kitchen,
        address,
        rating,
        imagePath,
        averagePrice,
        description,
        shortDescription,
        workingHours,
        phone
      ];

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'title': title,
  //     'kitchen': kitchen,
  //     'address': address,
  //     'rating': rating,
  //     'imagePath': imagePath,
  //     'averagePrice': averagePrice,
  //     'description': description,
  //     'shortDescription': shortDescription,
  //     'workingHours': workingHours,
  //     'phone': phone,
  //   };
  // }

  // factory Restaurant.fromMap(Map<String, dynamic> map) {
  //   return Restaurant(
  //     map['title'] as String,
  //     List<String>.from((map['kitchen'] as List<String>),
  //     map['address'] as String,
  //     map['rating'] as double,
  //     List<String>.from((map['imagePath'] as List<String>),
  //     map['averagePrice'] as int,
  //     map['description'] as String,
  //     map['shortDescription'] as String,
  //     map['workingHours'] as String,
  //     map['phone'] as String,
  //   );
  // }

}
