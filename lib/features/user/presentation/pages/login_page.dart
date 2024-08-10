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
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        if (state.loginStatus == UsecaseStatus.completed && state.user != null) {
          await Future.wait([
            SecureStorage.write(CacheKeys.token, state.user!.token),
            CacheHelper.write(CacheKeys.user, state.user!.modelize.toJson()),
          ]);

          AppNavigator.offAll(const HomePage());
        }

        if (state.loginStatus == UsecaseStatus.error && state.loginFailure != null) {
          MessageHelper.showErrorSnackBar(state.loginFailure!.response.message);
        }
      },
      child: BlocSelector<UserCubit, UserState, ({UsecaseStatus status, Failure? failure})>(
        selector: (state) => (status: state.loginStatus, failure: state.loginFailure),
        builder: (context, state) {
          return Scaffold(
            appBar: MainAppBar(
              actions: [
                IconButton(
                  icon: Icon(context.isDark() ? Icons.dark_mode : Icons.light_mode),
                  onPressed: () {
                    context.toggleTheme(false);
                  },
                ),
              ],
            ),
            body: Column(
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
                      const params = LoginParams(email: 'email', password: 'password');
                      context.read<UserCubit>().login(params);
                    },
                    child: state.status == UsecaseStatus.running ? const CircularProgressIndicator.adaptive() : const Text('Login'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
