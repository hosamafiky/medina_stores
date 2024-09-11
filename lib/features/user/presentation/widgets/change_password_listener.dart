part of '../presentation_imports.dart';

class ChangePasswordListener extends StatelessWidget {
  const ChangePasswordListener({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      child: child,
      listener: (context, state) {
        if (state.updateUserPasswordStatus == UsecaseStatus.running) {
          LoadingManager.show();
        }
        if (state.updateUserPasswordStatus == UsecaseStatus.completed) {
          LoadingManager.hide();
          MessageHelper.showSuccessSnackBar(state.updateUserPasswordResponse!.message);
          AppNavigator.pop();
        }

        if (state.updateUserPasswordStatus == UsecaseStatus.error) {
          LoadingManager.hide();
          if (state.updateUserPasswordFailure!.response.errors.isEmpty) {
            MessageHelper.showErrorSnackBar(state.updateUserPasswordFailure!.response.message);
          }
        }
      },
    );
  }
}
