part of '../data_imports.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.dialingCode,
    required super.token,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      dialingCode: map['dialing_code'] ?? '',
      token: map['_token'] ?? '',
    );
  }

  factory UserModel.fromJson(String json) {
    return UserModel.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'dialing_code': dialingCode,
      '_token': token,
    };
  }

  String toJson() => jsonEncode(toMap());
}
