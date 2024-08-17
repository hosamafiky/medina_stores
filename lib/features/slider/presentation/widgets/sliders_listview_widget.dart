part of '../presentation_imports.dart';

class SlidersAnimatingWidget extends StatelessWidget {
  const SlidersAnimatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SliderCubit, SliderState, ({UsecaseStatus status, PaginatedList<Slider>? sliders, Failure? failure})>(
      selector: (state) => (status: state.slidersStatus, sliders: state.sliders.data, failure: state.slidersFailure),
      builder: (context, state) {
        return state.status.when(
          context,
          running: (context) => const SlidersWidget.skeleton(),
          completed: (context) => const SlidersWidget(),
          error: (context) => const Center(child: Icon(Icons.warning_amber)),
        );
      },
    );
  }
}
