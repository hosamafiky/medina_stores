part of '../data_imports.dart';

class AddressRepositoryImpl implements AddressRepository {
  final InternetConnectionChecker connectionChecker;
  final AddressRemoteDataSource remoteDataSource;
  final AddressLocalDataSource localDataSource;

  const AddressRepositoryImpl({
    required this.connectionChecker,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, ApiResponse<List<Address>>>> getAddresses() async {
    if (await connectionChecker.hasConnection) {
      try {
        final addresses = await remoteDataSource.getAddresses();
        final addressesToCache = addresses.data!.map((address) => AddressModel.fromAddress(address)).toList();
        await localDataSource.cacheAddresses(addressesToCache);
        return Right(addresses);
      } on NoInternetConnectionException {
        try {
          final cachedAddresses = await localDataSource.getCachedAddresss();
          return Right(ApiResponse(data: cachedAddresses));
        } on CacheException catch (e) {
          return Left(CacheFailure(response: e.response));
        }
      } on AppException catch (e) {
        return Left(e.handleFailure);
      }
    } else {
      try {
        final cachedAddresses = await localDataSource.getCachedAddresss();
        return Right(ApiResponse(data: cachedAddresses));
      } on CacheException catch (e) {
        return Left(CacheFailure(response: e.response));
      }
    }
  }

  @override
  Future<Either<Failure, ApiResponse<Address>>> addAddress(AddAddressParams params) async {
    return await remoteDataSource.addAddress(params).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<Address>>> updateAddress(UpdateAddressParams params) async {
    return await remoteDataSource.updateAddress(params).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<void>>> deleteAddress(int id) async {
    return await remoteDataSource.deleteAddress(id).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<Address>>> editAddress(int id) {
    return remoteDataSource.editAddress(id).handleCallbackWithFailure;
  }
}
