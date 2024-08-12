part of '../presentation_imports.dart';

class ResetPasswordListener extends StatelessWidget {
  const ResetPasswordListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        final route = ModalRoute.of(context);
        final isCurrentRoute = route?.isCurrent ?? false;
        if (!isCurrentRoute) return;

        if (state.resetPasswordStatus == UsecaseStatus.running) {
          LoadingManager.show();
        }
        if (state.resetPasswordStatus == UsecaseStatus.completed && state.user != null) {
          LoadingManager.hide();
          MessageHelper.showSuccessSnackBar(state.user!.message);
          AppNavigator.offAll(const LoginPage());
        }

        if (state.resetPasswordStatus == UsecaseStatus.error && state.resetPasswordFailure != null) {
          LoadingManager.hide();
          if (state.resetPasswordFailure!.response.errors.isEmpty) {
            MessageHelper.showErrorSnackBar(state.resetPasswordFailure!.response.message);
          }
        }
      },
      child: child,
    );
  }
}
