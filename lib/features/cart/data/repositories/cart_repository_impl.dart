part of '../data_imports.dart';

class CartRepositoryImpl implements CartRepository {
  final InternetConnectionChecker connectionChecker;
  final CartRemoteDataSource remoteDataSource;
  final CartLocalDataSource localDataSource;

  const CartRepositoryImpl({
    required this.connectionChecker,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, ApiResponse<CartData>>> getCartData() async {
    if (await connectionChecker.hasConnection) {
      try {
        final cart = await remoteDataSource.getCartData;
        await localDataSource.storeCartData(cart.data!);
        return Right(cart);
      } on NoInternetConnectionException {
        try {
          final cachedCart = await localDataSource.fetchCachedCartData();
          return Right(ApiResponse(data: cachedCart));
        } on CacheException catch (e) {
          return Left(CacheFailure(response: e.response));
        }
      } on AppException catch (e) {
        return Left(e.handleFailure);
      }
    } else {
      try {
        final cachedCart = await localDataSource.fetchCachedCartData();
        return Right(ApiResponse(data: cachedCart));
      } on CacheException catch (e) {
        return Left(CacheFailure(response: e.response));
      }
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
