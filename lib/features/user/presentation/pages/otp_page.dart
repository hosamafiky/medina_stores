part of '../presentation_imports.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, this.isResetPassword = false});

  final bool isResetPassword;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return OtpPageListener(
      otp: _otpController,
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
                    const Text("Enter OTP sent to your phone"),
                    Pinput(
                      controller: _otpController,
                      length: 6,
                      errorText: state.failure.errorMessage("token"),
                    ),
                    SizedBox(height: 14.h),
                    OtpTimerWidget(
                      user: state.user,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.isResetPassword) {
                          context.read<UserCubit>().verifyPasswordOTP(_otpController.text);
                        } else {
                          context.read<UserCubit>().verifyOTP(_otpController.text);
                        }
                      },
                      child: Text(LocaleKeys.verify.tr()),
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
