part of '../data_imports.dart';

class CartRepositoryImpl implements CartRepository {
  final InternetConnectionChecker connectionChecker;
  final CartRemoteDataSource remoteDataSource;

  const CartRepositoryImpl({
    required this.connectionChecker,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, ApiResponse<CartData>>> getCartData() async {
    if (await connectionChecker.hasConnection) {
      try {
        final cart = await remoteDataSource.getCartData;
        return Right(cart);
      } on AppException catch (e) {
        return Left(e.handleFailure);
      }
    } else {
      return Left(NoInternetConnectionFailure(response: ApiResponse(message: LocaleKeys.check_internet.tr())));
    }
  }

  @override
  Future<Either<Failure, ApiResponse<void>>> addToCart(AddCartParams params) async {
    if (await connectionChecker.hasConnection) {
      return await remoteDataSource.addToCart(params).handleCallbackWithFailure;
    } else {
      return Left(NoInternetConnectionFailure(response: ApiResponse(message: LocaleKeys.check_internet.tr())));
    }
  }

  @override
  Future<Either<Failure, ApiResponse<void>>> removeFromCart(int cartId) async {
    if (await connectionChecker.hasConnection) {
      return await remoteDataSource.removeFromCart(cartId).handleCallbackWithFailure;
    } else {
      return Left(NoInternetConnectionFailure(response: ApiResponse(message: LocaleKeys.check_internet.tr())));
    }
  }

  @override
  Future<Either<Failure, ApiResponse<void>>> updateCartQuantity(params) async {
    if (await connectionChecker.hasConnection) {
      return await remoteDataSource.updateQuantity(params).handleCallbackWithFailure;
    } else {
      return Left(NoInternetConnectionFailure(response: ApiResponse(message: LocaleKeys.check_internet.tr())));
    }
  }
}
