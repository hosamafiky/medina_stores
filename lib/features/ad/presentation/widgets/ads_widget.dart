part of '../presentation_imports.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({super.key}) : _isSkeleton = false;

  const AdsWidget.skeleton({super.key}) : _isSkeleton = true;

  final bool _isSkeleton;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdCubit, AdState>(
      builder: (context, state) {
        final adCubit = context.read<AdCubit>();
        return Column(
          children: [
            SizedBox(
              height: 150.h,
              child: PageView.builder(
                controller: adCubit.pageController,
                itemCount: _isSkeleton ? 4 : null,
                scrollDirection: Axis.horizontal,
                onPageChanged: adCubit.onPageChanged,
                itemBuilder: (context, index) {
                  if (_isSkeleton) return const AdShimmerWidget();
                  final ad = state.ads.data!.data[index % state.ads.data!.data.length];

                  return AdWidget(ad);
                },
              ),
            ),
            const AdDotsIndicator(),
          ],
        ).withSpacing(spacing: 10.h);
      },
    );
  }
}
