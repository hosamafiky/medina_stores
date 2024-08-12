part of '../presentation_imports.dart';

class RegisterPageListener extends StatelessWidget {
  const RegisterPageListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        final route = ModalRoute.of(context);
        final isCurrentRoute = route?.isCurrent ?? false;
        if (!isCurrentRoute) return;

        if (state.sendOTPStatus == UsecaseStatus.completed) {
          LoadingManager.hide();
          MessageHelper.showSuccessSnackBar(state.user!.message);
          AppNavigator.to(const OtpPage());
        }

        if (state.sendOTPStatus == UsecaseStatus.error && state.sendOTPFailure != null) {
          LoadingManager.hide();
          MessageHelper.showErrorSnackBar(state.sendOTPFailure!.response.message);
        }

        if (state.registerStatus == UsecaseStatus.running) {
          LoadingManager.show(dismissOnTap: true);
        }
        if (state.registerStatus == UsecaseStatus.completed && state.user?.data != null) {
          await Future.wait([
            CacheHelper.write(CacheKeys.user, state.user!.data!.modelize.toJson()),
          ]);
          final params = SendOTPParams(
            phone: state.user!.data!.phone,
            dialingCode: state.user!.data!.dialingCode,
          );
          if (!context.mounted) return;
          context.read<UserCubit>().sendOTP(params);
        }

        if (state.registerStatus == UsecaseStatus.error && state.registerFailure != null) {
          LoadingManager.hide();
          if (state.registerFailure!.response.errors.isEmpty) MessageHelper.showErrorSnackBar(state.registerFailure!.response.message);
        }
      },
      child: child,
    );
  }
}
