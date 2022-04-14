import 'dart:convert';

class RegisterData {
  String username;
  String email;
  String password;

  RegisterData({
    this.username = "",
    this.email = "",
    this.password = "",
  });

  RegisterData copyWith({
    String? username,
    String? email,
    String? password,
  }) {
    return RegisterData(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  factory RegisterData.fromMap(Map<String, dynamic> map) {
    return RegisterData(
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterData.fromJson(String source) =>
      RegisterData.fromMap(json.decode(source));

  @override
  String toString() =>
      'RegisterData(username: $username, email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterData &&
        other.username == username &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ email.hashCode ^ password.hashCode;
}
