part of '../domain_imports.dart';

class VerifyOTPUseCase extends UseCase<ApiResponse<User>, String> {
  final UserRepository repository;

  VerifyOTPUseCase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<User>>> call(String param) async {
    return await repository.verifyOTP(param);
  }
}
