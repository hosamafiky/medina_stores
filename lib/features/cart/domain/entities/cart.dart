part of '../domain_imports.dart';

class Cart extends Equatable {
  final int id;
  final int quantity;
  final bool isValidQuantity;
  final Product product;
  final DropdownItem brand;
  final List<Option> options;
  final num itemTotal;
  final DateTime createdAt;

  const Cart({
    required this.id,
    required this.quantity,
    required this.isValidQuantity,
    required this.product,
    required this.brand,
    required this.options,
    required this.itemTotal,
    required this.createdAt,
  });

  static Cart get empty => Cart(
        id: 0,
        quantity: 0,
        isValidQuantity: true,
        product: Product.empty(),
        brand: const DropdownItem(),
        options: const [],
        itemTotal: 0,
        createdAt: DateTime.now(),
      );

  Cart copyWith({
    int? id,
    int? quantity,
    bool? isValidQuantity,
    Product? product,
    DropdownItem? brand,
    List<Option>? options,
    num? itemTotal,
    DateTime? createdAt,
  }) =>
      Cart(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        isValidQuantity: isValidQuantity ?? this.isValidQuantity,
        product: product ?? this.product,
        brand: brand ?? this.brand,
        options: options ?? this.options,
        itemTotal: itemTotal ?? this.itemTotal,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object> get props => [
        id,
        quantity,
        isValidQuantity,
        product,
        brand,
        options,
        itemTotal,
        createdAt,
      ];
}
