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
    this.relatedProducts = const ApiResponse(data: []),
    this.youMayLikeProducts = const ApiResponse(data: []),
  });

  final SubCategory? subCategory;
  final Brand? brand;
  final UsecaseStatus productsStatus;
  final Failure? productsFailure;
  final ApiResponse<PaginatedList<Product>> products;

  final UsecaseStatus productDetailsStatus;
  final Failure? productDetailsFailure;
  final ApiResponse<ProductDetails?> productDetails;
  final ApiResponse<List<Product>> relatedProducts;
  final ApiResponse<List<Product>> youMayLikeProducts;

  ProductState copyWith({
    SubCategory? subCategory,
    Brand? brand,
    UsecaseStatus? productsStatus,
    Failure? productsFailure,
    ApiResponse<PaginatedList<Product>>? products,
    UsecaseStatus? productDetailsStatus,
    Failure? productDetailsFailure,
    ApiResponse<ProductDetails?>? productDetails,
    ApiResponse<List<Product>>? relatedProducts,
    ApiResponse<List<Product>>? youMayLikeProducts,
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
      relatedProducts: relatedProducts ?? this.relatedProducts,
      youMayLikeProducts: youMayLikeProducts ?? this.youMayLikeProducts,
    );
  }

  @override
  String toString() {
    return 'ProductState(subCategory: $subCategory, brand: $brand, productsStatus: $productsStatus, productsFailure: $productsFailure, products: $products, relatedProducts: $relatedProducts, youMayLikeProducts: $youMayLikeProducts productDetailsStatus: $productDetailsStatus, productDetailsFailure: $productDetailsFailure, productDetails: $productDetails)';
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
        relatedProducts,
        youMayLikeProducts,
      ];
}
