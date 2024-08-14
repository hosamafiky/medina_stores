part of '../presentation_imports.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit({
    required this.getSlidersUsecase,
    required this.addSliderUsecase,
  }) : super(const SliderState()) {
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  Timer? timer;

  final PageController pageController = PageController(viewportFraction: 0.9);
  void onPageChanged(int index) {
    int newIndex = index % state.sliders.length;
    emit(state.copyWith(sliderIndex: newIndex));
  }

  void init() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (state.sliders.isEmpty) return;
      if (!pageController.hasClients) return;
      pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void pauseTimer() => timer?.cancel();
  void restartTimer() => init();

  final GetSlidersUsecase getSlidersUsecase;
  final AddSliderUsecase addSliderUsecase;

  Future<void> getSliders() async {
    emit(state.copyWith(slidersStatus: UsecaseStatus.running));
    final result = await getSlidersUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(slidersStatus: UsecaseStatus.error, slidersFailure: failure));
      },
      (sliders) {
        emit(state.copyWith(slidersStatus: UsecaseStatus.completed, sliders: sliders.data));
        init();
      },
    );
  }

  @override
  Future<void> close() {
    timer?.cancel();
    pageController.dispose();
    return super.close();
  }
}
