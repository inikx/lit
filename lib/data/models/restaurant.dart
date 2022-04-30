import 'dart:convert';

class Restaurant {
  String title;
  List<String> kitchens;
  String address;
  double rating;
  List<String> imagePaths;
  int averagePrice;
  String description;
  String shortDescription;
  String workingHours;
  String phone;

  Restaurant(
      {required this.title,
      required this.kitchens,
      required this.address,
      required this.rating,
      required this.imagePaths,
      required this.averagePrice,
      required this.description,
      required this.shortDescription,
      required this.workingHours,
      required this.phone});

  Restaurant copyWith({
    String? title,
    List<String>? kitchens,
    String? address,
    double? rating,
    List<String>? imagePaths,
    int? averagePrice,
    String? description,
    String? shortDescription,
    String? workingHours,
    String? phone,
  }) {
    return Restaurant(
      title: title ?? this.title,
      kitchens: kitchens ?? this.kitchens,
      address: address ?? this.title,
      rating: rating ?? this.rating,
      imagePaths: imagePaths ?? this.imagePaths,
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
      'kitchens': kitchens,
      'address': address,
      'rating': rating,
      'imagePaths': imagePaths,
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
      kitchens: map['kitchens'],
      address: map['address'],
      rating: map['rating'],
      imagePaths: map['imagePaths'],
      averagePrice: map['averagePrice'],
      description: map['description'],
      shortDescription: map['shortDescription'],
      workingHours: map['workingHours'],
      phone: map['phone'],
    );
  }

  @override
  String toString() {
    return 'Restaurant(title: $title, kitchens: $kitchens, address: $address, rating: $rating, imagePaths: $imagePaths, averagePrice: $averagePrice, description: $description, shortDescription: $shortDescription, workingHours: $workingHours, phone: $phone)';
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
