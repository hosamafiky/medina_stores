part of '../data_imports.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource remoteDataSource;
  final InternetConnectionChecker connectionChecker;

  const CheckoutRepositoryImpl({
    required this.remoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, ApiResponse<Checkout>>> getCheckoutData() async {
    if (await connectionChecker.hasConnection) {
      try {
        final checkout = await remoteDataSource.getCheckoutData();
        return Right(checkout);
      } on AppException catch (e) {
        return Left(e.handleFailure);
      }
    } else {
      return Left(NoInternetConnectionFailure(response: ApiResponse(message: LocaleKeys.check_internet.tr())));
    }
  }

  @override
  Future<Either<Failure, ApiResponse<List<PaymentGate>>>> getPaymentGates() async {
    if (await connectionChecker.hasConnection) {
      try {
        final gates = await remoteDataSource.getPaymentGates();
        return Right(gates);
      } on AppException catch (e) {
        return Left(e.handleFailure);
      }
    } else {
      return Left(NoInternetConnectionFailure(response: ApiResponse(message: LocaleKeys.check_internet.tr())));
    }
  }
}
