part of '../presentation_imports.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.registerUsecase,
    required this.sendOTPUseCase,
  }) : super(const UserState());

  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final RegisterUsecase registerUsecase;
  final SendOTPUseCase sendOTPUseCase;

  Future<User?> checkForCachedToken() async {
    final cachedToken = await SecureStorage.read(CacheKeys.token);
    if (cachedToken != null && cachedToken.isNotEmpty) {
      final cachedUser = await CacheHelper.read(CacheKeys.user);
      if (cachedUser != null && cachedUser.isNotEmpty) {
        final user = UserModel.fromJson(cachedUser).copyWith(token: cachedToken);
        final apiResponse = ApiResponse<User>.success(data: user);
        emit(state.copyWith(user: apiResponse));
        return user;
      }
    } else {
      await CacheHelper.delete(CacheKeys.user);
    }
    return null;
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
}
