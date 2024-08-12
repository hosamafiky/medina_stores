part of 'color_palette.dart';

class LightModeColorPalette implements ColorPalette {
  const LightModeColorPalette();

  @override
  Color get primary => const Color(0xFF6200EE);
  @override
  Color get primaryVariant => const Color(0xFF3700B3);
  @override
  Color get secondary => const Color(0xFF03DAC6);

  @override
  Color get background => const Color(0xFFFFFFFF);
  @override
  Color get surface => const Color(0xFFF5F5F5);
  @override
  Color get error => const Color(0xFFB00020);
  @override
  Color get onBackground => const Color(0xFF000000);
  @override
  Color get onSurface => const Color(0xFF000000);

  @override
  Color get primaryText => const Color(0xFF000000);
  @override
  Color get secondaryText => const Color(0xFF616161);
  @override
  Color get disabledText => const Color(0xFF9E9E9E);
  @override
  Color get hintText => const Color(0xFF757575);
  @override
  Color get fieldFill => const Color(0xFFF5F5F5);

  @override
  Color get accent => const Color(0xFFFF5722);
  @override
  Color get link => const Color(0xFF1E88E5);

  @override
  Color get divider => const Color(0xFFBDBDBD);
  @override
  Color get border => const Color(0xFFE0E0E0);

  @override
  Color get cardBackground => const Color(0xFFFFFFFF);
  @override
  Color get cardShadow => const Color(0x29000000);

  @override
  Color get buttonBackground => primary;
  @override
  Color get buttonDisabled => const Color(0xFFE0E0E0);
  @override
  Color get buttonText => const Color(0xFFFFFFFF);

  @override
  Color get bottomNavigationSelected => primary;
  @override
  Color get bottomNavigationUnselected => const Color(0xFF616161);
  @override
  Color get bottomNavigationBackground => const Color(0xFFFFFFFF);

  @override
  Color get success => const Color(0xFF4CAF50);
  @override
  Color get warning => const Color(0xFFFFC107);
  @override
  Color get info => const Color(0xFF2196F3);
}
