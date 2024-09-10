part of '../presentation_imports.dart';

class AdState extends Equatable {
  const AdState({
    this.adsStatus = UsecaseStatus.idle,
    this.adsFailure,
    this.adIndex = 0,
    this.ads = const ApiResponse(data: PaginatedList(list: [])),
  });

  final UsecaseStatus adsStatus;
  final Failure? adsFailure;
  final ApiResponse<PaginatedList<Ad>> ads;

  final int adIndex;

  AdState copyWith({
    UsecaseStatus? adsStatus,
    Failure? adsFailure,
    ApiResponse<PaginatedList<Ad>>? ads,
    int? adIndex,
  }) {
    return AdState(
      adsStatus: adsStatus ?? this.adsStatus,
      adsFailure: adsFailure ?? this.adsFailure,
      ads: ads ?? this.ads,
      adIndex: adIndex ?? this.adIndex,
    );
  }

  @override
  String toString() {
    return 'AdState(adsStatus: $adsStatus, adsFailure: $adsFailure, ads: $ads, adIndex: $adIndex)';
  }

  @override
  List<Object?> get props => [
        adsStatus,
        adsFailure,
        ads,
        adIndex,
      ];
}
