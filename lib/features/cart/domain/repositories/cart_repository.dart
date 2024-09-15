part of '../domain_imports.dart';

abstract class CartRepository {
  Future<Either<Failure, ApiResponse<CartData>>> getCartData();
  Future<Either<Failure, ApiResponse<void>>> addToCart(AddCartParams params);
  Future<Either<Failure, ApiResponse<void>>> removeFromCart(int cartId);
  Future<Either<Failure, ApiResponse<void>>> updateCartQuantity(UpdateCartQuantityParams params);
  Future<Either<Failure, ApiResponse<CheckoutData>>> getCheckoutData();
  Future<Either<Failure, ApiResponse<List<PaymentGate>>>> getPaymentGates();
}
