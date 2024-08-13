part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  const ThemeState({
    this.themeMode = ThemeMode.light,
    required this.colorPalette,
    required this.appTextStyle,
    required this.themeData,
  });

  final ThemeMode themeMode;
  final ColorPalette colorPalette;
  final AppTextStyle appTextStyle;
  final ThemeData themeData;

  bool get isDarkMode => themeMode == ThemeMode.dark;
  ThemeData get lightThemeData => AppTheme.light(colorPalette, appTextStyle);
  ThemeData get darkThemeData => AppTheme.dark(colorPalette, appTextStyle);

  @override
  List<Object> get props => [themeMode];
}

class InitialThemeState extends ThemeState {
  InitialThemeState({
    ThemeMode? initialThemeMode,
  }) : super(
          themeMode: initialThemeMode ?? ThemeMode.light,
          colorPalette: (initialThemeMode ?? ThemeMode.light) == ThemeMode.light ? const LightModeColorPalette() : const DarkModeColorPalette(),
          appTextStyle: (initialThemeMode ?? ThemeMode.light) == ThemeMode.light
              ? const LightAppTextStyles(LightModeColorPalette())
              : const DarkAppTextStyles(DarkModeColorPalette()),
          themeData: (initialThemeMode ?? ThemeMode.light) == ThemeMode.light ? ThemeData.light() : ThemeData.dark(),
        );
}

class UpdateThemeState extends ThemeState {
  const UpdateThemeState({
    super.themeMode,
    required super.colorPalette,
    required super.appTextStyle,
    required super.themeData,
  });
}
