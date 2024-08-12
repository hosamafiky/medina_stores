part of '../presentation_imports.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.registerUsecase,
    required this.sendOTPUseCase,
    required this.verifyOTPUseCase,
  }) : super(const UserState());

  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final RegisterUsecase registerUsecase;
  final SendOTPUseCase sendOTPUseCase;
  final VerifyOTPUseCase verifyOTPUseCase;

  void initWithCachedUser(User? user) {
    if (user == null) return;
    emit(state.copyWith(user: ApiResponse.success(data: user)));
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
    if (state.loginStatus == UsecaseStatus.running) return;
    emit(state.copyWith(loginStatus: UsecaseStatus.running));
    final result = await loginUsecase(params);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(loginStatus: UsecaseStatus.error, loginFailure: failure)),
      (user) => emit(state.copyWith(loginStatus: UsecaseStatus.completed, user: user)),
    );
  }

  Future<void> register(RegisterParams params) async {
    if (state.registerStatus == UsecaseStatus.running) return;
    emit(state.copyWith(registerStatus: UsecaseStatus.running));
    final result = await registerUsecase(params);
    if (isClosed) return;
    result.fold(
      (failure) {
        emit(state.copyWith(registerStatus: UsecaseStatus.error, registerFailure: failure));
      },
      (user) {
        emit(state.copyWith(registerStatus: UsecaseStatus.completed, user: user));
      },
    );
  }

  Future<void> sendOTP(SendOTPParams params) async {
    if (state.sendOTPStatus == UsecaseStatus.running) return;
    emit(state.copyWith(sendOTPStatus: UsecaseStatus.running));
    final result = await sendOTPUseCase(params);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(sendOTPStatus: UsecaseStatus.error, sendOTPFailure: failure)),
      (r) => emit(state.copyWith(sendOTPStatus: UsecaseStatus.completed, user: state.user!.copyWith(message: r.message))),
    );
  }

  Future<void> verifyOTP(String otp) async {
    if (state.verifyOTPStatus == UsecaseStatus.running) return;
    emit(state.copyWith(verifyOTPStatus: UsecaseStatus.running));
    final result = await verifyOTPUseCase(otp);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(verifyOTPStatus: UsecaseStatus.error, verifyOTPFailure: failure)),
      (user) => emit(state.copyWith(verifyOTPStatus: UsecaseStatus.completed, user: user)),
    );
  }
}
