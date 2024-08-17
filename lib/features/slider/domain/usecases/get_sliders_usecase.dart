part of '../domain_imports.dart';

class GetSlidersUsecase implements UseCaseWithoutParam<ApiResponse<PaginatedList<Slider>>> {
  final SliderRepository repository;

  const GetSlidersUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Slider>>>> call() async {
    return await repository.getSliders();
  }
}
