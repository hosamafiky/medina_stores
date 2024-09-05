part of '../data_imports.dart';

class CartModel extends Cart {
  const CartModel({
    required super.product,
    required super.id,
    required super.quantity,
    required super.isValidQuantity,
    required super.brand,
    required super.options,
    required super.itemTotal,
    required super.createdAt,
  });

  factory CartModel.fromCart(Cart cart) {
    return CartModel(
      id: cart.id,
      quantity: cart.quantity,
      isValidQuantity: cart.isValidQuantity,
      itemTotal: cart.itemTotal,
      createdAt: cart.createdAt,
      options: cart.options,
      product: ProductModel.fromProduct(cart.product),
      brand: DropdownItemModel.fromDropdown(cart.brand),
    );
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'],
      quantity: map['quantity'],
      isValidQuantity: map['is_valid_quantity'],
      itemTotal: map['item_total'],
      options: List<OptionModel>.from(map['options'].map((x) => OptionModel.fromMap(x))),
      createdAt: DateFormat(ApiConstants.dateFormat, 'en_US').parse(map['created_at']),
      product: ProductModel.fromMap(map['product']),
      brand: DropdownItemModel.fromMap(map['Brand']),
    );
  }

  factory CartModel.fromJson(String source) => CartModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'is_valid_quantity': isValidQuantity,
      'product': ProductModel.fromProduct(product).toMap(),
      'Brand': DropdownItemModel.fromDropdown(brand).toMap(),
      "options": options.map((x) => OptionModel.fromOption(x).toMap()).toList(),
      "item_total": itemTotal,
      "created_at": DateFormat(ApiConstants.dateFormat, 'en_US').format(createdAt),
    };
  }

  String toJson() => json.encode(toMap());
}
