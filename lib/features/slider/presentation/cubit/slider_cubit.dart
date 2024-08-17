part of '../presentation_imports.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit({
    required this.getSlidersUsecase,
  }) : super(const SliderState(sliders: ApiResponse<PaginatedList<Slider>>.success(data: PaginatedList<Slider>(data: [])))) {
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  Timer? timer;

  final PageController pageController = PageController(viewportFraction: 0.9);
  void onPageChanged(int index) {
    int newIndex = index % (state.sliders.data?.data.length ?? 1);
    emit(state.copyWith(sliderIndex: newIndex));
  }

  void init() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (state.sliders.data?.data.isEmpty ?? false) return;
      if (!pageController.hasClients) return;
      pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  final GetSlidersUsecase getSlidersUsecase;

  Future<void> getSliders() async {
    emit(state.copyWith(slidersStatus: UsecaseStatus.running));
    final result = await getSlidersUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(slidersStatus: UsecaseStatus.error, slidersFailure: failure));
      },
      (paginatedSliders) {
        emit(state.copyWith(slidersStatus: UsecaseStatus.completed, sliders: paginatedSliders));
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
