part of '../presentation_imports.dart';

class RegisterNowWidget extends StatelessWidget {
  const RegisterNowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorPalette palette = context.colorPalette;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: context.tr(LocaleKeys.dont_have_an_account),
            style: TextStyle(
              fontWeight: AppFontWeight.regular,
              fontSize: 12.sp,
              fontFamily: 'Kaff',
              color: palette.hintText,
            ),
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: context.tr(LocaleKeys.create_account),
            style: TextStyle(
              fontWeight: AppFontWeight.regular,
              fontSize: 12.sp,
              decoration: TextDecoration.underline,
              color: palette.secondary,
            ),
            recognizer: TapGestureRecognizer()..onTap = () => AppNavigator.to(const RegisterScreen()),
          ),
        ],
      ),
    );
  }
}
