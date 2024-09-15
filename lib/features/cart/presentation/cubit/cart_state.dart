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
    this.checkoutStatus = UsecaseStatus.idle,
    this.checkoutFailure,
    this.checkoutResponse = const ApiResponse(data: CheckoutData()),
    this.paymentGatesStatus = UsecaseStatus.idle,
    this.paymentGatesFailure,
    this.paymentGates = const ApiResponse(data: []),
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

  final UsecaseStatus checkoutStatus;
  final Failure? checkoutFailure;
  final ApiResponse<CheckoutData> checkoutResponse;

  final UsecaseStatus paymentGatesStatus;
  final Failure? paymentGatesFailure;
  final ApiResponse<List<PaymentGate>> paymentGates;

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
    UsecaseStatus? checkoutStatus,
    Failure? checkoutFailure,
    ApiResponse<CheckoutData>? checkoutResponse,
    UsecaseStatus? paymentGatesStatus,
    Failure? paymentGatesFailure,
    ApiResponse<List<PaymentGate>>? paymentGates,
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
      checkoutStatus: checkoutStatus ?? this.checkoutStatus,
      checkoutFailure: checkoutFailure ?? this.checkoutFailure,
      checkoutResponse: checkoutResponse ?? this.checkoutResponse,
      paymentGatesStatus: paymentGatesStatus ?? UsecaseStatus.idle,
      paymentGatesFailure: paymentGatesFailure ?? this.paymentGatesFailure,
      paymentGates: paymentGates ?? this.paymentGates,
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
        '  checkoutStatus: $checkoutStatus, \n'
        '  checkoutFailure: $checkoutFailure, \n'
        '  checkoutResponse: $checkoutResponse, \n'
        '  paymentGatesStatus: $paymentGatesStatus, \n'
        '  paymentGatesFailure: $paymentGatesFailure, \n'
        '  paymentGates: $paymentGates, \n'
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
        checkoutStatus,
        checkoutFailure,
        checkoutResponse,
        paymentGatesStatus,
        paymentGatesFailure,
        paymentGates,
      ];
}
