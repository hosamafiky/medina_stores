part of '../presentation_imports.dart';

class AdState extends Equatable {
  const AdState({
    this.adsStatus = UsecaseStatus.idle,
    this.adsFailure,
    this.ads = const ApiResponse.success(data: PaginatedList(data: [])),
  });

  final UsecaseStatus adsStatus;
  final Failure? adsFailure;
  final ApiResponse<PaginatedList<Ad>> ads;

  AdState copyWith({
    UsecaseStatus? adsStatus,
    Failure? adsFailure,
    ApiResponse<PaginatedList<Ad>>? ads,
  }) {
    return AdState(
      adsStatus: adsStatus ?? this.adsStatus,
      adsFailure: adsFailure ?? this.adsFailure,
      ads: ads ?? this.ads,
    );
  }

  @override
  String toString() {
    return 'AdState(adsStatus: $adsStatus, adsFailure: $adsFailure, ads: $ads)';
  }

  @override
  List<Object?> get props => [
        adsStatus,
        adsFailure,
        ads,
      ];
}
