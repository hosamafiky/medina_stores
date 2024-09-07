part of '../presentation_imports.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({super.key}) : _isSkeleton = false;

  const AdsWidget.skeleton({super.key}) : _isSkeleton = true;

  final bool _isSkeleton;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AdCubit, AdState, ({UsecaseStatus status, Failure? faliure, List<Ad> ads, int currentIndex})>(
      selector: (state) {
        return (
          status: state.adsStatus,
          faliure: state.adsFailure,
          ads: state.ads.data!.data,
          currentIndex: state.adIndex,
        );
      },
      builder: (context, state) {
        final adCubit = context.read<AdCubit>();
        return Column(
          children: [
            CarouselSlider.builder(
              carouselController: adCubit.carouselController,
              itemCount: _isSkeleton ? 4 : state.ads.length,
              itemBuilder: (context, itemIndex, pageViewIndex) {
                if (_isSkeleton) {
                  return const AdShimmerWidget();
                }
                return AdWidget(state.ads[itemIndex]);
              },
              options: CarouselOptions(
                height: 120.h,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 30),
                enableInfiniteScroll: state.ads.length < 2,
                enlargeCenterPage: true,
                onPageChanged: adCubit.onPageChanged,
              ),
            ),
            ShimmerWidget.fromChild(
              isLoading: _isSkeleton,
              child: AnimatedSmoothIndicator(
                activeIndex: state.currentIndex,
                count: _isSkeleton ? 4 : state.ads.length,
                effect: ExpandingDotsEffect(
                  dotColor: context.colorPalette.disabledText,
                  activeDotColor: context.colorPalette.primary,
                  dotHeight: 10.h,
                  dotWidth: 10.h,
                ),
                onDotClicked: adCubit.carouselController.animateToPage,
              ),
            ),
          ],
        ).withSpacing(spacing: 16.h);
      },
    );
  }
}
