import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Sheet on BuildContext {
  Future<T?> showSheet<T>({
    required Widget child,
    Color? backgroundColor,
    bool useSafeArea = true,
    bool isDismissible = true,
    bool isDraggable = true,
    bool isScrollControlled = true,
    AnimationController? transitionAnimationController,
  }) async =>
      await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.r),
            topLeft: Radius.circular(30.r),
          ),
        ),
        context: this,
        backgroundColor: backgroundColor,
        useSafeArea: useSafeArea,
        isDismissible: isDismissible,
        enableDrag: isDraggable,
        isScrollControlled: isScrollControlled,
        transitionAnimationController: transitionAnimationController,
        // ignore: deprecated_member_use
        builder: (context) => WillPopScope(
          onWillPop: () async => isDismissible,
          child: child,
        ),
      );
}
