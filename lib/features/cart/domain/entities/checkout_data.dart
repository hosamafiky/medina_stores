part of '../domain_imports.dart';

class CheckoutData extends Equatable {
  final bool canCheckout;
  final List<Cart> cart;
  final num subTotal;
  final num discount;
  final num cartTotal;
  final num tax;
  final num shippingFees;
  final num wallet;
  final num total;
  final String deliveryTime;

  const CheckoutData({
    this.canCheckout = false,
    this.cart = const [],
    this.subTotal = 0.0,
    this.discount = 0.0,
    this.cartTotal = 0.0,
    this.tax = 0.0,
    this.shippingFees = 0.0,
    this.wallet = 0.0,
    this.total = 0.0,
    this.deliveryTime = '',
  });

  CheckoutData copyWith({
    bool? canCheckout,
    List<Cart>? cart,
    int? subTotal,
    int? discount,
    int? cartTotal,
    double? tax,
    int? shippingFees,
    int? wallet,
    num? total,
    String? deliveryTime,
  }) =>
      CheckoutData(
        canCheckout: canCheckout ?? this.canCheckout,
        cart: cart ?? this.cart,
        subTotal: subTotal ?? this.subTotal,
        discount: discount ?? this.discount,
        cartTotal: cartTotal ?? this.cartTotal,
        tax: tax ?? this.tax,
        shippingFees: shippingFees ?? this.shippingFees,
        wallet: wallet ?? this.wallet,
        total: total ?? this.total,
        deliveryTime: deliveryTime ?? this.deliveryTime,
      );

  @override
  List<Object> get props {
    return [
      canCheckout,
      cart,
      subTotal,
      discount,
      cartTotal,
      tax,
      shippingFees,
      wallet,
      total,
      deliveryTime,
    ];
  }
}
