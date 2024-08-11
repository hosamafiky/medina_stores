part of '../presentation_imports.dart';

class LoginPageListener extends StatelessWidget {
  const LoginPageListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        if (state.loginStatus == UsecaseStatus.running) {
          LoadingManager.show(dismissOnTap: true);
        }
        if (state.loginStatus == UsecaseStatus.completed && state.user?.data != null) {
          await Future.wait([
            SecureStorage.write(CacheKeys.token, state.user!.data!.token),
            CacheHelper.write(CacheKeys.user, state.user!.data!.modelize.toJson()),
          ]);
          LoadingManager.hide();
          MessageHelper.showSuccessSnackBar(state.user!.message);
          AppNavigator.offAll(const HomePage());
        }

        if (state.loginStatus == UsecaseStatus.error && state.loginFailure != null) {
          LoadingManager.hide();
          if (state.loginFailure!.response.errors.isEmpty) MessageHelper.showErrorSnackBar(state.loginFailure!.response.message);
        }
      },
      child: child,
    );
  }
}
