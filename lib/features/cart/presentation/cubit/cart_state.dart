part of '../presentation_imports.dart';

class CartState extends Equatable {
  const CartState({
    this.cartDataStatus = UsecaseStatus.idle,
    this.cartDataFailure,
    this.cartData = const ApiResponse(data: CartData()),
    this.addToCartStatus = UsecaseStatus.idle,
    this.addToCartFailure,
    this.addToCartResponse = const ApiResponse(data: null),
    this.removeFromCartStatus = UsecaseStatus.idle,
    this.removeFromCartFailure,
    this.removeFromCartResponse = const ApiResponse(data: null),
    this.updateCartQuantityStatus = UsecaseStatus.idle,
    this.updateCartQuantityFailure,
    this.updateCartQuantityResponse = const ApiResponse(data: null),
  });

  final UsecaseStatus cartDataStatus;
  final Failure? cartDataFailure;
  final ApiResponse<CartData> cartData;

  final UsecaseStatus addToCartStatus;
  final Failure? addToCartFailure;
  final ApiResponse<void> addToCartResponse;

  final UsecaseStatus removeFromCartStatus;
  final Failure? removeFromCartFailure;
  final ApiResponse<void> removeFromCartResponse;

  final UsecaseStatus updateCartQuantityStatus;
  final Failure? updateCartQuantityFailure;
  final ApiResponse<void> updateCartQuantityResponse;

  CartState copyWith({
    UsecaseStatus? cartDataStatus,
    Failure? cartDataFailure,
    ApiResponse<CartData>? cartData,
    UsecaseStatus? addToCartStatus,
    Failure? addToCartFailure,
    ApiResponse<void>? addToCartResponse,
    UsecaseStatus? removeFromCartStatus,
    Failure? removeFromCartFailure,
    ApiResponse<void>? removeFromCartResponse,
    UsecaseStatus? updateCartQuantityStatus,
    Failure? updateCartQuantityFailure,
    ApiResponse<void>? updateCartQuantityResponse,
  }) {
    return CartState(
      cartDataStatus: cartDataStatus ?? this.cartDataStatus,
      cartDataFailure: cartDataFailure ?? this.cartDataFailure,
      cartData: cartData ?? this.cartData,
      addToCartStatus: addToCartStatus ?? UsecaseStatus.idle,
      addToCartFailure: addToCartFailure ?? this.addToCartFailure,
      addToCartResponse: addToCartResponse ?? const ApiResponse(data: null),
      removeFromCartStatus: removeFromCartStatus ?? UsecaseStatus.idle,
      removeFromCartFailure: removeFromCartFailure ?? this.removeFromCartFailure,
      removeFromCartResponse: removeFromCartResponse ?? const ApiResponse(data: null),
      updateCartQuantityStatus: updateCartQuantityStatus ?? UsecaseStatus.idle,
      updateCartQuantityFailure: updateCartQuantityFailure ?? this.updateCartQuantityFailure,
      updateCartQuantityResponse: updateCartQuantityResponse ?? const ApiResponse(data: null),
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
        '  addToCartResponse: $addToCartResponse,\n'
        '  removeFromCartStatus: $removeFromCartStatus,\n'
        '  removeFromCartFailure: $removeFromCartFailure,\n'
        '  removeFromCartResponse: $removeFromCartResponse,\n'
        '  updateCartQuantityStatus: $updateCartQuantityStatus,\n'
        '  updateCartQuantityFailure: $updateCartQuantityFailure,\n'
        '  updateCartQuantityResponse: $updateCartQuantityResponse,\n'
        ')';
  }

  @override
  List<Object?> get props => [
        cartDataStatus,
        cartDataFailure,
        cartData,
        addToCartStatus,
        addToCartFailure,
        addToCartResponse,
        removeFromCartStatus,
        removeFromCartFailure,
        removeFromCartResponse,
        updateCartQuantityStatus,
        updateCartQuantityFailure,
        updateCartQuantityResponse,
      ];
}
