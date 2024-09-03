part of '../domain_imports.dart';

abstract class CartRepository {
  Future<Either<Failure, ApiResponse<List<Cart>>>> getCarts();
  Future<Either<Failure, ApiResponse<Cart>>> addToCart(AddCartParams params);
}
