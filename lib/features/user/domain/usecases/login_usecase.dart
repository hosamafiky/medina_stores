part of '../domain_imports.dart';

class LoginUsecase implements UseCase<ApiResponse<User>, LoginParams> {
  final UserRepository repository;

  const LoginUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<User>>> call(LoginParams param) async {
    return await repository.login(param);
  }
}

class LoginParams {
  final String emailOrPhone;
  final String password;

  const LoginParams({required this.emailOrPhone, required this.password});

  Map<String, dynamic> toMap() {
    return {
      "email": emailOrPhone,
      'dialing_code': ValidationHelper.isPhone(emailOrPhone) ? '+965' : null,
      "password": password,
    };
  }
}
