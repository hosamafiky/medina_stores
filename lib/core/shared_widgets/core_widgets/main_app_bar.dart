import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions = const [],
    this.padEnd = true,
    this.bottom,
    this.toolbarHeight,
    this.centerTitle,
    this.backgroundColor,
    this.titleSpacing,
    this.titleTextStyle,
  });

  final Widget? title, leading;
  final PreferredSizeWidget? bottom;
  final List<Widget> actions;
  final Color? backgroundColor;
  final bool? centerTitle;
  final bool padEnd;
  final double? titleSpacing, toolbarHeight;
  final TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: leading,
      bottom: bottom,
      toolbarHeight: toolbarHeight ?? kToolbarHeight,
      titleSpacing: titleSpacing,
      titleTextStyle: titleTextStyle,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      surfaceTintColor: Colors.transparent,
      actions: padEnd ? [...actions, SizedBox(width: 16.w)] : actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}
