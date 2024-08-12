part of '../domain_imports.dart';

class AddOrderUsecase implements UseCase<ApiResponse<Order>, AddOrderParams> {
  final OrderRepository repository;

  const AddOrderUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<Order>>> call(AddOrderParams params) async {
    return repository.addOrder(params);
  }
}

class AddOrderParams {
  Map<String, dynamic> toMap() {
    return {};
  }
}
