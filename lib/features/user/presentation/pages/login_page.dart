part of '../presentation_imports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginPageListener(
      emailOrPhoneController: _emailOrPhoneController,
      child: BlocSelector<UserCubit, UserState, ({UsecaseStatus status, Failure? failure})>(
        selector: (state) => (status: state.loginStatus, failure: state.loginFailure),
        builder: (context, state) {
          return Scaffold(
            appBar: const MainAppBar(),
            body: Padding(
              padding: REdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginForm(
                    formKey: _formKey,
                    emailOrPhoneController: _emailOrPhoneController,
                    passwordController: _passwordController,
                    failure: state.failure,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () => AppNavigator.to(const ForgetPasswordPage()),
                      child: Text(LocaleKeys.forgot_password.tr()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        if (state.status == UsecaseStatus.running) return;
                        final params = LoginParams(emailOrPhone: _emailOrPhoneController.text, password: _passwordController.text);
                        context.read<UserCubit>().login(params);
                      },
                      child: Text(LocaleKeys.login.tr()),
                    ),
                  ),
                  const RegisterNowWidget(),
                ],
              ).withSpacing(spacing: 16.h),
            ),
          );
        },
      ),
    );
  }
}
