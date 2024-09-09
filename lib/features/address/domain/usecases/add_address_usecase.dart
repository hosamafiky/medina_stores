part of '../domain_imports.dart';

class AddAddressUsecase implements UseCase<ApiResponse<Address>, AddAddressParams> {
  final AddressRepository repository;

  const AddAddressUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<Address>>> call(AddAddressParams params) async {
    return repository.addAddress(params);
  }
}

class AddAddressParams {
  final Address address;

  const AddAddressParams({required this.address});

  Map<String, dynamic> toMap() {
    return {
      "title": address.title,
      "lat": address.latitude,
      "lon": address.longitude,
    };
  }
}
