part of '../domain_imports.dart';

class CartData extends Equatable {
  final bool canCheckout;
  final num discount;
  final num subTotal;
  final num total;
  final List<Cart> items;

  const CartData({
    this.canCheckout = false,
    this.subTotal = 0,
    this.discount = 0,
    this.total = 0,
    this.items = const [],
  });

  CartData copyWith({
    bool? canCheckout,
    num? subTotal,
    num? discount,
    num? total,
    List<Cart>? items,
  }) =>
      CartData(
        canCheckout: canCheckout ?? this.canCheckout,
        subTotal: subTotal ?? this.subTotal,
        discount: discount ?? this.discount,
        total: total ?? this.total,
        items: items ?? this.items,
      );

  @override
  List<Object> get props => [canCheckout, subTotal, discount, total, items];
}
