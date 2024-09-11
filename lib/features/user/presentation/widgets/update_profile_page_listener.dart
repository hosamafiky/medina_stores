part of '../presentation_imports.dart';

class UpdateProfilePageListener extends StatelessWidget {
  const UpdateProfilePageListener({
    super.key,
    required this.child,
    required this.onProfileUpdated,
  });

  final Widget child;
  final Function(UserProfile) onProfileUpdated;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      child: child,
      listener: (context, state) async {
        if (state.updateProfileStatus == UsecaseStatus.running ||
            state.logoutStatus == UsecaseStatus.running ||
            state.deleteAccountStatus == UsecaseStatus.running) {
          LoadingManager.show();
        }
        if (state.updateProfileStatus == UsecaseStatus.completed) {
          onProfileUpdated(state.userProfile!.data!);
          LoadingManager.hide();
          MessageHelper.showSuccessSnackBar(state.userProfile!.message);
        }
        if (state.logoutStatus == UsecaseStatus.completed || state.deleteAccountStatus == UsecaseStatus.completed) {
          await Future.wait([
            SecureStorage.delete(CacheKeys.token),
            CacheHelper.delete(CacheKeys.user),
          ]);
          LoadingManager.hide();
          MessageHelper.showSuccessSnackBar(state.user!.message);
          AppNavigator.offAll(const LoginPage());
        }
        if (state.logoutStatus == UsecaseStatus.error || state.updateProfileStatus == UsecaseStatus.error || state.deleteAccountStatus == UsecaseStatus.error) {
          LoadingManager.hide();
          MessageHelper.showErrorSnackBar(state.logoutFailure!.response.message);
        }
      },
    );
  }
}
