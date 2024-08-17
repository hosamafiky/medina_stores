part of '../presentation_imports.dart';

class SliderState extends Equatable {
  const SliderState({
    this.slidersStatus = UsecaseStatus.idle,
    this.slidersFailure,
    required this.sliders,
    this.sliderIndex = 0,
  });

  final UsecaseStatus slidersStatus;
  final Failure? slidersFailure;
  final ApiResponse<PaginatedList<Slider>> sliders;

  final int sliderIndex;

  SliderState copyWith({
    UsecaseStatus? slidersStatus,
    Failure? slidersFailure,
    ApiResponse<PaginatedList<Slider>>? sliders,
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
