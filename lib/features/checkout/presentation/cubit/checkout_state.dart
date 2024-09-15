part of '../presentation_imports.dart';

class CheckoutState extends Equatable {
  const CheckoutState({
    this.checkoutStatus = UsecaseStatus.idle,
    this.checkoutFailure,
    this.checkoutResponse = const ApiResponse(data: Checkout()),
    this.paymentGatesStatus = UsecaseStatus.idle,
    this.paymentGatesFailure,
    this.paymentGates = const ApiResponse(data: []),
  });

  final UsecaseStatus checkoutStatus;
  final Failure? checkoutFailure;
  final ApiResponse<Checkout> checkoutResponse;

  final UsecaseStatus paymentGatesStatus;
  final Failure? paymentGatesFailure;
  final ApiResponse<List<PaymentGate>> paymentGates;

  CheckoutState copyWith({
    UsecaseStatus? checkoutStatus,
    Failure? checkoutFailure,
    ApiResponse<Checkout>? checkoutResponse,
    UsecaseStatus? paymentGatesStatus,
    Failure? paymentGatesFailure,
    ApiResponse<List<PaymentGate>>? paymentGates,
  }) {
    return CheckoutState(
      checkoutStatus: checkoutStatus ?? this.checkoutStatus,
      checkoutFailure: checkoutFailure ?? this.checkoutFailure,
      checkoutResponse: checkoutResponse ?? this.checkoutResponse,
      paymentGatesStatus: paymentGatesStatus ?? UsecaseStatus.idle,
      paymentGatesFailure: paymentGatesFailure ?? this.paymentGatesFailure,
      paymentGates: paymentGates ?? this.paymentGates,
    );
  }

  @override
  String toString() =>
      'CheckoutState(checkoutStatus: $checkoutStatus, checkoutFailure: $checkoutFailure, checkoutResponse: $checkoutResponse, paymentGatesStatus: $paymentGatesStatus, paymentGatesFailure: $paymentGatesFailure, paymentGates: $paymentGates)';

  @override
  List<Object?> get props => [
        checkoutStatus,
        checkoutFailure,
        checkoutResponse,
        paymentGatesStatus,
        paymentGatesFailure,
        paymentGates,
      ];
}
