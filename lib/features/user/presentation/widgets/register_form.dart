part of '../presentation_imports.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    this.failure,
    required this.formKey,
    required this.fNameController,
    required this.lNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController fNameController;
  final TextEditingController lNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

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
              controller: fNameController,
              keyboardType: TextInputType.name,
              validator: (val) => ValidationHelper.validateName(val, 'First Name'),
              label: 'First Name',
              isMandatory: true,
              hintText: 'Enter your first name',
              errorText: failure.errorMessage('first_name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextField.withLabel(
              controller: lNameController,
              keyboardType: TextInputType.name,
              validator: (val) => ValidationHelper.validateName(val, 'Last Name'),
              label: 'Last Name',
              isMandatory: true,
              hintText: 'Enter your last name',
              errorText: failure.errorMessage('last_name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextField.withLabel(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => ValidationHelper.validateEmail(val, isRequired: false),
              label: LocaleKeys.email.tr(),
              isOptional: true,
              hintText: LocaleKeys.email_hint.tr(),
              errorText: failure.errorMessage('email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextField.withLabel(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              label: LocaleKeys.phone_number.tr(),
              validator: (val) => ValidationHelper.validatePhoneNumber(val),
              isMandatory: true,
              hintText: LocaleKeys.phone_number_hint.tr(),
              errorText: failure.errorMessage('phone'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextField.withLabel(
              controller: passwordController,
              obscuringCharacter: '*',
              enableinteractiveSelection: false,
              isMandatory: true,
              obscureText: true,
              validator: (val) => ValidationHelper.validatePassword(val),
              showPasswordEye: true,
              keyboardType: TextInputType.visiblePassword,
              label: 'Password',
              hintText: 'Enter your password',
              errorText: failure.errorMessage('password'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextField.withLabel(
              controller: confirmPasswordController,
              obscuringCharacter: '*',
              enableinteractiveSelection: false,
              isMandatory: true,
              obscureText: true,
              showPasswordEye: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (val) => ValidationHelper.validateConfirmPassword(val, passwordController.text),
              label: 'Confirm Password',
              hintText: 'Re-enter your password',
              errorText: failure.errorMessage('confirm_password'),
            ),
          ),
        ],
      ),
    );
  }
}
