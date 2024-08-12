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
          AppTextField.withLabel(
            controller: widget.fNameController,
            keyboardType: TextInputType.name,
            validator: (val) => ValidationHelper.validateName(val, LocaleKeys.first_name.tr()),
            label: LocaleKeys.first_name.tr(),
            isMandatory: true,
            hintText: LocaleKeys.first_name_hint.tr(),
            errorText: widget.failure.errorMessage('name'),
          ),
          AppTextField.withLabel(
            controller: widget.lNameController,
            keyboardType: TextInputType.name,
            validator: (val) => ValidationHelper.validateName(val, LocaleKeys.last_name.tr()),
            label: LocaleKeys.last_name.tr(),
            isMandatory: true,
            hintText: LocaleKeys.last_name_hint.tr(),
            errorText: widget.failure.errorMessage(LocaleKeys.last_name),
          ),
          AppTextField.withLabel(
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (val) => ValidationHelper.validateEmail(val, isRequired: false),
            label: LocaleKeys.email.tr(),
            isMandatory: false,
            isOptional: true,
            hintText: LocaleKeys.email_hint.tr(),
            errorText: widget.failure.errorMessage(LocaleKeys.email),
          ),
          AppTextField.withLabel(
            controller: widget.phoneController,
            keyboardType: TextInputType.phone,
            label: LocaleKeys.phone.tr(),
            validator: (val) => ValidationHelper.validatePhoneNumber(val),
            isMandatory: true,
            hintText: LocaleKeys.phone_hint.tr(),
            errorText: widget.failure.errorMessage(LocaleKeys.phone),
          ),
          AppTextField.withLabel(
            controller: widget.passwordController,
            obscuringCharacter: '*',
            enableinteractiveSelection: false,
            isMandatory: true,
            obscureText: true,
            validator: (val) => ValidationHelper.validatePassword(val),
            showPasswordEye: true,
            keyboardType: TextInputType.visiblePassword,
            label: LocaleKeys.password.tr(),
            hintText: LocaleKeys.password_hint.tr(),
            errorText: widget.failure.errorMessage(LocaleKeys.password),
          ),
          AppTextField.withLabel(
            controller: widget.confirmPasswordController,
            obscuringCharacter: '*',
            enableinteractiveSelection: false,
            isMandatory: true,
            obscureText: true,
            showPasswordEye: true,
            keyboardType: TextInputType.visiblePassword,
            validator: (val) => ValidationHelper.validateConfirmPassword(val, widget.passwordController.text),
            label: LocaleKeys.confirm_password.tr(),
            hintText: LocaleKeys.confirm_password_hint.tr(),
            errorText: widget.failure.errorMessage(LocaleKeys.confirm_password),
          ),
          ValueListenableBuilder(
            valueListenable: acceptTerms,
            builder: (context, isAccepted, child) {
              return CheckboxListTile(
                value: isAccepted,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (_) => toggleAcceptance(),
                title: Text(LocaleKeys.accept_terms.tr()),
              ).asFormField(validator: (_) => !isAccepted ? LocaleKeys.accept_terms_validation.tr() : null);
            },
          ),
        ],
      ).withSpacing(spacing: 14.h),
    );
  }
}
