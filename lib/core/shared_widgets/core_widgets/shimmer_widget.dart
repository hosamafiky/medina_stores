import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/resources/color_palettes/color_palette.dart';
import '../../extensions/context.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget.horizontal({
    super.key,
    double? height,
    double? width = double.infinity,
    BorderRadiusGeometry? borderRadius,
    BoxShape boxShape = BoxShape.rectangle,
  })  : _height = height,
        _width = width,
        _boxShape = boxShape,
        isLoading = true,
        _borderRadius = borderRadius,
        child = null;

  const ShimmerWidget.vertical({
    super.key,
    double? width,
    double? height = double.infinity,
    BorderRadiusGeometry? borderRadius,
    BoxShape boxShape = BoxShape.rectangle,
  })  : _width = width,
        _height = height,
        _boxShape = boxShape,
        isLoading = true,
        _borderRadius = borderRadius,
        child = null;

  const ShimmerWidget.circular({
    super.key,
    double? diameter,
    EdgeInsetsGeometry? padding,
  })  : _width = diameter,
        _height = diameter,
        _boxShape = BoxShape.circle,
        _borderRadius = null,
        isLoading = true,
        child = null;

  const ShimmerWidget.fromChild({
    super.key,
    this.isLoading = true,
    required this.child,
  })  : _height = null,
        _width = null,
        _boxShape = BoxShape.rectangle,
        _borderRadius = null;

  final double? _height, _width;
  final BoxShape _boxShape;
  final BorderRadiusGeometry? _borderRadius;
  final Widget? child;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    final isDark = context.isDark();

    if (!isLoading) {
      return child ?? Container();
    }

    return Opacity(
      opacity: 0.5,
      child: Shimmer.fromColors(
        baseColor: palette.shimmerBaseColor,
        highlightColor: palette.shimmerHighlightColor,
        enabled: true,
        direction: context.locale.languageCode == 'en' ? ShimmerDirection.ltr : ShimmerDirection.rtl,
        period: const Duration(seconds: 2),
        child: child ??
            Container(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: isDark ? ColorPalette.whiteColor.withOpacity(0.5) : ColorPalette.whiteColor,
                borderRadius: _boxShape == BoxShape.circle ? null : _borderRadius ?? BorderRadius.circular(10.r),
                shape: _boxShape,
              ),
            ),
      ),
    );
  }
}
