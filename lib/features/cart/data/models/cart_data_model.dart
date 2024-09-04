part of '../data_imports.dart';

class CartDataModel extends CartData {
  const CartDataModel({
    required super.canCheckout,
    required super.subTotal,
    required super.discount,
    required super.total,
    required super.items,
  });

  factory CartDataModel.fromMap(Map<String, dynamic> map) {
    final List<Cart> items = List<Cart>.from(
      map['carts'].map((x) => CartModel.fromMap(x)).toList(),
    );

    return CartDataModel(
      canCheckout: map['can_checkout'],
      subTotal: map['sub_total'],
      discount: map['discount'],
      total: map['total'],
      items: items,
    );
  }

  factory CartDataModel.fromJson(String source) => CartDataModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'can_checkout': canCheckout,
      'sub_total': subTotal,
      'discount': discount,
      'total': total,
      'carts': items.map((x) => CartModel.fromCart(x).toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
