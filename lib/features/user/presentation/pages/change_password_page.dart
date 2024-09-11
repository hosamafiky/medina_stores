part of '../presentation_imports.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text(LocaleKeys.change_password.tr()),
      ),
      body: ChangePasswordListener(
        child: BlocSelector<UserCubit, UserState, Failure?>(
          selector: (state) => state.updateUserPasswordFailure,
          builder: (context, failure) {
            return Padding(
              padding: REdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppTextField.withLabel(
                      controller: _currentPassword,
                      label: LocaleKeys.current_password.tr(),
                      hintText: LocaleKeys.current_password_hint.tr(),
                      prefixIcon: const Icon(Icons.lock),
                      validator: (value) => ValidationHelper.validatePassword(value),
                      errorText: failure?.errorMessage(LocaleKeys.current_password),
                      obscureText: true,
                    ),
                    AppTextField.withLabel(
                      controller: _newPassword,
                      label: LocaleKeys.new_password.tr(),
                      hintText: LocaleKeys.new_password_hint.tr(),
                      prefixIcon: const Icon(Icons.lock),
                      validator: (value) => ValidationHelper.validatePassword(value),
                      errorText: failure?.errorMessage(LocaleKeys.password),
                      obscureText: true,
                    ),
                    AppTextField.withLabel(
                      controller: _confirmPassword,
                      label: LocaleKeys.confirm_password.tr(),
                      hintText: LocaleKeys.confirm_password_hint.tr(),
                      prefixIcon: const Icon(Icons.lock),
                      validator: (value) => ValidationHelper.validateConfirmPassword(value, _newPassword.text),
                      errorText: failure?.errorMessage('password_confirmation'),
                      obscureText: true,
                    ),
                    ElevatedButton(
                      child: Text(LocaleKeys.change_password.tr()),
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        final params = UpdatePasswordParams(
                          currentPassword: _currentPassword.text,
                          newPassword: _newPassword.text,
                          newPasswordConfirmation: _confirmPassword.text,
                        );
                        context.read<UserCubit>().updatePassword(params);
                      },
                    ),
                  ],
                ).withSpacing(spacing: 16.h),
              ),
            );
          },
        ),
      ),
    );
  }
}
