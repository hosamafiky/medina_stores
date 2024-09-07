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

  factory CategoryModel.fromCategory(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      parent: category.parent,
      active: category.active,
      slug: category.slug,
      image: category.image,
      children: category.children,
      createdAt: category.createdAt,
    );
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: (map["name"] as String).capitalize,
      parent: map['parent'] ?? '',
      active: map['active'] == 1,
      slug: map['slug'],
      image: map['image'],
      createdAt: DateFormat(ApiConstants.dateFormat, 'en_US').parse(map['created_at']),
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
      'created_at': DateFormat(ApiConstants.dateFormat, 'en_US').format(createdAt),
      'children': List<Map<String, dynamic>>.from(children.map((e) => SubCategoryModel.fromSubCategory(e).toMap()))
    };
  }

  String toJson() => json.encode(toMap());
}
