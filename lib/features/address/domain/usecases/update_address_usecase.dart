part of '../domain_imports.dart';

class UpdateAddressUsecase implements UseCase<ApiResponse<Address>, UpdateAddressParams> {
  final AddressRepository repository;

  const UpdateAddressUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<Address>>> call(UpdateAddressParams params) async {
    return repository.updateAddress(params);
  }
}

class UpdateAddressParams {
  final Address address;

  const UpdateAddressParams({required this.address});

  Map<String, dynamic> toMap() {
    return {
      "title": address.title,
      "lat": address.latitude,
      "lon": address.longitude,
    };
  }
}
