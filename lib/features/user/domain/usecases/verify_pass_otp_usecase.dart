part of '../domain_imports.dart';

class VerifyPassOTPUseCase extends UseCase<ApiResponse<Null>, String> {
  final UserRepository repository;

  VerifyPassOTPUseCase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<Null>>> call(String param) async {
    return await repository.verifyPasswordOTP(param);
  }
}
