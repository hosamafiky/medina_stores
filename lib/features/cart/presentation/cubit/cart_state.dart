part of '../presentation_imports.dart';

class CartState extends Equatable {
  const CartState({
    this.cartItemsStatus = UsecaseStatus.idle,
    this.cartItemsFailure,
    this.cartItems = const [],
    this.addToCartStatus = UsecaseStatus.idle,
    this.addToCartFailure,
    this.showWidget = false,
  });

  final UsecaseStatus cartItemsStatus;
  final Failure? cartItemsFailure;
  final List<Cart> cartItems;

  num get total => cartItems.fold(0, (previousValue, element) => previousValue + (element.product.priceAfterDiscount * element.quantity));
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
  }) {
    return CartState(
      cartItemsStatus: cartItemsStatus ?? this.cartItemsStatus,
      cartItemsFailure: cartItemsFailure ?? this.cartItemsFailure,
      cartItems: cartItems ?? this.cartItems,
      addToCartStatus: addToCartStatus ?? this.addToCartStatus,
      addToCartFailure: addToCartFailure ?? this.addToCartFailure,
      showWidget: showWidget ?? this.showWidget,
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
      ];
}
