part of '../data_imports.dart';

class CategoryModel extends Category {
  const CategoryModel({
    super.id,
    super.name,
    super.parent,
    super.active,
    super.slug,
    super.image,
    required super.createdAt,
    super.children,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      parent: map['parent'] ?? '',
      active: map['active'],
      slug: map['slug'],
      image: map['image'],
      createdAt: DateFormat(ApiConstants.dateFormat).parse(map['created_at']),
      children: List<SubCategoryModel>.from(map['children'].map((e) => SubCategoryModel.fromMap(e))),
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
      'created_at': DateFormat(ApiConstants.dateFormat).format(createdAt),
      'children': children.map((e) => (e as SubCategoryModel).toMap())
    };
  }

  String toJson() => json.encode(toMap());
}
