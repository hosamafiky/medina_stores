import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.title,
    this.actions,
    this.bottom,
    this.toolbarHeight,
    this.centerTitle,
    this.backgroundColor,
    this.titleSpacing,
    this.titleTextStyle,
  });

  final Widget? title;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool? centerTitle;
  final double? titleSpacing, toolbarHeight;
  final TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      bottom: bottom,
      toolbarHeight: toolbarHeight ?? 72.h,
      titleSpacing: titleSpacing,
      titleTextStyle: titleTextStyle,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      surfaceTintColor: Colors.transparent,
      actions: List<Widget>.from(actions ?? [])..add(SizedBox(width: 24.w)),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? 72.h);
}
