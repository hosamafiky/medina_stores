part of '../domain_imports.dart';

class GetPaymentGatesUsecase implements UseCaseWithoutParam<ApiResponse<List<PaymentGate>>> {
  final CartRepository repository;

  GetPaymentGatesUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<List<PaymentGate>>>> call() async {
    return await repository.getPaymentGates();
  }
}
