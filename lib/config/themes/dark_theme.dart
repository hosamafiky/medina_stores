part of 'app_themes.dart';

ThemeData darkTheme(
  ColorPalette palette,
  AppTextStyle appTextStyle,
) {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: palette.primary,
    primaryColorDark: palette.primaryVariant,
    secondaryHeaderColor: palette.secondary,
    scaffoldBackgroundColor: palette.background,
    dividerColor: palette.divider,
    cardColor: palette.cardBackground,
    shadowColor: palette.cardShadow,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: const IconThemeData(color: ColorPalette.whiteColor),
      actionsIconTheme: const IconThemeData(color: ColorPalette.whiteColor),
      titleTextStyle: appTextStyle.appBarTitleStyle,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ColorPalette.whiteColor,
    ),
    checkboxTheme: const CheckboxThemeData(
      visualDensity: VisualDensity.compact,
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      visualDensity: VisualDensity.compact,
      dense: true,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: palette.background,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: palette.bottomNavigationSelected,
      unselectedItemColor: palette.bottomNavigationUnselected,
      selectedLabelStyle: appTextStyle.bottomNavigationSelectedLabelStyle,
      unselectedLabelStyle: appTextStyle.bottomNavigationUnselectedLabelStyle,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 16.w),
      labelStyle: appTextStyle.labelTextStyle,
      hintStyle: appTextStyle.hintTextStyle,
      errorStyle: appTextStyle.errorStyle,
      fillColor: palette.fieldFill,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: palette.border, width: 1.sp),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: palette.border, width: 1.sp),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: palette.error, width: 1.sp),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: palette.error, width: 1.sp),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(WidgetState.disabled)) return palette.buttonDisabled;
            return palette.buttonBackground;
          },
        ),
        textStyle: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) return appTextStyle.textButtonDisabledTextStyle;
            return appTextStyle.textButtonTextStyle;
          },
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w)),
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(WidgetState.disabled)) return palette.buttonDisabled;
            return palette.buttonBackground;
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(WidgetState.disabled)) return palette.disabledText;
            return palette.buttonText;
          },
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
        minimumSize: WidgetStatePropertyAll(Size(1.sw, 50.h)),
        maximumSize: WidgetStatePropertyAll(Size(1.sw, 50.h)),
        textStyle: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) return appTextStyle.disabledElevatedButtonStyle;
            return appTextStyle.elevatedButtonTextStyle;
          },
        ),
      ),
    ),
  );
}
