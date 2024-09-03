part of '../domain_imports.dart';

class Cart extends Equatable {
  final Product product;
  final int quantity;

  const Cart({required this.product, this.quantity = 1});

  Cart copyWith({
    Product? product,
    int? quantity,
  }) {
    return Cart(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}
