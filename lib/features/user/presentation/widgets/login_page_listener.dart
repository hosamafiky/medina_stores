part of '../presentation_imports.dart';

class LoginPageListener extends StatelessWidget {
  const LoginPageListener({
    super.key,
    required this.child,
    required this.isContinue,
    required this.emailOrPhoneController,
  });

  final Widget child;
  final bool isContinue;
  final TextEditingController emailOrPhoneController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        final route = ModalRoute.of(context);
        final isCurrentRoute = route?.isCurrent ?? false;
        if (!isCurrentRoute) return;

        if (state.sendOTPStatus == UsecaseStatus.completed) {
          LoadingManager.hide();
          AppNavigator.to(const OtpPage());
        }
        if (state.sendOTPStatus == UsecaseStatus.error && state.sendOTPFailure != null) {
          LoadingManager.hide();
          MessageHelper.showErrorSnackBar(state.sendOTPFailure!.response.message);
        }

        if (state.loginStatus == UsecaseStatus.running) {
          LoadingManager.show();
        }
        if (state.loginStatus == UsecaseStatus.completed && state.user?.data != null) {
          await Future.wait([
            SecureStorage.write(CacheKeys.token, state.user!.data!.token),
            CacheHelper.write(CacheKeys.user, state.user!.data!.modelize.toJson()),
          ]);
          LoadingManager.hide();
          MessageHelper.showSuccessSnackBar(state.user!.message);
          if (isContinue) {
            AppNavigator.pop(true);
            return;
          }
          AppNavigator.offAll(const LayoutPage());
        }

        if (state.loginStatus == UsecaseStatus.error && state.loginFailure != null) {
          if (state.loginFailure!.response.statusCode == 401) {
            if (!context.mounted) return;
            context.read<UserCubit>().sendOTP(SendOTPParams(phone: emailOrPhoneController.text));
          } else {
            LoadingManager.hide();
            if (state.loginFailure!.response.errors.isEmpty) MessageHelper.showErrorSnackBar(state.loginFailure!.response.message);
          }
        }
      },
      child: child,
    );
  }
}
