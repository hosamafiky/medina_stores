part of '../data_imports.dart';

class SubCategoryModel extends SubCategory {
  const SubCategoryModel({
    required super.id,
    required super.name,
    required super.parent,
    required super.active,
    required super.slug,
    required super.image,
    required super.createdAt,
  });

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      id: map['id'],
      name: map['name'],
      parent: DropdownItemModel.fromMap(map['parent']),
      active: map['active'],
      slug: map['slug'],
      image: map['image'],
      createdAt: DateFormat(ApiConstants.dateFormat).parse(map['created_at']),
    );
  }

  factory SubCategoryModel.fromJson(String source) => SubCategoryModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'parent': (parent as DropdownItemModel).toMap(),
      'active': active,
      'slug': slug,
      'image': image,
      'created_at': DateFormat(ApiConstants.dateFormat).format(createdAt),
    };
  }

  String toJson() => json.encode(toMap());
}
