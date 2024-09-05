part of '../domain_imports.dart';

class ProductData extends Equatable {
  final int id;
  final String name;
  final String slug;
  final DropdownItem brand;
  final List<DropdownItem> categories;
  final String sku;
  final num price;
  final num discount;
  final String discountType;
  final DropdownItem optionName;
  final num priceAfterDiscount;
  final List<Image> images;
  final DateTime createdAt;

  const ProductData({
    required this.id,
    required this.name,
    required this.slug,
    required this.brand,
    required this.categories,
    required this.sku,
    required this.price,
    required this.discount,
    required this.discountType,
    required this.optionName,
    required this.priceAfterDiscount,
    required this.images,
    required this.createdAt,
  });

  static ProductData empty() => ProductData(
        id: 0,
        name: '',
        slug: '',
        brand: const DropdownItem(),
        categories: const [],
        sku: '',
        price: 0,
        discount: 0,
        discountType: '',
        optionName: const DropdownItem(),
        priceAfterDiscount: 0,
        images: const [],
        createdAt: DateTime.now(),
      );

  ProductData copyWith({
    int? id,
    String? name,
    String? slug,
    DropdownItem? brand,
    List<DropdownItem>? categories,
    String? sku,
    int? price,
    int? discount,
    String? discountType,
    DropdownItem? optionName,
    int? priceAfterDiscount,
    List<Image>? images,
    DateTime? createdAt,
  }) =>
      ProductData(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        brand: brand ?? this.brand,
        categories: categories ?? this.categories,
        sku: sku ?? this.sku,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        discountType: discountType ?? this.discountType,
        optionName: optionName ?? this.optionName,
        priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
        images: images ?? this.images,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object> get props {
    return [
      id,
      name,
      slug,
      brand,
      categories,
      sku,
      price,
      discount,
      discountType,
      optionName,
      priceAfterDiscount,
      images,
      createdAt,
    ];
  }
}

class Image extends Equatable {
  final int id;
  final bool isMain;
  final String image;
  final DateTime createdAt;

  const Image({
    this.id = 0,
    this.isMain = false,
    this.image = '',
    required this.createdAt,
  });

  Image copyWith({
    int? id,
    bool? isMain,
    String? image,
    DateTime? createdAt,
  }) =>
      Image(
        id: id ?? this.id,
        isMain: isMain ?? this.isMain,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object> get props => [id, isMain, image, createdAt];
}
