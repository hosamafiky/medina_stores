part of '../domain_imports.dart';

class Product extends Equatable {
  final int id;
  final String name, slug, sku, image;
  final DropdownItem brand;
  final List<DropdownItem> categories;
  final num price, priceAfterDiscount;
  final bool isFavourite;
  final DateTime createdAt;

  const Product({
    this.id = 0,
    this.name = '',
    this.slug = '',
    this.sku = '',
    this.image = '',
    this.brand = const DropdownItem(),
    this.categories = const [],
    this.price = 0,
    this.priceAfterDiscount = 0,
    this.isFavourite = false,
    required this.createdAt,
  });

  static Product empty() => Product(createdAt: DateTime.now());

  Product copyWith({
    int? id,
    String? name,
    String? slug,
    String? sku,
    String? image,
    DropdownItem? brand,
    List<DropdownItem>? categories,
    num? price,
    num? priceAfterDiscount,
    bool? isFavourite,
    DateTime? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      sku: sku ?? this.sku,
      image: image ?? this.image,
      brand: brand ?? this.brand,
      categories: categories ?? this.categories,
      price: price ?? this.price,
      priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
      isFavourite: isFavourite ?? this.isFavourite,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      image,
      brand,
      categories,
      priceAfterDiscount,
      isFavourite,
      createdAt,
    ];
  }
}
