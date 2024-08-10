part of '../presentation_imports.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required this.getUsersUsecase,
  }) : super(const UserState());

  final LoginUsecase getUsersUsecase;

  Future<void> checkForCachedToken() async {
    final cachedToken = await SecureStorage.read(CacheKeys.token);
    if (cachedToken != null && cachedToken.isNotEmpty) {
      final cachedUser = await CacheHelper.read(CacheKeys.user);
      if (cachedUser != null && cachedUser.isNotEmpty) {
        emit(state.copyWith(user: UserModel.fromJson(cachedUser).copyWith(token: cachedToken)));
      }
    } else {
      await CacheHelper.delete(CacheKeys.user);
    }
  }

  Future<void> login(LoginParams params) async {
    emit(state.copyWith(loginStatus: UsecaseStatus.running));
    final result = await getUsersUsecase(params);
    if (isClosed) return;
    result.fold(
      (failure) {
        emit(state.copyWith(loginStatus: UsecaseStatus.error, loginFailure: failure));
      },
      (user) {
        emit(state.copyWith(loginStatus: UsecaseStatus.completed, user: user.data));
      },
    );
  }
}
