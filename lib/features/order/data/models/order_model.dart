part of '../data_imports.dart';

class OrderModel extends Order {
  const OrderModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.body,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      userId: map['userId'] ?? 0,
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));

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