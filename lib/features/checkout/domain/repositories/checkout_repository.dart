part of '../domain_imports.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, ApiResponse<Checkout>>> getCheckoutData();
  Future<Either<Failure, ApiResponse<List<PaymentGate>>>> getPaymentGates();
}
