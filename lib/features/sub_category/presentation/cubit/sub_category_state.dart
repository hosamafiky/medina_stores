part of '../presentation_imports.dart';

class SubCategoryState extends Equatable {
  const SubCategoryState({
    this.subCategoriesStatus = UsecaseStatus.idle,
    this.subCategoriesFailure,
    this.subCategories = const [],
    this.addSubCategoryStatus = UsecaseStatus.idle,
    this.addSubCategoryFailure,
  });

  final UsecaseStatus subCategoriesStatus;
  final Failure? subCategoriesFailure;
  final List<SubCategory> subCategories;

  final UsecaseStatus addSubCategoryStatus;
  final Failure? addSubCategoryFailure;

  SubCategoryState copyWith({
    UsecaseStatus? subCategoriesStatus,
    Failure? subCategoriesFailure,
    List<SubCategory>? subCategories,
    UsecaseStatus? addSubCategoryStatus,
    Failure? addSubCategoryFailure,
  }) {
    return SubCategoryState(
      subCategoriesStatus: subCategoriesStatus ?? this.subCategoriesStatus,
      subCategoriesFailure: subCategoriesFailure ?? this.subCategoriesFailure,
      subCategories: subCategories ?? this.subCategories,
      addSubCategoryStatus: addSubCategoryStatus ?? this.addSubCategoryStatus,
      addSubCategoryFailure: addSubCategoryFailure ?? this.addSubCategoryFailure,
    );
  }

  @override
  String toString() {
    return 'SubCategoryState(subCategoriesStatus: $subCategoriesStatus, subCategoriesFailure: $subCategoriesFailure, subCategories: $subCategories, addSubCategoryStatus: $addSubCategoryStatus, addSubCategoryFailure: $addSubCategoryFailure)';
  }

  @override
  List<Object?> get props => [
        subCategoriesStatus,
        subCategoriesFailure,
        subCategories,
        addSubCategoryStatus,
        addSubCategoryFailure,
      ];
}
