import 'dart:convert';

class Restaurant {
  String title;
  double rating;
  String kitchen_type;

  Restaurant({
    required this.title,
    required this.rating,
    required this.kitchen_type,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'rating': rating,
      'kitchen_type': kitchen_type,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      title: map['title'],
      rating: map['rating'],
      kitchen_type: map['kitchen_type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) =>
      Restaurant.fromMap(json.decode(source));

  Restaurant copyWith({
    String? title,
    double? rating,
    String? kitchen_type,
  }) {
    return Restaurant(
      title: title ?? this.title,
      rating: rating ?? this.rating,
      kitchen_type: kitchen_type ?? this.kitchen_type,
    );
  }
}
