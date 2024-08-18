part of 'color_palette.dart';

class DarkModeColorPalette implements ColorPalette {
  const DarkModeColorPalette();

  @override
  Color get primary => const Color(0xFFBB86FC);
  @override
  Color get primaryVariant => const Color(0xFF3700B3);
  @override
  Color get secondary => const Color(0xFF03DAC6);

  @override
  Color get background => const Color(0xFF121212);
  @override
  Color get surface => const Color(0xFF1F1F1F);
  @override
  Color get error => const Color(0xFFCF6679);
  @override
  Color get onBackground => const Color(0xFFFFFFFF);
  @override
  Color get onSurface => const Color(0xFFFFFFFF);

  @override
  Color get primaryText => const Color(0xFFFFFFFF);
  @override
  Color get secondaryText => const Color(0xFFB0B0B0);
  @override
  Color get disabledText => const Color(0xFF757575);
  @override
  Color get hintText => const Color(0xFFA0A0A0);
  @override
  Color get fieldFill => const Color(0xFF333333);

  @override
  Color get accent => const Color(0xFFFF8A65);
  @override
  Color get link => const Color(0xFF82B1FF);

  @override
  Color get divider => const Color(0xFF424242);
  @override
  Color get border => const Color(0xFF616161);
  @override
  Color get shimmerBaseColor => const Color(0xFF333333);
  @override
  Color get shimmerHighlightColor => const Color(0xFF424242);

  @override
  Color get cardBackground => const Color(0xFF1E1E1E);
  @override
  Color get cardShadow => const Color(0x29000000); // Black with 16% opacity

  @override
  Color get currentAdDotColor => const Color(0xFFBB86FC);
  @override
  Color get otherAdDotColor => const Color(0xFF616161);

  @override
  Color get buttonBackground => primary;
  @override
  Color get buttonDisabled => const Color(0xFF424242);
  @override
  Color get buttonText => const Color(0xFF000000);

  @override
  Color get bottomNavigationSelected => primary;
  @override
  Color get bottomNavigationUnselected => const Color(0xFF757575);
  @override
  Color get bottomNavigationBackground => const Color(0xFF121212);

  @override
  Color get success => const Color(0xFF81C784);
  @override
  Color get warning => const Color(0xFFFFD54F);
  @override
  Color get info => const Color(0xFF64B5F6);
}
