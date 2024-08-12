part of '../presentation_imports.dart';

class RegisterForm extends StatefulWidget {
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
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  ValueNotifier<bool> acceptTerms = ValueNotifier(false);
  void toggleAcceptance() => acceptTerms.value = !acceptTerms.value;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextField.withLabel(
              controller: widget.fNameController,
              keyboardType: TextInputType.name,
              validator: (val) => ValidationHelper.validateName(val, 'First Name'),
              label: 'First Name',
              isMandatory: true,
              hintText: 'Enter your first name',
              errorText: widget.failure.errorMessage('first_name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextField.withLabel(
              controller: widget.lNameController,
              keyboardType: TextInputType.name,
              validator: (val) => ValidationHelper.validateName(val, 'Last Name'),
              label: 'Last Name',
              isMandatory: true,
              hintText: 'Enter your last name',
              errorText: widget.failure.errorMessage('last_name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextField.withLabel(
              controller: widget.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => ValidationHelper.validateEmail(val, isRequired: false),
              label: LocaleKeys.email.tr(),
              isOptional: true,
              hintText: LocaleKeys.email_hint.tr(),
              errorText: widget.failure.errorMessage('email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextField.withLabel(
              controller: widget.phoneController,
              keyboardType: TextInputType.phone,
              label: LocaleKeys.phone_number.tr(),
              validator: (val) => ValidationHelper.validatePhoneNumber(val),
              isMandatory: true,
              hintText: LocaleKeys.phone_number_hint.tr(),
              errorText: widget.failure.errorMessage('phone'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextField.withLabel(
              controller: widget.passwordController,
              obscuringCharacter: '*',
              enableinteractiveSelection: false,
              isMandatory: true,
              obscureText: true,
              validator: (val) => ValidationHelper.validatePassword(val),
              showPasswordEye: true,
              keyboardType: TextInputType.visiblePassword,
              label: 'Password',
              hintText: 'Enter your password',
              errorText: widget.failure.errorMessage('password'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextField.withLabel(
              controller: widget.confirmPasswordController,
              obscuringCharacter: '*',
              enableinteractiveSelection: false,
              isMandatory: true,
              obscureText: true,
              showPasswordEye: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (val) => ValidationHelper.validateConfirmPassword(val, widget.passwordController.text),
              label: 'Confirm Password',
              hintText: 'Re-enter your password',
              errorText: widget.failure.errorMessage('confirm_password'),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: acceptTerms,
            builder: (context, isAccepted, child) {
              return CheckboxListTile(
                value: isAccepted,
                onChanged: (_) => toggleAcceptance(),
                title: Text(LocaleKeys.accept_terms.tr()),
              ).asFormField(validator: (_) => !isAccepted ? LocaleKeys.terms_validation.tr() : null);
            },
          ),
        ],
      ),
    );
  }
}
