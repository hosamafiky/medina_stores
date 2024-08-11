part of '../presentation_imports.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        if (state.verifyOTPStatus == UsecaseStatus.running) {
          LoadingManager.show();
        }

        if (state.verifyOTPStatus == UsecaseStatus.completed && state.user?.data != null) {
          await Future.wait([
            CacheHelper.write(CacheKeys.user, state.user!.data!.modelize.toJson()),
            SecureStorage.write(CacheKeys.token, state.user!.data!.token),
          ]);
          LoadingManager.hide();
          MessageHelper.showSuccessSnackBar(state.user!.message);
          AppNavigator.to(const HomePage());
        }

        if (state.verifyOTPStatus == UsecaseStatus.error && state.verifyOTPFailure != null) {
          LoadingManager.hide();
          if (state.verifyOTPFailure!.response.errors.isEmpty) {
            MessageHelper.showErrorSnackBar(state.verifyOTPFailure!.response.message);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.activation_code.tr()),
        ),
        body: BlocSelector<UserCubit, UserState, ({UsecaseStatus status, Failure? failure, User? user})>(
          selector: (state) => (
            status: state.verifyOTPStatus,
            failure: state.verifyOTPFailure,
            user: state.user?.data,
          ),
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    const Text("Enter OTP"),
                    Pinput(
                      controller: _otpController,
                      length: 6,
                      errorText: state.failure.errorMessage("token"),
                    ),
                    SizedBox(height: 14.h),
                    OtpTimerWidget(user: state.user),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserCubit>().verifyOTP(_otpController.text);
                      },
                      child: const Text("Verify"),
                    ),
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
