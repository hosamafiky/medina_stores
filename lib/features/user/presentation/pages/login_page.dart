part of '../presentation_imports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginPageListener(
      child: BlocSelector<UserCubit, UserState, ({UsecaseStatus status, Failure? failure})>(
        selector: (state) => (status: state.loginStatus, failure: state.loginFailure),
        builder: (context, state) {
          return Scaffold(
            appBar: MainAppBar(
              actions: [
                IconButton(
                  icon: Icon(
                    context.isDark() ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                  ),
                  onPressed: () {
                    context.toggleTheme(false);
                  },
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginForm(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  failure: state.failure,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      if (state.status == UsecaseStatus.running) return;
                      final params = LoginParams(email: _emailController.text, password: _passwordController.text);
                      context.read<UserCubit>().login(params);
                    },
                    child: const Text('Login'),
                  ),
                ),
                const RegisterNowWidget(),
              ],
            ).withSpacing(spacing: 16.h),
          );
        },
      ),
    );
  }
}
