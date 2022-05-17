import 'dart:convert';

class User {
  int id;
  String username;
  String city;

  User({required this.id, required this.username, required this.city});

  User copyWith({int? id, String? username, String? city}) {
    return User(
        id: id ?? this.id,
        username: username ?? this.username,
        city: city ?? this.city);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'username': username, 'city': city};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id']?.toInt() ?? 0,
        username: map['username'] ?? '',
        city: map['city'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"] ?? null, username: json["username"], city: json["city"]);
  }

  @override
  String toString() => 'User(id: $id, username: $username, city: $city)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id && other.username == username;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode;
}
