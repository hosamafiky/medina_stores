part of '../presentation_imports.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    this.failure,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final Failure? failure;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextField.withLabel(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              label: LocaleKeys.email.tr(),
              isMandatory: true,
              hintText: LocaleKeys.email_hint.tr(),
              validator: (val) => ValidationHelper.validateEmail(val),
              errorText: failure.errorMessage('email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextField.withLabel(
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
          ),
        ],
      ),
    );
  }
}
