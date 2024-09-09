part of '../domain_imports.dart';

class GetProductNameSuggestionsUsecase extends UseCase<ApiResponse<List<DropdownItem>>, String> {
  final ProductRepository repository;

  GetProductNameSuggestionsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<List<DropdownItem>>>> call(String param) async {
    return await repository.getProductNameSuggestions(param);
  }
}
