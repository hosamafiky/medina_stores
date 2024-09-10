part of '../presentation_imports.dart';

class AdsScrollingWidget extends StatelessWidget {
  const AdsScrollingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AdCubit, AdState, ({UsecaseStatus status, PaginatedList<Ad> ads, Failure? failure, int currentIndex})>(
      selector: (state) => (
        status: state.adsStatus,
        ads: state.ads.data!,
        failure: state.adsFailure,
        currentIndex: state.adIndex,
      ),
      builder: (context, state) {
        return state.status.when(
          context,
          running: (context) => const AdsWidget.skeleton(),
          completed: (context) {
            if (state.ads.list.isNotEmpty) {
              return AdsWidget(
                state.ads,
                currentIndex: state.currentIndex,
              );
            }
            return Center(child: Text(LocaleKeys.empty_ads.tr()));
          },
          error: (context) => ErrorViewWidget(
            state.failure!,
            onRetry: () => context.read<AdCubit>().getAds(),
          ),
        );
      },
    );
  }
}
