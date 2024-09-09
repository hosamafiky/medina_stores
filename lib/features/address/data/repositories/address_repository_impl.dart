part of '../data_imports.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource remoteDataSource;

  const AddressRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiResponse<List<Address>>>> getAddresses() async {
    return await remoteDataSource.getAddresses().handleCallbackWithFailure;
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
