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
  final String title;
  final double latitude;
  final double longitude;

  const AddAddressParams({required this.title, required this.latitude, required this.longitude});

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "lat": latitude,
      "lon": longitude,
    };
  }
}
