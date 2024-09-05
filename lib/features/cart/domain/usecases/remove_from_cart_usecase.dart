part of '../domain_imports.dart';

class RemoveFromCartUsecase extends UseCase<ApiResponse<void>, int> {
  final CartRepository repository;

  RemoveFromCartUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<void>>> call(int param) async {
    return await repository.removeFromCart(param);
  }
}
