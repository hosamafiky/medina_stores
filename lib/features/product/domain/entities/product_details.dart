part of '../domain_imports.dart';

class ProductDetails extends Equatable {
  final ProductData data;
  final List<OptionCategory> optionCategories;

  const ProductDetails({
    required this.data,
    required this.optionCategories,
  });

  static ProductDetails empty() {
    return ProductDetails(
      data: ProductData.empty(),
      optionCategories: const [],
    );
  }

  factory ProductDetails.fromProduct(Product product) {
    return ProductDetails(
      data: ProductData(
        id: product.id,
        name: product.name,
        slug: product.slug,
        brand: product.brand,
        categories: product.categories,
        sku: product.sku,
        price: product.price,
        discount: product.price - product.priceAfterDiscount,
        discountType: 'amount',
        optionName: const DropdownItem(),
        priceAfterDiscount: product.priceAfterDiscount,
        images: [Image(image: product.image, createdAt: product.createdAt)],
        createdAt: DateTime.now(),
      ),
      optionCategories: const [],
    );
  }

  ProductDetails copyWith({
    ProductData? data,
    List<OptionCategory>? optionCategories,
  }) =>
      ProductDetails(
        data: data ?? this.data,
        optionCategories: optionCategories ?? this.optionCategories,
      );

  @override
  List<Object> get props => [data, optionCategories];
}

class OptionCategory extends Equatable {
  final int id;
  final String name;
  final bool isRequired;
  final String type;
  final List<Option> options;

  const OptionCategory({
    this.id = 0,
    this.name = '',
    this.isRequired = false,
    this.type = '',
    this.options = const [],
  });

  OptionCategory copyWith({
    int? id,
    String? name,
    bool? isRequired,
    String? type,
    List<Option>? options,
  }) =>
      OptionCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        isRequired: isRequired ?? this.isRequired,
        type: type ?? this.type,
        options: options ?? this.options,
      );

  @override
  List<Object> get props => [id, name, isRequired, type, options];
}

class Option extends Equatable {
  final int id;
  final int price;
  final int discount;
  final String discountType;
  final int priceAfterDiscount;
  final DropdownItem optionName;

  const Option({
    this.id = 0,
    this.price = 0,
    this.discount = 0,
    this.discountType = '',
    this.priceAfterDiscount = 0,
    this.optionName = const DropdownItem(id: 0, name: ''),
  });

  Option copyWith({
    int? id,
    int? price,
    int? discount,
    String? discountType,
    int? priceAfterDiscount,
    DropdownItem? optionName,
  }) =>
      Option(
        id: id ?? this.id,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        discountType: discountType ?? this.discountType,
        priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
        optionName: optionName ?? this.optionName,
      );

  @override
  List<Object> get props {
    return [
      id,
      price,
      discount,
      discountType,
      priceAfterDiscount,
      optionName,
    ];
  }
}
