import 'dart:convert';

class LogInData {
  String email;
  String password;

  LogInData({
    this.email = "",
    this.password = "",
  });

  LogInData copyWith({
    String? email,
    String? password,
  }) {
    return LogInData(
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

  factory LogInData.fromMap(Map<String, dynamic> map) {
    return LogInData(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LogInData.fromJson(String source) =>
      LogInData.fromMap(json.decode(source));

  @override
  String toString() => 'LogInData(email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LogInData &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
