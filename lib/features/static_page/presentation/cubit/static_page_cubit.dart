part of '../presentation_imports.dart';

class StaticPageCubit extends Cubit<StaticPageState> {
  StaticPageCubit({
    required this.getStaticPageUsecase,
  }) : super(const StaticPageState());

  final GetStaticPagesUsecase getStaticPageUsecase;

  Future<void> getStaticPage(String path) async {
    emit(state.copyWith(staticPagesStatus: UsecaseStatus.running));
    final result = await getStaticPageUsecase(path);
    result.fold(
      (failure) {
        emit(state.copyWith(staticPagesStatus: UsecaseStatus.error, staticPagesFailure: failure));
      },
      (staticPage) {
        emit(state.copyWith(staticPagesStatus: UsecaseStatus.completed, staticPageData: staticPage));
      },
    );
  }
}
