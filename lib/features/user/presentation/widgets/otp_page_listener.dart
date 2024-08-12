part of '../presentation_imports.dart';

class OtpPageListener extends StatelessWidget {
  const OtpPageListener({super.key, required this.child, required this.otp});

  final Widget child;
  final TextEditingController otp;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        final route = ModalRoute.of(context);
        final isCurrentRoute = route?.isCurrent ?? false;
        if (!isCurrentRoute) return;

        if (state.verifyOTPStatus == UsecaseStatus.running || state.verifyPasswordOTPStatus == UsecaseStatus.running) {
          LoadingManager.show();
        }

        if (state.verifyOTPStatus == UsecaseStatus.completed && state.user?.data != null) {
          await Future.wait([
            CacheHelper.write(CacheKeys.user, state.user!.data!.modelize.toJson()),
            SecureStorage.write(CacheKeys.token, state.user!.data!.token),
          ]);
          LoadingManager.hide();
          MessageHelper.showSuccessSnackBar(state.user!.message);
          AppNavigator.offAll(const LayoutPage());
        }

        if (state.verifyPasswordOTPStatus == UsecaseStatus.completed && state.user?.data != null) {
          LoadingManager.hide();
          MessageHelper.showSuccessSnackBar(state.user!.message);
          AppNavigator.off(ResetPasswordPage(otp: otp.text));
        }

        if (state.verifyOTPStatus == UsecaseStatus.error && state.verifyOTPFailure != null) {
          LoadingManager.hide();
          if (state.verifyOTPFailure!.response.errors.isEmpty) {
            MessageHelper.showErrorSnackBar(state.verifyOTPFailure!.response.message);
          }
        }

        if ((state.verifyPasswordOTPStatus == UsecaseStatus.error && state.verifyPasswordOTPFailure != null)) {
          LoadingManager.hide();
          if (state.verifyPasswordOTPFailure!.response.errors.isEmpty) {
            MessageHelper.showErrorSnackBar(state.verifyPasswordOTPFailure!.response.message);
          }
        }
      },
      child: child,
    );
  }
}
