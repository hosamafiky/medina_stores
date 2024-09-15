part of '../domain_imports.dart';

class GetCheckoutDataUsecase extends UseCaseWithoutParam<ApiResponse<Checkout>> {
  final CheckoutRepository repository;

  GetCheckoutDataUsecase({required this.repository});
  @override
  Future<Either<Failure, ApiResponse<Checkout>>> call() async {
    return await repository.getCheckoutData();
  }
}
