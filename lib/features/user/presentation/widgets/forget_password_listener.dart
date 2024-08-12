part of '../presentation_imports.dart';

class ForgetPasswordListener extends StatelessWidget {
  const ForgetPasswordListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        final route = ModalRoute.of(context);
        final isCurrentRoute = route?.isCurrent ?? false;
        if (!isCurrentRoute) return;

        if (state.sendOTPStatus == UsecaseStatus.running) {
          LoadingManager.show();
        }
        if (state.sendOTPStatus == UsecaseStatus.completed && state.user != null) {
          LoadingManager.hide();
          MessageHelper.showSuccessSnackBar(state.user!.message);
          AppNavigator.to(const OtpPage(isResetPassword: true));
        }

        if (state.sendOTPStatus == UsecaseStatus.error && state.sendOTPFailure != null) {
          LoadingManager.hide();
          if (state.sendOTPFailure!.response.errors.isEmpty) MessageHelper.showErrorSnackBar(state.sendOTPFailure!.response.message);
        }
      },
      child: child,
    );
  }
}
