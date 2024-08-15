part of '../domain_imports.dart';

abstract class SliderRepository {
  Future<Either<Failure, ApiResponse<List<Slider>>>> getSliders();
}