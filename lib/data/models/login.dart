import 'dart:convert';

class LogInData {
  String id;
  String email;
  String password;

  LogInData({
    this.id = "",
    this.email = "",
    this.password = "",
  });

  LogInData copyWith({
    String? id,
    String? email,
    String? password,
  }) {
    return LogInData(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }

  factory LogInData.fromMap(Map<String, dynamic> map) {
    return LogInData(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LogInData.fromJson(String source) =>
      LogInData.fromMap(json.decode(source));

  @override
  String toString() => 'LogInData(id: $id, email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LogInData &&
        other.id == id &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ password.hashCode;
}
