part of '../data_imports.dart';

class SliderRepositoryImpl implements SliderRepository {
  final SliderRemoteDataSource remoteDataSource;

  const SliderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiResponse<List<Slider>>>> getSliders() async {
    return await remoteDataSource.getSliders.handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<Slider>>> addSlider(AddSliderParams params) async {
    return await remoteDataSource.addSlider(params).handleCallbackWithFailure;
  }
}
