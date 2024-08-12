part of '../presentation_imports.dart';

class ProfilePageListener extends StatelessWidget {
  const ProfilePageListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        if (state.logoutStatus == UsecaseStatus.running) {
          LoadingManager.show();
        }
        if (state.logoutStatus == UsecaseStatus.completed) {
          await Future.wait([
            SecureStorage.delete(CacheKeys.token),
            CacheHelper.delete(CacheKeys.user),
          ]);
          LoadingManager.hide();
          MessageHelper.showSuccessSnackBar(state.user!.message);
          AppNavigator.offAll(const LoginPage());
        }
        if (state.logoutStatus == UsecaseStatus.error) {
          LoadingManager.hide();
          MessageHelper.showErrorSnackBar(state.logoutFailure!.response.message);
        }
      },
      child: child,
    );
  }
}
