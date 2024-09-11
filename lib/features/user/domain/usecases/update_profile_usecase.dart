part of '../domain_imports.dart';

class UpdateProfileUsecase extends UseCase<ApiResponse<void>, UpdateProfileParams> {
  final UserRepository repository;

  UpdateProfileUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<void>>> call(UpdateProfileParams param) async {
    return await repository.updateProfile(param);
  }
}

class UpdateProfileParams {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? dialingCode;

  UserProfile modifiedUserProfile(UserProfile old) => old.copyWith(
        firstName: firstName ?? old.firstName,
        lastName: lastName ?? old.lastName,
        email: email ?? old.email,
        phone: phone ?? old.phone,
        dialingCode: dialingCode ?? old.dialingCode,
        name: "${firstName ?? old.firstName} ${lastName ?? old.lastName}",
      );

  const UpdateProfileParams({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.dialingCode,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": firstName,
      "last_name": lastName,
      "email": email,
      "phone": phone,
      "dialing_code": dialingCode,
    }..removeWhere((key, value) => value == null);
  }
}
