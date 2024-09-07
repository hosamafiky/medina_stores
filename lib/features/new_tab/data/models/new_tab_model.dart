part of '../data_imports.dart';

class NewTabModel extends NewTab {
  const NewTabModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.body,
  });

  factory NewTabModel.fromMap(Map<String, dynamic> map) {
    return NewTabModel(
      userId: map['userId'] ?? 0,
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }

  factory NewTabModel.fromJson(String source) => NewTabModel.fromMap(json.decode(source));

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