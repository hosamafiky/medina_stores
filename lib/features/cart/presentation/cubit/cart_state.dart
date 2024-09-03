part of '../presentation_imports.dart';

class CartState extends Equatable {
  const CartState({
    this.cartItemsStatus = UsecaseStatus.idle,
    this.cartItemsFailure,
    this.cartItems = const [],
    this.addToCartStatus = UsecaseStatus.idle,
    this.addToCartFailure,
    this.showWidget = false,
    this.total = 0,
  });

  final UsecaseStatus cartItemsStatus;
  final Failure? cartItemsFailure;
  final List<Cart> cartItems;

  final num total;
  final bool showWidget;

  final UsecaseStatus addToCartStatus;
  final Failure? addToCartFailure;

  CartState copyWith({
    UsecaseStatus? cartItemsStatus,
    Failure? cartItemsFailure,
    List<Cart>? cartItems,
    UsecaseStatus? addToCartStatus,
    Failure? addToCartFailure,
    bool? showWidget,
    num? total,
  }) {
    return CartState(
      cartItemsStatus: cartItemsStatus ?? this.cartItemsStatus,
      cartItemsFailure: cartItemsFailure ?? this.cartItemsFailure,
      cartItems: cartItems ?? this.cartItems,
      addToCartStatus: addToCartStatus ?? this.addToCartStatus,
      addToCartFailure: addToCartFailure ?? this.addToCartFailure,
      showWidget: showWidget ?? this.showWidget,
      total: total ?? this.total,
    );
  }

  @override
  String toString() {
    return 'CartState(cartsStatus: $cartItemsStatus, cartsFailure: $cartItemsFailure, carts: $cartItems, addCartStatus: $addToCartStatus, addCartFailure: $addToCartFailure)';
  }

  @override
  List<Object?> get props => [
        cartItemsStatus,
        cartItemsFailure,
        cartItems,
        addToCartStatus,
        addToCartFailure,
        showWidget,
        total,
      ];
}
