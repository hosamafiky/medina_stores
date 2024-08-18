part of '../presentation_imports.dart';

class AdCubit extends Cubit<AdState> {
  AdCubit({
    required this.getAdsUsecase,
  }) : super(const AdState());

  Timer? timer;
  final pageController = PageController(initialPage: 2, viewportFraction: 0.8);

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (state.ads.data!.data.isEmpty) return;
      if (!pageController.hasClients) return;
      pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  void onPageChanged(int index) => emit(state.copyWith(adIndex: index));

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
