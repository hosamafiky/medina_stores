part of '../presentation_imports.dart';

class CategoryState extends Equatable {
  const CategoryState({
    this.categoriesStatus = UsecaseStatus.idle,
    this.categoriesFailure,
    this.categories = const [],
    this.addCategoryStatus = UsecaseStatus.idle,
    this.addCategoryFailure,
  });

  final UsecaseStatus categoriesStatus;
  final Failure? categoriesFailure;
  final List<Category> categories;

  final UsecaseStatus addCategoryStatus;
  final Failure? addCategoryFailure;

  CategoryState copyWith({
    UsecaseStatus? categoriesStatus,
    Failure? categoriesFailure,
    List<Category>? categories,
    UsecaseStatus? addCategoryStatus,
    Failure? addCategoryFailure,
  }) {
    return CategoryState(
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      categoriesFailure: categoriesFailure ?? this.categoriesFailure,
      categories: categories ?? this.categories,
      addCategoryStatus: addCategoryStatus ?? this.addCategoryStatus,
      addCategoryFailure: addCategoryFailure ?? this.addCategoryFailure,
    );
  }

  @override
  String toString() {
    return 'CategoryState(categoriesStatus: $categoriesStatus, categoriesFailure: $categoriesFailure, categories: $categories, addCategoryStatus: $addCategoryStatus, addCategoryFailure: $addCategoryFailure)';
  }

  @override
  List<Object?> get props => [
        categoriesStatus,
        categoriesFailure,
        categories,
        addCategoryStatus,
        addCategoryFailure,
      ];
}
