part of '../presentation_imports.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return RegisterPageListener(
      child: Scaffold(
        appBar: MainAppBar(title: Text(LocaleKeys.create_account.tr())),
        body: BlocSelector<UserCubit, UserState, ({UsecaseStatus status, Failure? failure})>(
          selector: (state) => (status: state.registerStatus, failure: state.registerFailure),
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RegisterForm(
                      formKey: formKey,
                      fNameController: fNameController,
                      lNameController: lNameController,
                      emailController: emailController,
                      phoneController: phoneController,
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                      failure: state.failure,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          if (state.status == UsecaseStatus.running) return;
                          final params = RegisterParams(
                            dialingCode: '+965',
                            fName: fNameController.text,
                            lName: lNameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            password: passwordController.text,
                            confirmPassword: confirmPasswordController.text,
                          );
                          context.read<UserCubit>().register(params);
                        },
                        child: const Text('Register'),
                      ),
                    ),
                    const LoginNowWidget(),
                  ],
                ).withSpacing(spacing: 16.h),
              ),
            );
          },
        ),
      ),
    );
  }
}
