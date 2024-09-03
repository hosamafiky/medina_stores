part of '../data_imports.dart';

class CartModel extends Cart {
  const CartModel({
    required super.product,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      product: ProductModel.fromMap(map['product']),
    );
  }

  factory CartModel.fromJson(String source) => CartModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'product': ProductModel.fromProduct(product).toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}
