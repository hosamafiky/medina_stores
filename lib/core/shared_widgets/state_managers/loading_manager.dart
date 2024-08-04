import 'package:flutter/material.dart';

import '../../../config/resources/color_palettes/color_palette.dart';

class LoadingManager extends StatefulWidget {
  const LoadingManager({
    super.key,
    required this.child,
  });

  final Widget child;

  static void show({bool dismissOnTap = false}) {
    _LoadingManagerState.isLoading.value = true;
    _LoadingManagerState._dismissOnTap = dismissOnTap;
  }

  static void hide() {
    _LoadingManagerState.isLoading.value = false;
  }

  @override
  State<LoadingManager> createState() => _LoadingManagerState();
}

class _LoadingManagerState extends State<LoadingManager> {
  static ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  static bool _dismissOnTap = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoading,
      builder: (BuildContext context, bool value, Widget? child) {
        return Stack(
          children: [
            widget.child,
            if (value)
              GestureDetector(
                onTap: _dismissOnTap ? LoadingManager.hide : null,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation(ColorPalette.whiteColor),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
