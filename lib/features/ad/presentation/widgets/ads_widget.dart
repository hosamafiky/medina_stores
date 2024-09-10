part of '../presentation_imports.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget(this.ads, {super.key, this.currentIndex = 0}) : _isSkeleton = false;

  const AdsWidget.skeleton({super.key})
      : ads = const PaginatedList(list: []),
        currentIndex = 0,
        _isSkeleton = true;

  final bool _isSkeleton;
  final PaginatedList<Ad> ads;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final adCubit = context.read<AdCubit>();
    final sortedAds = List<Ad>.from(ads.list)..sort((a, b) => a.order.compareTo(b.order));
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: adCubit.carouselController,
          itemCount: _isSkeleton ? 4 : sortedAds.length,
          itemBuilder: (context, itemIndex, pageViewIndex) {
            if (_isSkeleton) return const AdShimmerWidget();
            return AdWidget(sortedAds[itemIndex]);
          },
          options: CarouselOptions(
            height: 120.h,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 30),
            enableInfiniteScroll: sortedAds.length > 2,
            enlargeCenterPage: true,
            onPageChanged: adCubit.onPageChanged,
          ),
        ),
        ShimmerWidget.fromChild(
          isLoading: _isSkeleton,
          child: AnimatedSmoothIndicator(
            activeIndex: currentIndex,
            count: _isSkeleton ? 4 : sortedAds.length,
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
  }
}
