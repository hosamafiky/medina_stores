part of '../data_imports.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  const CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiResponse<CartData>>> getCartData() async {
    return await remoteDataSource.getCartData.handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<void>>> addToCart(AddCartParams params) async {
    return await remoteDataSource.addToCart(params).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<void>>> removeFromCart(int cartId) async {
    return await remoteDataSource.removeFromCart(cartId).handleCallbackWithFailure;
  }
}
