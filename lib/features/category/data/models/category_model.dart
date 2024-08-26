part of '../data_imports.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    super.parent,
    required super.active,
    required super.slug,
    required super.image,
    required super.createdAt,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      parent: map['parent'],
      active: map['active'],
      slug: map['slug'],
      image: map['image'],
      createdAt: DateFormat('yyyy MMM dd hh:mm:ss').parse(map['created_at']),
    );
  }

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'parent': parent,
      'active': active,
      'slug': slug,
      'image': image,
      'created_at': DateFormat('yyyy MMM dd hh:mm:ss').format(createdAt),
    };
  }

  String toJson() => json.encode(toMap());
}
