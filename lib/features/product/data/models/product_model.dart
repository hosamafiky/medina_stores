part of '../data_imports.dart';

class ProductModel extends Product {
  const ProductModel({
    super.id = 0,
    super.name = '',
    super.slug = '',
    super.sku = '',
    super.image = '',
    required super.brand,
    super.categories = const [],
    super.price = 0,
    super.priceAfterDiscount = 0,
    super.isFavourite = false,
    required super.createdAt,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: (json['name'] as String).capitalize,
      slug: json['slug'] as String,
      sku: json['sku'] as String,
      image: json['image'] as String,
      brand: DropdownItemModel.fromMap(json['brand'] as Map<String, dynamic>),
      categories: (json['categories'] as List).map((e) => DropdownItemModel.fromMap(e as Map<String, dynamic>)).toList(),
      price: json['price'] as num,
      priceAfterDiscount: json['price_after_discount'] as num,
      isFavourite: (json['is_favourite'] == 1),
      createdAt: DateFormat(ApiConstants.dateFormat).parse(json['created_at'] as String),
    );
  }

  factory ProductModel.fromProduct(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      slug: product.slug,
      sku: product.sku,
      image: product.image,
      brand: product.brand,
      categories: product.categories,
      price: product.price,
      priceAfterDiscount: product.priceAfterDiscount,
      isFavourite: product.isFavourite,
      createdAt: product.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'sku': sku,
      'image': image,
      'brand': (brand as DropdownItemModel).toMap(),
      'categories': categories.map((e) => (e as DropdownItemModel).toMap()).toList(),
      'price': price,
      'price_after_discount': priceAfterDiscount,
      'is_favourite': isFavourite ? 1 : 0,
      'created_at': DateFormat(ApiConstants.dateFormat).format(createdAt),
    };
  }

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());
}
