part of '../data_imports.dart';

class CheckoutModel extends Checkout {
  const CheckoutModel({
    required super.canCheckout,
    required super.cart,
    required super.subTotal,
    required super.discount,
    required super.cartTotal,
    required super.tax,
    required super.shippingFees,
    required super.wallet,
    required super.total,
    required super.deliveryTime,
  });

  factory CheckoutModel.fromCheckout(Checkout data) {
    return CheckoutModel(
      canCheckout: data.canCheckout,
      cart: data.cart,
      subTotal: data.subTotal,
      discount: data.discount,
      cartTotal: data.cartTotal,
      tax: data.tax,
      shippingFees: data.shippingFees,
      wallet: data.wallet,
      total: data.total,
      deliveryTime: data.deliveryTime,
    );
  }

  factory CheckoutModel.fromMap(Map<String, dynamic> map) {
    return CheckoutModel(
      canCheckout: map['can_checkout'],
      cart: List<CartModel>.from(map['cart'].map((e) => CartModel.fromMap(e))),
      subTotal: map['sub_total'],
      discount: map['discount'],
      cartTotal: map['cart_total'],
      tax: map['tax'],
      shippingFees: map['shipping_fees'],
      wallet: map['wallet'],
      total: map['total'],
      deliveryTime: map['delivery_time'],
    );
  }

  factory CheckoutModel.fromJson(String source) => CheckoutModel.fromMap(jsonDecode(source));

  Map<String, dynamic> toMap() => {
        "can_checkout": canCheckout,
        "cart": cart.map((e) => CartModel.fromCart(e).toMap()).toList(),
        "sub_total": subTotal,
        "discount": subTotal,
        "cart_total": cartTotal,
        "tax": tax,
        "shipping_fees": shippingFees,
        "wallet": wallet,
        "total": total,
        "delivery_time": deliveryTime,
      };

  String toJson() => jsonEncode(toMap());
}
