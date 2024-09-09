part of 'rotation_imports.dart';

class RotationTransitionAnimation implements TransitionCreator {
  final RotationAnimationOptions options;

  const RotationTransitionAnimation({
    required this.options,
  });

  @override
  Widget animate(
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    /// Primary animation
    return RotationTransition(
      turns: RotationAnimator(options).animator(animation),
      alignment: options.alignment,
      filterQuality: options.filterQuality,
      child: child,
    ).buildSecondaryTransition(animation: animation, applySecondaryTransition: options.secondaryTransition);
  }
}
