part of '../data_imports.dart';

class SliderRepositoryImpl implements SliderRepository {
  final SliderRemoteDataSource remoteDataSource;

  const SliderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Slider>>>> getSliders() async {
    return await remoteDataSource.getSliders.handleCallbackWithFailure;
  }
}
