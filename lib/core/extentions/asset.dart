import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

extension AssetExt on String {
  Widget svg({
    double? width,
    double? height,
    Color? color,
    AlignmentGeometry alignment = Alignment.center,
    BoxFit fit = BoxFit.contain,
  }) {
    assert(endsWith('.svg'), 'AssetExt: $this is not an svg file');
    return SvgPicture.asset(
      this,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  Widget lottie({
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
  }) {
    assert(endsWith('.json'), 'AssetExt: $this is not a lottie file');

    return LottieBuilder.asset(
      this,
      width: width,
      height: height,
      fit: fit,
    );
  }

  Widget image({
    double? width,
    double? height,
    Color? color,
    AlignmentGeometry alignment = Alignment.center,
    BoxFit fit = BoxFit.contain,
  }) {
    assert(
      endsWith('.png') || endsWith('.jpg') || endsWith('.jpeg'),
      'AssetExt: $this is not an image file',
    );
    return Image.asset(
      this,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      color: color,
    );
  }
}
