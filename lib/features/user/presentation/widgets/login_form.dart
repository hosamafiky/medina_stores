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
              label: 'Email or Phone number',
              isMandatory: true,
              hintText: 'Enter your email or phone number',
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
              keyboardType: TextInputType.visiblePassword,
              label: 'Password',
              hintText: 'Enter your password',
              errorText: failure.errorMessage('password'),
            ),
          ),
        ],
      ),
    );
  }
}
