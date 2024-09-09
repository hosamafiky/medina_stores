part of '../domain_imports.dart';

class GetAddressesUsecase implements UseCaseWithoutParam<ApiResponse<List<Address>>> {
  final AddressRepository repository;

  const GetAddressesUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<List<Address>>>> call() async {
    return await repository.getAddresses();
  }
}
