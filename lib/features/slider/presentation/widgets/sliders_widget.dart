part of '../presentation_imports.dart';

class SlidersWidget extends StatelessWidget {
  const SlidersWidget({super.key}) : _isSkeleton = false;

  const SlidersWidget.skeleton({super.key}) : _isSkeleton = true;

  final bool _isSkeleton;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderCubit, SliderState>(
      builder: (context, state) {
        final sliderCubit = context.read<SliderCubit>();
        return Column(
          children: [
            SizedBox(
              height: 150.h,
              child: PageView.builder(
                controller: sliderCubit.pageController,
                itemCount: _isSkeleton ? 4 : null,
                scrollDirection: Axis.horizontal,
                onPageChanged: sliderCubit.onPageChanged,
                itemBuilder: (context, index) {
                  if (_isSkeleton) return const SliderShimmerWidget();
                  final slider = state.sliders[index % state.sliders.length];

                  return SliderWidget(slider);
                },
              ),
            ),
            const SliderDotsIndicator(),
          ],
        ).withSpacing(spacing: 10.h);
      },
    );
  }
}
