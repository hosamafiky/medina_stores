part of '../domain_imports.dart';

class UpdatePasswordUsecase extends UseCase<ApiResponse<void>, UpdatePasswordParams> {
  final UserRepository repository;

  UpdatePasswordUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<void>>> call(UpdatePasswordParams param) async {
    return await repository.updateUserPassword(param);
  }
}

class UpdatePasswordParams {
  final String currentPassword;
  final String newPassword;
  final String newPasswordConfirmation;

  const UpdatePasswordParams({
    required this.currentPassword,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  Map<String, dynamic> toMap() {
    return {
      "current_password": currentPassword,
      "password": newPassword,
      "password_confirmation": newPasswordConfirmation,
    };
  }
}
