part of '../presentation_imports.dart';

class AdsScrollingWidget extends StatelessWidget {
  const AdsScrollingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AdCubit, AdState, ({UsecaseStatus status, PaginatedList<Ad> ads, Failure? failure})>(
      selector: (state) => (status: state.adsStatus, ads: state.ads.data!, failure: state.adsFailure),
      builder: (context, state) {
        return state.status.when(
          context,
          running: (context) => const AdsWidget.skeleton(),
          completed: (context) => const AdsWidget(),
          error: (context) => const Center(child: Icon(Icons.warning_amber)),
        );
      },
    );
  }
}
