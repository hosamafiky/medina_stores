part of '../presentation_imports.dart';

class OtpTimerWidget extends StatefulWidget {
  const OtpTimerWidget({
    super.key,
    required this.user,
  });

  final User? user;

  @override
  State<OtpTimerWidget> createState() => _OtpTimerWidgetState();
}

class _OtpTimerWidgetState extends State<OtpTimerWidget> {
  ValueNotifier<Duration> durationNotifier = ValueNotifier(const Duration(seconds: 59));
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (durationNotifier.value != Duration.zero) {
        durationNotifier.value = Duration(seconds: durationNotifier.value.inSeconds - 1);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final appTextStyles = context.appTextStyle;
    final palette = context.colorPalette;
    return ValueListenableBuilder(
      valueListenable: durationNotifier,
      builder: (context, duration, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: duration != Duration.zero
                  ? null
                  : () {
                      durationNotifier.value = const Duration(seconds: 59);
                      context.read<UserCubit>().sendOTP(
                            SendOTPParams(
                              phone: widget.user!.phone,
                              dialingCode: widget.user!.dialingCode,
                            ),
                          );
                    },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SvgManager.restart.svg(
                  //   width: 22.w,
                  //   height: 22.w,
                  //   color: duration != Duration.zero ? palette.hintText.withOpacity(0.5) : palette.secondary,
                  // ),
                  Text(
                    LocaleKeys.resend_code.tr(),
                    style: appTextStyles.labelTextStyle.copyWith(
                      color: duration != Duration.zero ? palette.hintText.withOpacity(0.5) : palette.secondary,
                    ),
                  ),
                ],
              ).withSpacing(spacing: 2.w),
            ),
            Text(
              duration.formatTime,
              textDirection: TextDirection.ltr,
              style: appTextStyles.labelTextStyle.copyWith(
                fontWeight: AppFontWeight.medium,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ).withSpacing(spacing: 10.w);
      },
    );
  }
}
