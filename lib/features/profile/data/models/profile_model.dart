part of '../data_imports.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.body,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      userId: map['userId'] ?? 0,
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }

  factory ProfileModel.fromJson(String source) => ProfileModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  String toJson() => json.encode(toMap());
}