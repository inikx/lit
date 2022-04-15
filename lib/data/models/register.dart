import 'dart:convert';

class RegisterData {
  String email;
  String password;

  RegisterData({
    this.email = "",
    this.password = "",
  });

  RegisterData copyWith({
    String? email,
    String? password,
  }) {
    return RegisterData(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory RegisterData.fromMap(Map<String, dynamic> map) {
    return RegisterData(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterData.fromJson(String source) =>
      RegisterData.fromMap(json.decode(source));

  @override
  String toString() => 'RegisterData(email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterData &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
