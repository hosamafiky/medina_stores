part of '../domain_imports.dart';

class ToggleFavoriteUsecase extends UseCase<ApiResponse<bool>, int> {
  final ProductRepository repository;

  ToggleFavoriteUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<bool>>> call(int param) async {
    return await repository.toggleFavorite(param);
  }
}
