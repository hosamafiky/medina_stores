part of '../presentation_imports.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit({
    required this.getSlidersUsecase,
  }) : super(const SliderState());

  Timer? timer;
  final pageController = PageController(initialPage: 2, viewportFraction: 0.8);

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (state.sliders.isEmpty) return;
      if (!pageController.hasClients) return;
      pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  void onPageChanged(int index) => emit(state.copyWith(sliderIndex: index));

  void stopTimer() => timer?.cancel();
  void disposeController() => pageController.dispose();

  void initSlider() {
    startTimer();
  }

  final GetSlidersUsecase getSlidersUsecase;

  Future<void> getSliders() async {
    emit(state.copyWith(slidersStatus: UsecaseStatus.running));
    final result = await getSlidersUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(slidersStatus: UsecaseStatus.error, slidersFailure: failure));
      },
      (sliders) {
        emit(state.copyWith(slidersStatus: UsecaseStatus.completed, sliders: sliders.data));
        initSlider();
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
