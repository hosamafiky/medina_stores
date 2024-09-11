part of '../presentation_imports.dart';

class ProductState extends Equatable {
  const ProductState({
    this.productsStatus = UsecaseStatus.idle,
    this.subCategory,
    this.brand,
    this.productsFailure,
    this.categoryOrBrandProducts = const ApiResponse(data: PaginatedList(list: [])),
    this.productDetailsStatus = UsecaseStatus.idle,
    this.productDetailsFailure,
    this.productDetails = const ApiResponse(data: null),
    this.relatedProductsStatus = UsecaseStatus.idle,
    this.relatedProductsFailure,
    this.relatedProducts = const ApiResponse(data: []),
    this.youMayLikeProductsStatus = UsecaseStatus.idle,
    this.youMayLikeProductsFailure,
    this.youMayLikeProducts = const ApiResponse(data: []),
    this.favoriteProductsStatus = UsecaseStatus.idle,
    this.favoriteProductsFailure,
    this.favoriteProducts = const ApiResponse(data: PaginatedList(list: [])),
    this.suggestedCartProductsStatus = UsecaseStatus.idle,
    this.suggestedCartProductsFailure,
    this.suggestedCartProducts = const [],
    this.latestProductsStatus = UsecaseStatus.idle,
    this.latestProductsFailure,
    this.latestProducts = const ApiResponse(data: PaginatedList(list: [])),
    this.productNameSuggestions = const ApiResponse(data: []),
    this.searchStatus = UsecaseStatus.idle,
    this.searchFailure,
    this.searchResults = const ApiResponse(data: PaginatedList(list: [])),
  });

  final SubCategory? subCategory;
  final Brand? brand;
  final UsecaseStatus productsStatus;
  final Failure? productsFailure;
  final ApiResponse<PaginatedList<Product>> categoryOrBrandProducts;

  final UsecaseStatus productDetailsStatus;
  final Failure? productDetailsFailure;
  final ApiResponse<ProductDetails?> productDetails;
  final UsecaseStatus relatedProductsStatus;
  final Failure? relatedProductsFailure;
  final ApiResponse<List<Product>> relatedProducts;
  final UsecaseStatus youMayLikeProductsStatus;
  final Failure? youMayLikeProductsFailure;
  final ApiResponse<List<Product>> youMayLikeProducts;

  final UsecaseStatus favoriteProductsStatus;
  final Failure? favoriteProductsFailure;
  final ApiResponse<PaginatedList<Product>> favoriteProducts;

  final UsecaseStatus suggestedCartProductsStatus;
  final Failure? suggestedCartProductsFailure;
  final List<Product> suggestedCartProducts;

  final UsecaseStatus latestProductsStatus;
  final Failure? latestProductsFailure;
  final ApiResponse<PaginatedList<Product>> latestProducts;

  final ApiResponse<List<String>> productNameSuggestions;

  final UsecaseStatus searchStatus;
  final Failure? searchFailure;
  final ApiResponse<PaginatedList<Product>> searchResults;

  ProductState copyWith({
    SubCategory? subCategory,
    Brand? brand,
    UsecaseStatus? productsStatus,
    Failure? productsFailure,
    ApiResponse<PaginatedList<Product>>? categoryOrBrandProducts,
    UsecaseStatus? productDetailsStatus,
    Failure? productDetailsFailure,
    ApiResponse<ProductDetails?>? productDetails,
    UsecaseStatus? relatedProductsStatus,
    Failure? relatedProductsFailure,
    ApiResponse<List<Product>>? relatedProducts,
    UsecaseStatus? youMayLikeProductsStatus,
    Failure? youMayLikeProductsFailure,
    ApiResponse<List<Product>>? youMayLikeProducts,
    UsecaseStatus? favoriteProductsStatus,
    Failure? favoriteProductsFailure,
    ApiResponse<PaginatedList<Product>>? favoriteProducts,
    UsecaseStatus? suggestedCartProductsStatus,
    Failure? suggestedCartProductsFailure,
    List<Product>? suggestedCartProducts,
    UsecaseStatus? latestProductsStatus,
    Failure? latestProductsFailure,
    ApiResponse<PaginatedList<Product>>? latestProducts,
    ApiResponse<List<String>>? productNameSuggestions,
    UsecaseStatus? searchStatus,
    Failure? searchFailure,
    ApiResponse<PaginatedList<Product>>? searchResults,
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
      relatedProductsStatus: relatedProductsStatus ?? this.relatedProductsStatus,
      relatedProductsFailure: relatedProductsFailure ?? this.relatedProductsFailure,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      youMayLikeProductsStatus: youMayLikeProductsStatus ?? this.youMayLikeProductsStatus,
      youMayLikeProductsFailure: youMayLikeProductsFailure ?? this.youMayLikeProductsFailure,
      youMayLikeProducts: youMayLikeProducts ?? this.youMayLikeProducts,
      favoriteProductsStatus: favoriteProductsStatus ?? this.favoriteProductsStatus,
      favoriteProductsFailure: favoriteProductsFailure ?? this.favoriteProductsFailure,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      suggestedCartProductsStatus: suggestedCartProductsStatus ?? this.suggestedCartProductsStatus,
      suggestedCartProductsFailure: suggestedCartProductsFailure ?? this.suggestedCartProductsFailure,
      suggestedCartProducts: suggestedCartProducts ?? this.suggestedCartProducts,
      latestProductsStatus: latestProductsStatus ?? this.latestProductsStatus,
      latestProductsFailure: latestProductsFailure ?? this.latestProductsFailure,
      latestProducts: latestProducts ?? this.latestProducts,
      productNameSuggestions: productNameSuggestions ?? this.productNameSuggestions,
      searchStatus: searchStatus ?? this.searchStatus,
      searchFailure: searchFailure ?? this.searchFailure,
      searchResults: searchResults ?? this.searchResults,
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
        relatedProductsStatus,
        relatedProductsFailure,
        relatedProducts,
        youMayLikeProductsStatus,
        youMayLikeProductsFailure,
        youMayLikeProducts,
        favoriteProductsStatus,
        favoriteProductsFailure,
        favoriteProducts,
        suggestedCartProductsStatus,
        suggestedCartProductsFailure,
        suggestedCartProducts,
        latestProductsStatus,
        latestProductsFailure,
        latestProducts,
        productNameSuggestions,
        searchStatus,
        searchFailure,
        searchResults,
      ];
}
