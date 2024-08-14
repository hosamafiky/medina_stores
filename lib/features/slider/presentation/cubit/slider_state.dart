part of '../presentation_imports.dart';

class SliderState extends Equatable {
  const SliderState({
    this.slidersStatus = UsecaseStatus.idle,
    this.slidersFailure,
    this.sliders = const [],
    this.sliderIndex = 0,
  });

  final UsecaseStatus slidersStatus;
  final Failure? slidersFailure;
  final List<Slider> sliders;

  final int sliderIndex;

  SliderState copyWith({
    UsecaseStatus? slidersStatus,
    Failure? slidersFailure,
    List<Slider>? sliders,
    int? sliderIndex,
  }) {
    return SliderState(
      slidersStatus: slidersStatus ?? this.slidersStatus,
      slidersFailure: slidersFailure ?? this.slidersFailure,
      sliders: sliders ?? this.sliders,
      sliderIndex: sliderIndex ?? this.sliderIndex,
    );
  }

  @override
  String toString() {
    return 'SliderState(slidersStatus: $slidersStatus, slidersFailure: $slidersFailure, sliders: $sliders, sliderIndex: $sliderIndex)';
  }

  @override
  List<Object?> get props => [
        slidersStatus,
        slidersFailure,
        sliders,
        sliderIndex,
      ];
}
