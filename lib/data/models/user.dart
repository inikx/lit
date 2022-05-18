import 'dart:convert';

class User {
  String id;
  String email;
  String password;
  String city;

  User(
      {required this.id,
      required this.email,
      required this.password,
      required this.city});

  User copyWith({String? id, String? email, String? city}) {
    return User(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password,
        city: city ?? this.city);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email, 'password': password, 'city': city};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'] ?? "",
        email: map['email'] ?? '',
        password: map['password'] ?? '',
        city: map['city'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["_id"] ?? null,
        email: json["email"],
        password: json["password"],
        city: json["city"]);
  }

  @override
  String toString() =>
      'User(id: $id, email: $email, password: $password, city: $city)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.email == email &&
        other.password == password &&
        other.city == city;
  }

  @override
  int get hashCode =>
      id.hashCode ^ email.hashCode ^ password.hashCode ^ city.hashCode;
}
