import 'dart:convert';

/// Sample User class just to demonstrate Authentication.

class UserAcc {
  final String id;
  final String name;
  final String email;
  final String pass;
  UserAcc({
    required this.id,
    required this.name,
    required this.email,
    required this.pass,
  });

  UserAcc copyWith({
    String? id,
    String? name,
    String? email,
    String? pass,
  }) {
    return UserAcc(
      id: id ?? this.id,
      pass: pass ?? this.pass,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory UserAcc.fromMap(Map<String, dynamic> map) {
    return UserAcc(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      pass: map['pass'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAcc.fromJson(String source) =>
      UserAcc.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';

  @override
  bool operator ==(covariant UserAcc other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
}
