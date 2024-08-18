part of '../presentation_imports.dart';

class AdCubit extends Cubit<AdState> {
  AdCubit({
    required this.getAdsUsecase,
  }) : super(const AdState());

  final GetAdsUsecase getAdsUsecase;

  Future<void> getAds() async {
    if (state.ads.data?.hasReachedEnd == true) return;
    if (state.ads.data?.currentPage == 0) emit(state.copyWith(adsStatus: UsecaseStatus.running));
    final params = GetPaginatedListParams(page: (state.ads.data!.currentPage) + 1, perPage: 5);
    final result = await getAdsUsecase(params);
    result.fold(
      (failure) => emit(state.copyWith(
        adsStatus: UsecaseStatus.error,
        adsFailure: failure,
      )),
      (ads) {
        if (ads.data!.data.isEmpty) {
          emit(state.copyWith(
            adsStatus: UsecaseStatus.completed,
            ads: ads.copyWith(
              data: state.ads.data!.copyWith(
                hasReachedEnd: true,
              ),
            ),
          ));
        } else {
          final newAds = List<Ad>.from(ads.data!.data);
          emit(state.copyWith(
            adsStatus: UsecaseStatus.completed,
            ads: ads.copyWith(
              data: state.ads.data!.copyWith(
                data: [...state.ads.data!.data, ...newAds],
                currentPage: ads.data!.currentPage,
                hasReachedEnd: ads.data!.hasReachedEnd,
              ),
            ),
          ));
        }
      },
    );
  }
}
