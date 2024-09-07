part of '../presentation_imports.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({super.key}) : _isSkeleton = false;

  const AdsWidget.skeleton({super.key}) : _isSkeleton = true;

  final bool _isSkeleton;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AdCubit, AdState, ({UsecaseStatus status, Failure? faliure, List<Ad> ads})>(
      selector: (state) {
        return (
          status: state.adsStatus,
          faliure: state.adsFailure,
          ads: state.ads.data!.data,
        );
      },
      builder: (context, state) {
        final adCubit = context.read<AdCubit>();
        return Column(
          children: [
            SizedBox(
              height: 150.h,
              child: PageView.builder(
                controller: _isSkeleton ? PageController(initialPage: 2, viewportFraction: 0.8) : adCubit.pageController,
                itemCount: _isSkeleton
                    ? 4
                    : state.ads.length <= 2
                        ? state.ads.length
                        : null,
                scrollDirection: Axis.horizontal,
                onPageChanged: adCubit.onPageChanged,
                itemBuilder: (context, index) {
                  if (_isSkeleton) return const AdShimmerWidget();
                  final ad = state.ads[state.ads.length <= 2 ? index : index % state.ads.length];
                  return AdWidget(ad);
                },
              ),
            ),
            ShimmerWidget.fromChild(
              isLoading: _isSkeleton,
              child: const AdDotsIndicator(),
            ),
          ],
        ).withSpacing(spacing: 10.h);
      },
    );
  }
}
