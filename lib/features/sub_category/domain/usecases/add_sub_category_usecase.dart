part of '../domain_imports.dart';

class AddSubCategoryUsecase implements UseCase<ApiResponse<SubCategory>, AddSubCategoryParams> {
  final SubCategoryRepository repository;

  const AddSubCategoryUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<SubCategory>>> call(AddSubCategoryParams params) async {
    return repository.addSubCategory(params);
  }
}

class AddSubCategoryParams {
  Map<String, dynamic> toMap() {
    return {};
  }
}
