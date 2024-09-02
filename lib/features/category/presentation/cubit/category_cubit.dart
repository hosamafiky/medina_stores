part of '../presentation_imports.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({
    required this.getCategoriesUsecase,
  }) : super(const CategoryState());

  final GetCategoriesUsecase getCategoriesUsecase;

  Future<void> getCategories() async {
    emit(state.copyWith(categoriesStatus: UsecaseStatus.running));
    final result = await getCategoriesUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(
          categoriesStatus: UsecaseStatus.error,
          categoriesFailure: failure,
        ));
      },
      (categories) {
        emit(state.copyWith(
          categoriesStatus: UsecaseStatus.completed,
          categories: categories.data,
        ));
      },
    );
  }
}
