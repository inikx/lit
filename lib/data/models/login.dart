import 'dart:convert';

class LogInData {
  String username;
  String password;

  LogInData({
    this.username = "",
    this.password = "",
  });

  LogInData copyWith({
    String? username,
    String? password,
  }) {
    return LogInData(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory LogInData.fromMap(Map<String, dynamic> map) {
    return LogInData(
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LogInData.fromJson(String source) =>
      LogInData.fromMap(json.decode(source));

  @override
  String toString() => 'LogInData(username: $username, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LogInData &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
