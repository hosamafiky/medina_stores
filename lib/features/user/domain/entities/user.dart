part of '../domain_imports.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String token;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  UserModel get modelize => UserModel(
        id: id,
        name: name,
        email: email,
        token: token,
      );

  @override
  List<Object?> get props => [id, name, email, token];
}
