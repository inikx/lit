import 'dart:convert';

class Restaurant {
  String title;
  List kitchen;
  String address;
  String rating;
  List imagePath;
  String averagePrice;
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

  Restaurant copyWith({
    String? title,
    List<String>? kitchen,
    String? address,
    String? rating,
    List<String>? imagePath,
    String? averagePrice,
    String? description,
    String? shortDescription,
    String? workingHours,
    String? phone,
  }) {
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
      phone: phone ?? this.phone,
    );
  }

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      title: json['title'],
      kitchen: json['kitchen'],
      address: json['address'],
      rating: json['rating'],
      imagePath: json['imagePath'],
      averagePrice: json['averagePrice'],
      description: json['description'],
      shortDescription: json['shortDescription'],
      workingHours: json['workingHours'],
      phone: json['phone'],
    );
  }

  @override
  String toString() {
    return 'Restaurant(title: $title, kitchen: $kitchen, address: $address, rating: $rating, imagePath: $imagePath, averagePrice: $averagePrice, description: $description, shortDescription: $shortDescription, workingHours: $workingHours, phone: $phone)';
  }
}
