part of '../data_imports.dart';

class BrandRepositoryImpl implements BrandRepository {
  final BrandRemoteDataSource remoteDataSource;

  const BrandRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiResponse<List<Brand>>>> getBrands() async {
    return await remoteDataSource.getBrands.handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<Brand>>> addBrand(AddBrandParams params) async {
    return await remoteDataSource.addBrand(params).handleCallbackWithFailure;
  }
}
