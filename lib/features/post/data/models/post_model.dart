part of '../data_imports.dart';

class PostModel extends Post {
  const PostModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.body,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      userId: map['userId'] ?? 0,
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source));

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
