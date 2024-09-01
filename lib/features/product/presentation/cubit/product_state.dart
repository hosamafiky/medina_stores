part of '../presentation_imports.dart';

class ProductState extends Equatable {
  const ProductState({
    this.productsStatus = UsecaseStatus.idle,
    required this.subCategory,
    this.brand,
    this.productsFailure,
    this.products = const ApiResponse(data: PaginatedList(data: [])),
  });

  final SubCategory subCategory;
  final Brand? brand;
  final UsecaseStatus productsStatus;
  final Failure? productsFailure;
  final ApiResponse<PaginatedList<Product>> products;

  ProductState copyWith({
    SubCategory? subCategory,
    Brand? brand,
    UsecaseStatus? productsStatus,
    Failure? productsFailure,
    ApiResponse<PaginatedList<Product>>? products,
  }) {
    return ProductState(
      brand: brand ?? this.brand,
      subCategory: subCategory ?? this.subCategory,
      productsStatus: productsStatus ?? this.productsStatus,
      productsFailure: productsFailure ?? this.productsFailure,
      products: products ?? this.products,
    );
  }

  @override
  String toString() {
    return 'ProductState(productsStatus: $productsStatus, productsFailure: $productsFailure, category: $subCategory products: $products)';
  }

  @override
  List<Object?> get props => [
        brand,
        subCategory,
        productsStatus,
        productsFailure,
        products,
      ];
}
