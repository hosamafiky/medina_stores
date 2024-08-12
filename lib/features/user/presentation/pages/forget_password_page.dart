part of '../presentation_imports.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ForgetPasswordListener(
      child: Scaffold(
        appBar: MainAppBar(title: Text(LocaleKeys.forgot_password.tr().replaceAll('?|؟', ""))),
        body: BlocSelector<UserCubit, UserState, ({UsecaseStatus status, Failure? failure})>(
          selector: (state) => (
            status: state.sendOTPStatus,
            failure: state.sendOTPFailure,
          ),
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(LocaleKeys.phone_hint.tr()),
                      AppTextField.withLabel(
                        label: LocaleKeys.phone.tr(),
                        controller: _phoneController,
                        hintText: LocaleKeys.phone_hint.tr(),
                        validator: (value) => ValidationHelper.validatePhoneNumber(value),
                        keyboardType: TextInputType.phone,
                        errorText: state.failure.errorMessage(LocaleKeys.phone),
                      ),
                      SizedBox(height: 14.h),
                      ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;
                          if (state.status == UsecaseStatus.running) return;

                          final params = SendOTPParams(phone: _phoneController.text);
                          context.read<UserCubit>().sendOTP(params);
                        },
                        child: Text(LocaleKeys.send.tr()),
                      ),
                    ],
                  ).withSpacing(spacing: 16.h),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
