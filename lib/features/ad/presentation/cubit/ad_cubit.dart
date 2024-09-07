part of '../presentation_imports.dart';

class AdCubit extends Cubit<AdState> {
  AdCubit({required this.getAdsUsecase}) : super(const AdState(adIndex: 0));

  final carouselController = CarouselSliderController();

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    emit(state.copyWith(adIndex: index));
  }

  final GetAdsUsecase getAdsUsecase;

  Future<void> getAds({bool refresh = false}) async {
    if (state.ads.data?.hasReachedEnd == true && !refresh) return;
    if (state.ads.data?.currentPage == 0 || refresh) emit(state.copyWith(adsStatus: UsecaseStatus.running));
    final params = GetPaginatedListParams(page: (refresh ? 0 : state.ads.data!.currentPage) + 1, perPage: 99999);
    final result = await getAdsUsecase(params);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        adsStatus: UsecaseStatus.error,
        adsFailure: failure,
      )),
      (ads) {
        if (ads.data!.data.isEmpty) {
          final paginatedList = PaginatedListModel<AdModel>.from(state.ads.data!.map((e) => AdModel.fromAd(e))).copyWith(
            hasReachedEnd: true,
          );
          emit(state.copyWith(
            adsStatus: UsecaseStatus.completed,
            ads: ads.copyWith(
              data: paginatedList,
            ),
          ));
        } else {
          final oldAds = List<AdModel>.from(state.ads.data!.data.map((e) => AdModel.fromAd(e)));
          final newAds = List<AdModel>.from(ads.data!.data.map((e) => AdModel.fromAd(e)));
          final paginatedList = PaginatedList<AdModel>(
            data: refresh ? newAds : [...oldAds, ...newAds],
            currentPage: ads.data!.currentPage,
            lastPage: ads.data!.lastPage,
            itemsCount: ads.data!.itemsCount,
            hasReachedEnd: ads.data!.hasReachedEnd,
          );
          emit(state.copyWith(
            adsStatus: UsecaseStatus.completed,
            ads: ads.copyWith(
              data: PaginatedListModel<AdModel>.from(paginatedList),
            ),
          ));
        }
      },
    );
  }
}
