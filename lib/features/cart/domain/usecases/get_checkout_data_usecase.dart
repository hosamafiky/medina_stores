part of '../domain_imports.dart';

class GetCheckoutDataUsecase extends UseCaseWithoutParam<ApiResponse<CheckoutData>> {
  final CartRepository repository;

  GetCheckoutDataUsecase({required this.repository});
  @override
  Future<Either<Failure, ApiResponse<CheckoutData>>> call() async {
    return await repository.getCheckoutData();
  }
}
