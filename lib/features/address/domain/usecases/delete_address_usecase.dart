part of '../domain_imports.dart';

class DeleteAddressUsecase implements UseCase<ApiResponse<void>, int> {
  final AddressRepository repository;

  const DeleteAddressUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<void>>> call(int param) async {
    return repository.deleteAddress(param);
  }
}
