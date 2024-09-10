import 'package:flutter/material.dart';

import '../extensions/context.dart';

class ThemeIconButton extends StatelessWidget {
  const ThemeIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(context.isDark() ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
      onPressed: () {
        context.toggleTheme(false);
      },
    );
  }
}
