part of '../presentation_imports.dart';

class AdCubit extends Cubit<AdState> {
  AdCubit({
    required this.getAdsUsecase,
  }) : super(const AdState());

  Timer? timer;
  final pageController = PageController(viewportFraction: 0.8);

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (state.ads.data!.data.isEmpty) return;
      if (!pageController.hasClients) return;
      pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  void onPageChanged(int index) {
    final newIndex = index % state.ads.data!.data.length;
    emit(state.copyWith(adIndex: newIndex));
  }

  void stopTimer() => timer?.cancel();
  void disposeController() => pageController.dispose();

  void initSlider() {
    startTimer();
  }

  final GetAdsUsecase getAdsUsecase;

  Future<void> getAds() async {
    if (state.ads.data?.hasReachedEnd == true) return;
    if (state.ads.data?.currentPage == 0) emit(state.copyWith(adsStatus: UsecaseStatus.running));
    final params = GetPaginatedListParams(page: (state.ads.data!.currentPage) + 1, perPage: 99999);
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
          initSlider();
          final oldAds = List<AdModel>.from(state.ads.data!.data.map((e) => AdModel.fromAd(e)));
          final newAds = List<AdModel>.from(ads.data!.data.map((e) => AdModel.fromAd(e)));

          final paginatedList = PaginatedList<AdModel>(
            data: [...oldAds, ...newAds],
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
