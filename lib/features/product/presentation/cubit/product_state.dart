part of '../presentation_imports.dart';

class ProductState extends Equatable {
  const ProductState({
    this.productsStatus = UsecaseStatus.idle,
    this.subCategory,
    this.brand,
    this.productsFailure,
    this.categoryOrBrandProducts = const ApiResponse(data: PaginatedList(data: [])),
    this.productDetailsStatus = UsecaseStatus.idle,
    this.productDetailsFailure,
    this.productDetails = const ApiResponse(data: null),
    this.relatedProducts = const ApiResponse(data: []),
    this.youMayLikeProducts = const ApiResponse(data: []),
    this.favoriteProductsStatus = UsecaseStatus.idle,
    this.favoriteProductsFailure,
    this.favoriteProducts = const ApiResponse(data: PaginatedList(data: [])),
    this.suggestedCartProductsStatus = UsecaseStatus.idle,
    this.suggestedCartProductsFailure,
    this.suggestedCartProducts = const [],
  });

  final SubCategory? subCategory;
  final Brand? brand;
  final UsecaseStatus productsStatus;
  final Failure? productsFailure;
  final ApiResponse<PaginatedList<Product>> categoryOrBrandProducts;

  final UsecaseStatus productDetailsStatus;
  final Failure? productDetailsFailure;
  final ApiResponse<ProductDetails?> productDetails;
  final ApiResponse<List<Product>> relatedProducts;
  final ApiResponse<List<Product>> youMayLikeProducts;

  final UsecaseStatus favoriteProductsStatus;
  final Failure? favoriteProductsFailure;
  final ApiResponse<PaginatedList<Product>> favoriteProducts;

  final UsecaseStatus suggestedCartProductsStatus;
  final Failure? suggestedCartProductsFailure;
  final List<Product> suggestedCartProducts;

  ProductState copyWith({
    SubCategory? subCategory,
    Brand? brand,
    UsecaseStatus? productsStatus,
    Failure? productsFailure,
    ApiResponse<PaginatedList<Product>>? categoryOrBrandProducts,
    UsecaseStatus? productDetailsStatus,
    Failure? productDetailsFailure,
    ApiResponse<ProductDetails?>? productDetails,
    ApiResponse<List<Product>>? relatedProducts,
    ApiResponse<List<Product>>? youMayLikeProducts,
    UsecaseStatus? favoriteProductsStatus,
    Failure? favoriteProductsFailure,
    ApiResponse<PaginatedList<Product>>? favoriteProducts,
    UsecaseStatus? suggestedCartProductsStatus,
    Failure? suggestedCartProductsFailure,
    List<Product>? suggestedCartProducts,
  }) {
    return ProductState(
      brand: brand ?? this.brand,
      subCategory: subCategory ?? this.subCategory,
      productsStatus: productsStatus ?? this.productsStatus,
      productsFailure: productsFailure ?? this.productsFailure,
      categoryOrBrandProducts: categoryOrBrandProducts ?? this.categoryOrBrandProducts,
      productDetailsStatus: productDetailsStatus ?? this.productDetailsStatus,
      productDetailsFailure: productDetailsFailure ?? this.productDetailsFailure,
      productDetails: productDetails ?? this.productDetails,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      youMayLikeProducts: youMayLikeProducts ?? this.youMayLikeProducts,
      favoriteProductsStatus: favoriteProductsStatus ?? this.favoriteProductsStatus,
      favoriteProductsFailure: favoriteProductsFailure ?? this.favoriteProductsFailure,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      suggestedCartProductsStatus: suggestedCartProductsStatus ?? this.suggestedCartProductsStatus,
      suggestedCartProductsFailure: suggestedCartProductsFailure ?? this.suggestedCartProductsFailure,
      suggestedCartProducts: suggestedCartProducts ?? this.suggestedCartProducts,
    );
  }

  @override
  String toString() {
    return 'ProductState(subCategory: $subCategory, brand: $brand, productsStatus: $productsStatus, productsFailure: $productsFailure, products: $categoryOrBrandProducts, relatedProducts: $relatedProducts, youMayLikeProducts: $youMayLikeProducts productDetailsStatus: $productDetailsStatus, productDetailsFailure: $productDetailsFailure, productDetails: $productDetails)';
  }

  @override
  List<Object?> get props => [
        subCategory,
        brand,
        productsStatus,
        productsFailure,
        categoryOrBrandProducts,
        productDetailsStatus,
        productDetailsFailure,
        productDetails,
        relatedProducts,
        youMayLikeProducts,
        favoriteProductsStatus,
        favoriteProductsFailure,
        favoriteProducts,
        suggestedCartProductsStatus,
        suggestedCartProductsFailure,
        suggestedCartProducts,
      ];
}
