part of '../presentation_imports.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    this.failure,
    required this.formKey,
    required this.emailOrPhoneController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailOrPhoneController;
  final TextEditingController passwordController;

  final Failure? failure;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextField.withLabel(
            controller: emailOrPhoneController,
            label: LocaleKeys.email_or_phone.tr(),
            isMandatory: true,
            hintText: LocaleKeys.email_or_phone_hint.tr(),
            validator: (val) => ValidationHelper.validateEmailOrPhone(val),
            errorText: failure.errorMessage('email', 'phone'),
          ),
          AppTextField.withLabel(
            controller: passwordController,
            obscuringCharacter: '*',
            isMandatory: true,
            obscureText: true,
            showPasswordEye: true,
            validator: (val) => ValidationHelper.validatePassword(val),
            keyboardType: TextInputType.visiblePassword,
            label: LocaleKeys.password.tr(),
            hintText: LocaleKeys.password_hint.tr(),
            errorText: failure.errorMessage('password'),
          ),
        ],
      ).withSpacing(spacing: 14.h),
    );
  }
}
