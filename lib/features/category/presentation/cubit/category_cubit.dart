part of '../presentation_imports.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({
    required this.getCategoriesUsecase,
    required this.addCategoryUsecase,
  }) : super(const CategoryState());

  final GetCategoriesUsecase getCategoriesUsecase;
  final AddCategoryUsecase addCategoryUsecase;

  Future<void> getCategories() async {
    emit(state.copyWith(categoriesStatus: UsecaseStatus.running));
    final result = await getCategoriesUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(categoriesStatus: UsecaseStatus.error, categoriesFailure: failure));
      },
      (categories) {
        emit(state.copyWith(categoriesStatus: UsecaseStatus.completed, categories: categories.data));
      },
    );
  }

  Future<void> addCategory(AddCategoryParams params) async {
    emit(state.copyWith(addCategoryStatus: UsecaseStatus.running));
    final result = await addCategoryUsecase(params);
    result.fold(
      (failure) {
        emit(state.copyWith(addCategoryStatus: UsecaseStatus.error, addCategoryFailure: failure));
      },
      (response) {
        final oldCategories = List<Category>.from(state.categories);
        emit(state.copyWith(addCategoryStatus: UsecaseStatus.completed, categories: oldCategories..insert(0, response.data!)));
      },
    );
  }
}
