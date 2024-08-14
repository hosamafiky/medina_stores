part of '../domain_imports.dart';

class GetSlidersUsecase implements UseCaseWithoutParam<ApiResponse<List<Slider>>> {
  final SliderRepository repository;

  const GetSlidersUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<List<Slider>>>> call() async {
    return await repository.getSliders();
  }
}

