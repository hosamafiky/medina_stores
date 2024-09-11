part of '../presentation_imports.dart';

class StaticPageState extends Equatable {
  const StaticPageState({
    this.staticPagesStatus = UsecaseStatus.idle,
    this.staticPagesFailure,
    this.staticPageData = const ApiResponse(data: ''),
  });

  final UsecaseStatus staticPagesStatus;
  final Failure? staticPagesFailure;
  final ApiResponse<String> staticPageData;

  StaticPageState copyWith({
    UsecaseStatus? staticPagesStatus,
    Failure? staticPagesFailure,
    ApiResponse<String>? staticPageData,
  }) {
    return StaticPageState(
      staticPagesStatus: staticPagesStatus ?? this.staticPagesStatus,
      staticPagesFailure: staticPagesFailure ?? this.staticPagesFailure,
      staticPageData: staticPageData ?? this.staticPageData,
    );
  }

  @override
  String toString() {
    return 'StaticPageState(staticPagesStatus: $staticPagesStatus, staticPagesFailure: $staticPagesFailure, staticPages: $staticPageData)';
  }

  @override
  List<Object?> get props => [
        staticPagesStatus,
        staticPagesFailure,
        staticPageData,
      ];
}
