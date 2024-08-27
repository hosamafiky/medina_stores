part of '../domain_imports.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String? parent;
  final int active;
  final String slug;
  final String image;
  final DateTime createdAt;
  final List<SubCategory> children;

  const Category({
    this.id = 0,
    this.name = '',
    this.parent = '',
    this.active = 0,
    this.slug = '',
    this.image = '',
    required this.createdAt,
    this.children = const [],
  });

  factory Category.empty() => Category(createdAt: DateTime.now());

  Category copyWith({
    int? id,
    String? name,
    String? parent,
    int? active,
    String? slug,
    String? image,
    DateTime? createdAt,
    List<SubCategory>? children,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      parent: parent ?? this.parent,
      active: active ?? this.active,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      children: children ?? this.children,
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
      children,
    ];
  }
}
