part of '../domain_imports.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone, dialingCode;
  final String token;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.dialingCode,
    required this.token,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? dialingCode,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dialingCode: dialingCode ?? this.dialingCode,
      token: token ?? this.token,
    );
  }

  UserModel get modelize => UserModel(
        id: id,
        name: name,
        email: email,
        phone: phone,
        dialingCode: dialingCode,
        token: token,
      );

  @override
  List<Object?> get props => [id, name, email, phone, dialingCode, token];
}
