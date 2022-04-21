import 'dart:convert';

class Restaurant {
  String title;
  //List<String> kitchen;
  String kitchen;
  String address;
  double rating;
  //List<String> imagePaths;
  String imagePath;
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

  Restaurant copyWith({
    String? title,
    String? kitchen,
    String? address,
    double? rating,
    String? imagePath,
    int? averagePrice,
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

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'kitchen': kitchen,
      'address': address,
      'rating': rating,
      'imagePath': imagePath,
      'averagePrice': averagePrice,
      'description': description,
      'shortDescription': shortDescription,
      'workingHours': workingHours,
      'phone': phone,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      title: map['title'],
      kitchen: map['kitchen'],
      address: map['address'],
      rating: map['rating'],
      imagePath: map['imagePath'],
      averagePrice: map['averagePrice'],
      description: map['description'],
      shortDescription: map['shortDescription'],
      workingHours: map['workingHours'],
      phone: map['phone'],
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'title': title,
  //     'kitchen': kitchen,
  //     'address': address,
  //     'rating': rating,
  //     'imagePaths': imagePaths,
  //     'averagePrice': averagePrice,
  //     'description': description,
  //     'shortDescription': shortDescription,
  //     'workingHours': workingHours,
  //     'phone': phone
  //   };
  // }

  // String toJson() => json.encode(toMap());

  // factory Restaurant.fromJson(String source) =>
  //     Restaurant.fromMap(json.decode(source));

}
