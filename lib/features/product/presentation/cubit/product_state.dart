part of '../presentation_imports.dart';

class ProductState extends Equatable {
  const ProductState({
    this.productsStatus = UsecaseStatus.idle,
    this.subCategory,
    this.brand,
    this.productsFailure,
    this.products = const ApiResponse(data: PaginatedList(data: [])),
    this.productDetailsStatus = UsecaseStatus.idle,
    this.productDetailsFailure,
    this.productDetails = const ApiResponse(data: null),
  });

  final SubCategory? subCategory;
  final Brand? brand;
  final UsecaseStatus productsStatus;
  final Failure? productsFailure;
  final ApiResponse<PaginatedList<Product>> products;

  final UsecaseStatus productDetailsStatus;
  final Failure? productDetailsFailure;
  final ApiResponse<ProductDetails?> productDetails;

  ProductState copyWith({
    SubCategory? subCategory,
    Brand? brand,
    UsecaseStatus? productsStatus,
    Failure? productsFailure,
    ApiResponse<PaginatedList<Product>>? products,
    UsecaseStatus? productDetailsStatus,
    Failure? productDetailsFailure,
    ApiResponse<ProductDetails?>? productDetails,
  }) {
    return ProductState(
      brand: brand ?? this.brand,
      subCategory: subCategory ?? this.subCategory,
      productsStatus: productsStatus ?? this.productsStatus,
      productsFailure: productsFailure ?? this.productsFailure,
      products: products ?? this.products,
      productDetailsStatus: productDetailsStatus ?? this.productDetailsStatus,
      productDetailsFailure: productDetailsFailure ?? this.productDetailsFailure,
      productDetails: productDetails ?? this.productDetails,
    );
  }

  @override
  String toString() {
    return 'ProductState(subCategory: $subCategory, brand: $brand, productsStatus: $productsStatus, productsFailure: $productsFailure, products: $products, productDetailsStatus: $productDetailsStatus, productDetailsFailure: $productDetailsFailure, productDetails: $productDetails)';
  }

  @override
  List<Object?> get props => [
        subCategory,
        brand,
        productsStatus,
        productsFailure,
        products,
        productDetailsStatus,
        productDetailsFailure,
        productDetails,
      ];
}
