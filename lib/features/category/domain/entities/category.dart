part of '../domain_imports.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String? parent;
  final int active;
  final String slug;
  final String image;
  final DateTime createdAt;

  const Category({
    required this.id,
    required this.name,
    required this.parent,
    required this.active,
    required this.slug,
    required this.image,
    required this.createdAt,
  });

  Category copyWith({
    int? id,
    String? name,
    String? parent,
    int? active,
    String? slug,
    String? image,
    DateTime? createdAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      parent: parent ?? this.parent,
      active: active ?? this.active,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      parent,
      active,
      slug,
      image,
      createdAt,
    ];
  }
}
