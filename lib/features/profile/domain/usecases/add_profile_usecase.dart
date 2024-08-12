part of '../domain_imports.dart';

class AddProfileUsecase implements UseCase<ApiResponse<Profile>, AddProfileParams> {
  final ProfileRepository repository;

  const AddProfileUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<Profile>>> call(AddProfileParams params) async {
    return repository.addProfile(params);
  }
}

class AddProfileParams {
  Map<String, dynamic> toMap() {
    return {};
  }
}
