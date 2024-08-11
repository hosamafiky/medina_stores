part of '../domain_imports.dart';

class SendOTPUseCase extends UseCase<ApiResponse<Null>, SendOTPParams> {
  final UserRepository repository;

  SendOTPUseCase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<Null>>> call(SendOTPParams param) async {
    return await repository.sendOTP(param);
  }
}

class SendOTPParams extends Equatable {
  final String phone;
  final String dialingCode;

  const SendOTPParams({
    this.phone = '',
    this.dialingCode = '+965',
  });

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'dialing_code': dialingCode,
    };
  }

  @override
  List<Object?> get props => [phone, dialingCode];
}
