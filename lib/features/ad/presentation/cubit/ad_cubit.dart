part of '../presentation_imports.dart';

class AdCubit extends Cubit<AdState> {
  AdCubit({
    required this.getAdsUsecase,
  }) : super(const AdState(adIndex: 6));

  Timer? timer;
  final pageController = PageController(viewportFraction: 0.8);

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (state.ads.data!.data.isEmpty) return;
      if (!pageController.hasClients) return;
      pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  void onPageChanged(int index) {
    final newIndex = state.ads.data!.data.length <= 2 ? index : index % state.ads.data!.data.length;
    emit(state.copyWith(adIndex: newIndex));
  }

  void stopTimer() => timer?.cancel();
  void disposeController() => pageController.dispose();

  void initSlider() {
    startTimer();
  }

  final GetAdsUsecase getAdsUsecase;

  Future<void> getAds({bool refresh = false}) async {
    if (state.ads.data?.hasReachedEnd == true && !refresh) return;
    if (state.ads.data?.currentPage == 0 || refresh) emit(state.copyWith(adsStatus: UsecaseStatus.running));
    final params = GetPaginatedListParams(page: (refresh ? 0 : state.ads.data!.currentPage) + 1, perPage: 99999);
    final result = await getAdsUsecase(params);
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
          emit(state.copyWith(adIndex: 2 % ads.data!.data.length));
          if (ads.data!.data.length > 1) {
            initSlider();
          }
          final oldAds = List<AdModel>.from(state.ads.data!.data.map((e) => AdModel.fromAd(e)));
          final newAds = List<AdModel>.from(ads.data!.data.map((e) => AdModel.fromAd(e)));
          print("OLD ADS LENGTH : ${oldAds.length}");
          print("NEW ADS LENGTH : ${newAds.length}");
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

  @override
  Future<void> close() {
    stopTimer();
    disposeController();
    return super.close();
  }
}
