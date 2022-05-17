import 'dart:convert';

class RegisterData {
  String email;
  String password;
  String city;

  RegisterData({this.email = "", this.password = "", this.city = ""});

  RegisterData copyWith({String? email, String? password, String? city}) {
    return RegisterData(
        email: email ?? this.email,
        password: password ?? this.password,
        city: city ?? this.city);
  }

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password, 'city': city};
  }

  factory RegisterData.fromMap(Map<String, dynamic> map) {
    return RegisterData(
        email: map['email'] ?? '',
        password: map['password'] ?? '',
        city: map['city'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory RegisterData.fromJson(String source) =>
      RegisterData.fromMap(json.decode(source));

  @override
  String toString() =>
      'RegisterData(email: $email, password: $password, city: $city)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterData &&
        other.email == email &&
        other.password == password &&
        other.city == city;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ city.hashCode;
}
