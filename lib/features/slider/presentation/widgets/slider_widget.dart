part of '../presentation_imports.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget(this.slider, {super.key});

  final Slider slider;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SliderCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onLongPressDown: (_) => cubit.pauseTimer(),
        onLongPressUp: () => cubit.restartTimer(),
        child: ImageWidget(
          imageUrl: slider.imageUrl,
          borderRadius: BorderRadius.circular(10.r),
          height: 150.h,
        ),
      ),
    );
  }
}
