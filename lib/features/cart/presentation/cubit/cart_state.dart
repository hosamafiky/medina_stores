part of '../presentation_imports.dart';

class CartState extends Equatable {
  const CartState({
    this.cartDataStatus = UsecaseStatus.idle,
    this.cartDataFailure,
    this.cartData = const CartData(),
    this.addToCartStatus = UsecaseStatus.idle,
    this.addToCartFailure,
    this.removeFromCartStatus = UsecaseStatus.idle,
    this.removeFromCartFailure,
    this.updateCartQuantityStatus = UsecaseStatus.idle,
    this.updateCartQuantityFailure,
    this.showWidget = false,
  });

  final UsecaseStatus cartDataStatus;
  final Failure? cartDataFailure;
  final CartData cartData;

  final bool showWidget;

  final UsecaseStatus addToCartStatus;
  final Failure? addToCartFailure;

  final UsecaseStatus removeFromCartStatus;
  final Failure? removeFromCartFailure;

  final UsecaseStatus updateCartQuantityStatus;
  final Failure? updateCartQuantityFailure;

  CartState copyWith({
    UsecaseStatus? cartDataStatus,
    Failure? cartDataFailure,
    CartData? cartData,
    UsecaseStatus? addToCartStatus,
    Failure? addToCartFailure,
    UsecaseStatus? removeFromCartStatus,
    Failure? removeFromCartFailure,
    UsecaseStatus? updateCartQuantityStatus,
    Failure? updateCartQuantityFailure,
    bool? showWidget,
  }) {
    return CartState(
      cartDataStatus: cartDataStatus ?? this.cartDataStatus,
      cartDataFailure: cartDataFailure ?? this.cartDataFailure,
      cartData: cartData ?? this.cartData,
      addToCartStatus: addToCartStatus ?? this.addToCartStatus,
      addToCartFailure: addToCartFailure ?? this.addToCartFailure,
      removeFromCartStatus: removeFromCartStatus ?? this.removeFromCartStatus,
      removeFromCartFailure: removeFromCartFailure ?? this.removeFromCartFailure,
      updateCartQuantityStatus: updateCartQuantityStatus ?? UsecaseStatus.idle,
      updateCartQuantityFailure: updateCartQuantityFailure ?? this.updateCartQuantityFailure,
      showWidget: showWidget ?? this.showWidget,
    );
  }

  @override
  String toString() {
    return 'CartState(\n'
        '  cartDataStatus: $cartDataStatus,\n'
        '  cartDataFailure: $cartDataFailure,\n'
        '  cartData: $cartData,\n'
        '  addToCartStatus: $addToCartStatus,\n'
        '  addToCartFailure: $addToCartFailure,\n'
        '  removeFromCartStatus: $removeFromCartStatus,\n'
        '  removeFromCartFailure: $removeFromCartFailure,\n'
        '  updateCartQuantityStatus: $updateCartQuantityStatus,\n'
        '  updateCartQuantityFailure: $updateCartQuantityFailure,\n'
        '  showWidget: $showWidget,\n'
        ')';
  }

  @override
  List<Object?> get props => [
        cartDataStatus,
        cartDataFailure,
        cartData,
        addToCartStatus,
        addToCartFailure,
        removeFromCartStatus,
        removeFromCartFailure,
        updateCartQuantityStatus,
        updateCartQuantityFailure,
        showWidget,
      ];
}
