part of '../presentation_imports.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.registerUsecase,
    required this.sendOTPUsecase,
    required this.verifyOTPUsecase,
    required this.verifyPassOTPUsecase,
    required this.resetPasswordUsecase,
  }) : super(const UserState());

  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final RegisterUsecase registerUsecase;
  final SendOTPUseCase sendOTPUsecase;
  final VerifyOTPUseCase verifyOTPUsecase;
  final VerifyPassOTPUseCase verifyPassOTPUsecase;
  final ResetPasswordUseCase resetPasswordUsecase;

  void initWithCachedUser(User? user) {
    if (user == null) return;
    emit(state.copyWith(user: ApiResponse(data: user)));
  }

  Future<void> logout() async {
    emit(state.copyWith(logoutStatus: UsecaseStatus.running));
    final result = await logoutUsecase();
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(logoutStatus: UsecaseStatus.error, logoutFailure: failure)),
      (response) => emit(state.copyWith(logoutStatus: UsecaseStatus.completed, user: response)),
    );
  }

  Future<void> login(LoginParams params) async {
    emit(state.copyWith(loginStatus: UsecaseStatus.running));
    final result = await loginUsecase(params);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(loginStatus: UsecaseStatus.error, loginFailure: failure)),
      (user) => emit(state.copyWith(loginStatus: UsecaseStatus.completed, user: user)),
    );
  }

  Future<void> register(RegisterParams params) async {
    emit(state.copyWith(registerStatus: UsecaseStatus.running));
    final result = await registerUsecase(params);
    if (isClosed) return;
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            registerStatus: UsecaseStatus.error,
            registerFailure: failure,
          ),
        );
      },
      (user) {
        emit(
          state.copyWith(
            registerStatus: UsecaseStatus.completed,
            user: user,
          ),
        );
      },
    );
  }

  Future<void> sendOTP(SendOTPParams params) async {
    if (state.sendOTPStatus == UsecaseStatus.running) return;
    emit(state.copyWith(sendOTPStatus: UsecaseStatus.running));
    final result = await sendOTPUsecase(params);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(sendOTPStatus: UsecaseStatus.error, sendOTPFailure: failure)),
      (r) => emit(
        state.copyWith(
          sendOTPStatus: UsecaseStatus.completed,
          user: ApiResponse(message: r.message, data: User(phone: params.phone, dialingCode: params.dialingCode)),
        ),
      ),
    );
  }

  Future<void> verifyOTP(String otp) async {
    if (state.verifyOTPStatus == UsecaseStatus.running) return;
    emit(state.copyWith(verifyOTPStatus: UsecaseStatus.running));
    final result = await verifyOTPUsecase(otp);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(verifyOTPStatus: UsecaseStatus.error, verifyOTPFailure: failure)),
      (user) => emit(state.copyWith(verifyOTPStatus: UsecaseStatus.completed, user: user)),
    );
  }

  Future<void> verifyPasswordOTP(String otp) async {
    if (state.verifyPasswordOTPStatus == UsecaseStatus.running) return;
    emit(state.copyWith(verifyPasswordOTPStatus: UsecaseStatus.running));
    final result = await verifyPassOTPUsecase(otp);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(verifyPasswordOTPStatus: UsecaseStatus.error, verifyPasswordOTPFailure: failure)),
      (r) => emit(state.copyWith(verifyPasswordOTPStatus: UsecaseStatus.completed, user: state.user == null ? r : state.user!.copyWith(message: r.message))),
    );
  }

  Future<void> resetPassword(ResetPasswordParams params) async {
    if (state.resetPasswordStatus == UsecaseStatus.running) return;
    emit(state.copyWith(resetPasswordStatus: UsecaseStatus.running));
    final result = await resetPasswordUsecase(params);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(resetPasswordStatus: UsecaseStatus.error, resetPasswordFailure: failure)),
      (r) => emit(state.copyWith(resetPasswordStatus: UsecaseStatus.completed, user: state.user == null ? r : state.user!.copyWith(message: r.message))),
    );
  }
}
