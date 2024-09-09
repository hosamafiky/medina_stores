part of '../domain_imports.dart';

abstract class AddressRepository {
  Future<Either<Failure, ApiResponse<List<Address>>>> getAddresses();
  Future<Either<Failure, ApiResponse<Address>>> addAddress(AddAddressParams params);
  Future<Either<Failure, ApiResponse<Address>>> updateAddress(UpdateAddressParams params);
  Future<Either<Failure, ApiResponse<Address>>> editAddress(int id);
  Future<Either<Failure, ApiResponse<void>>> deleteAddress(int id);
}
