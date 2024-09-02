part of '../domain_imports.dart';

abstract class BrandRepository {
  Future<Either<Failure, ApiResponse<List<Brand>>>> getBrands();
}
