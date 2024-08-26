part of '../domain_imports.dart';

class AddCategoryUsecase implements UseCase<ApiResponse<Category>, AddCategoryParams> {
  final CategoryRepository repository;

  const AddCategoryUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<Category>>> call(AddCategoryParams params) async {
    return repository.addCategory(params);
  }
}

class AddCategoryParams {
  Map<String, dynamic> toMap() {
    return {};
  }
}
