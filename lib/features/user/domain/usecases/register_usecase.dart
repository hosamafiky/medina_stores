part of '../domain_imports.dart';

class RegisterUsecase extends UseCase<ApiResponse<User>, RegisterParams> {
  RegisterUsecase({
    required this.repository,
  });

  final UserRepository repository;

  @override
  Future<Either<Failure, ApiResponse<User>>> call(RegisterParams param) async {
    return await repository.register(param);
  }
}

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.fName,
    required this.lName,
    required this.email,
    required this.dialingCode,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  final String fName;
  final String lName;
  final String email;
  final String phone;
  final String dialingCode;
  final String password;
  final String confirmPassword;

  Map<String, dynamic> toMap() {
    return {
      "name": fName,
      "last_name": lName,
      "phone": phone,
      "dialing_code": dialingCode,
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword,
      "country_id": 1
    };
  }

  @override
  List<Object?> get props => [fName, lName, email, phone, password, confirmPassword];
}
