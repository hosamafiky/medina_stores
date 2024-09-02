part of '../presentation_imports.dart';

class CategoryState extends Equatable {
  const CategoryState({
    this.categoriesStatus = UsecaseStatus.idle,
    this.categoriesFailure,
    this.categories = const [],
  });

  final UsecaseStatus categoriesStatus;
  final Failure? categoriesFailure;
  final List<Category> categories;

  CategoryState copyWith({
    UsecaseStatus? categoriesStatus,
    Failure? categoriesFailure,
    List<Category>? categories,
  }) {
    return CategoryState(
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      categoriesFailure: categoriesFailure ?? this.categoriesFailure,
      categories: categories ?? this.categories,
    );
  }

  @override
  String toString() {
    return 'CategoryState(categoriesStatus: $categoriesStatus, categoriesFailure: $categoriesFailure, categories: $categories)';
  }

  @override
  List<Object?> get props => [
        categoriesStatus,
        categoriesFailure,
        categories,
      ];
}
