part of '../domain_imports.dart';

class ResetPasswordUseCase extends UseCase<ApiResponse<Null>, ResetPasswordParams> {
  final UserRepository repository;

  ResetPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<Null>>> call(ResetPasswordParams param) async {
    return await repository.resetPassword(param);
  }
}

class ResetPasswordParams {
  final String password;
  final String passwordConfirm;
  final String token;

  const ResetPasswordParams({
    required this.password,
    required this.passwordConfirm,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      "token": token,
      "password": password,
      "password_confirmation": passwordConfirm,
    };
  }
}
