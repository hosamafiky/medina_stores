part of '../presentation_imports.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, required this.otp});

  final String otp;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text(LocaleKeys.reset_password.tr()),
      ),
      body: ResetPasswordListener(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                const Text("Enter your new password"),
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppTextField.withLabel(
                            label: LocaleKeys.password.tr(),
                            controller: _passwordController,
                            hintText: LocaleKeys.password_hint.tr(),
                            validator: (value) => ValidationHelper.validatePassword(value),
                            keyboardType: TextInputType.visiblePassword,
                            errorText: state.resetPasswordFailure.errorMessage(LocaleKeys.password),
                          ),
                          AppTextField.withLabel(
                            label: LocaleKeys.confirm_password.tr(),
                            controller: _confirmPasswordController,
                            hintText: LocaleKeys.confirm_password_hint.tr(),
                            validator: (value) => ValidationHelper.validateConfirmPassword(value, _passwordController.text),
                            keyboardType: TextInputType.visiblePassword,
                            errorText: state.resetPasswordFailure.errorMessage(LocaleKeys.confirm_password),
                          ),
                          SizedBox(height: 14.h),
                          ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) return;
                              if (state.resetPasswordStatus == UsecaseStatus.running) return;
                              final params = ResetPasswordParams(
                                token: widget.otp,
                                password: _passwordController.text,
                                passwordConfirm: _confirmPasswordController.text,
                              );
                              context.read<UserCubit>().resetPassword(params);
                            },
                            child: Text(LocaleKeys.reset_password.tr()),
                          ),
                        ],
                      ).withSpacing(spacing: 16.h),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
