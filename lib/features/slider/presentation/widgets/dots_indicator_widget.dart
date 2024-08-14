part of '../presentation_imports.dart';

class SliderDotsIndicator extends StatelessWidget {
  const SliderDotsIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    return BlocBuilder<SliderCubit, SliderState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            state.sliders.length,
            (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: state.sliderIndex == index ? 32.w : 24.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: state.sliderIndex == index ? palette.currentSliderDotColor : palette.otherSliderDotColor,
                  borderRadius: BorderRadius.circular(50),
                ),
              );
            },
          ),
        ).withSpacing(spacing: 6.w);
      },
    );
  }
}
