part of '../domain_imports.dart';

class GetCartItemsUsecase implements UseCaseWithoutParam<ApiResponse<CartData>> {
  final CartRepository repository;

  const GetCartItemsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<CartData>>> call() async {
    return await repository.getCartData();
  }
}
