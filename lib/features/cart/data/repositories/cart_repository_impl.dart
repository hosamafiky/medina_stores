part of '../data_imports.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  const CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiResponse<List<Cart>>>> getCarts() async {
    return await remoteDataSource.getCarts.handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<Cart>>> addToCart(AddCartParams params) async {
    return await remoteDataSource.addToCart(params).handleCallbackWithFailure;
  }
}
