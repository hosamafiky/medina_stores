part of '../domain_imports.dart';

class GetStaticPagesUsecase implements UseCase<ApiResponse<String>, String> {
  final StaticPageRepository repository;

  const GetStaticPagesUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<String>>> call(String param) async {
    return await repository.getStaticPageData(param);
  }
}
