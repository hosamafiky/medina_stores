part of '../domain_imports.dart';

class GetOrdersUsecase implements UseCaseWithoutParam<ApiResponse<List<Order>>> {
  final OrderRepository repository;

  const GetOrdersUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<List<Order>>>> call() async {
    return await repository.getOrders();
  }
}

