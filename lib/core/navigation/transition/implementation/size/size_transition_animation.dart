part of 'size_imports.dart';

class SizeTransitionAnimation implements TransitionCreator {
  final SizeAnimationOptions options;

  const SizeTransitionAnimation({required this.options});

  @override
  Widget animate(Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return Align(
      alignment: options.alignment,
      child: SizeTransition(
        sizeFactor: SizeAnimator(options).animator(animation),
        axis: options.axis,
        axisAlignment: options.axisAlignment,
        child: child,
      ).buildSecondaryTransition(animation: animation, applySecondaryTransition: options.secondaryTransition),
    );
  }
}
