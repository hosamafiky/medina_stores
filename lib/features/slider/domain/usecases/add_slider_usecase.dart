part of '../domain_imports.dart';

class AddSliderUsecase implements UseCase<ApiResponse<Slider>, AddSliderParams> {
  final SliderRepository repository;

  const AddSliderUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<Slider>>> call(AddSliderParams params) async {
    return repository.addSlider(params);
  }
}

class AddSliderParams {
  Map<String, dynamic> toMap() {
    return {};
  }
}
