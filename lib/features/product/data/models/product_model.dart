part of '../data_imports.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.body,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      userId: map['userId'] ?? 0,
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));

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