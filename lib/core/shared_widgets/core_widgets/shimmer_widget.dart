import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

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
        child = null;

  const ShimmerWidget.fromChild({
    super.key,
    required this.child,
  })  : _height = null,
        _width = null,
        _boxShape = BoxShape.rectangle,
        _borderRadius = null;

  final double? _height, _width;
  final BoxShape _boxShape;
  final BorderRadiusGeometry? _borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        direction: ShimmerDirection.ltr,
        period: const Duration(seconds: 2),
        child: child ??
            Container(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: _boxShape == BoxShape.circle ? null : _borderRadius ?? BorderRadius.circular(6.r),
                shape: _boxShape,
              ),
            ),
      ),
    );
  }
}
