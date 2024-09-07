part of '../presentation_imports.dart';

class SubCategoryCubit extends Cubit<SubCategoryState> {
  SubCategoryCubit({
    required this.getSubCategoriesUsecase,
    required this.addSubCategoryUsecase,
  }) : super(const SubCategoryState());

  final GetSubCategoriesUsecase getSubCategoriesUsecase;
  final AddSubCategoryUsecase addSubCategoryUsecase;

  Future<void> getSubCategories(int categoryId) async {
    emit(state.copyWith(subCategoriesStatus: UsecaseStatus.running));
    final result = await getSubCategoriesUsecase(categoryId);
    if (isClosed) return;
    result.fold(
      (failure) {
        emit(state.copyWith(subCategoriesStatus: UsecaseStatus.error, subCategoriesFailure: failure));
      },
      (subCategories) {
        final oldSubCategories = List<SubCategory>.from(state.subCategories);
        final newSubCategories = oldSubCategories..addAll(subCategories.data!);
        emit(state.copyWith(subCategoriesStatus: UsecaseStatus.completed, subCategories: newSubCategories));
      },
    );
  }

  Future<void> addSubCategory(AddSubCategoryParams params) async {
    emit(state.copyWith(addSubCategoryStatus: UsecaseStatus.running));
    final result = await addSubCategoryUsecase(params);
    if (isClosed) return;

    result.fold(
      (failure) {
        emit(state.copyWith(addSubCategoryStatus: UsecaseStatus.error, addSubCategoryFailure: failure));
      },
      (response) {
        final oldSubCategories = List<SubCategory>.from(state.subCategories);
        emit(state.copyWith(addSubCategoryStatus: UsecaseStatus.completed, subCategories: oldSubCategories..insert(0, response.data!)));
      },
    );
  }
}
