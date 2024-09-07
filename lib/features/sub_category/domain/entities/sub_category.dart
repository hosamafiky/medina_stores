part of '../domain_imports.dart';

class SubCategory extends Equatable {
  final int id;
  final String name;
  final DropdownItem parent;
  final bool active;
  final String slug;
  final String image;
  final DateTime createdAt;

  const SubCategory({
    this.id = 0,
    this.name = '',
    this.parent = const DropdownItem(),
    this.active = false,
    this.slug = '',
    this.image = '',
    required this.createdAt,
  });

  static SubCategory empty() => SubCategory(createdAt: DateTime.now());

  SubCategory copyWith({
    int? id,
    String? name,
    DropdownItem? parent,
    bool? active,
    String? slug,
    String? image,
    DateTime? createdAt,
  }) {
    return SubCategory(
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
    return [id, name, parent, active, slug, image, createdAt];
  }
}
