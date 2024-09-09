part of '../rotation_imports.dart';

class RotationAnimationOptions extends AnimationOption {
  final double begin;
  final double end;
  final Alignment alignment;
  final FilterQuality? filterQuality;
  const RotationAnimationOptions({
    this.begin = 0.0,
    this.end = 1.0,
    this.alignment = Alignment.center,
    this.filterQuality,
    super.duration,
    super.curve,
    super.reverseCurve,
    super.reverseDuration,
    super.secondaryTransition,
  });
}
