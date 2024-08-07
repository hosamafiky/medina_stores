part of '../presentation_imports.dart';

class ProductState extends Equatable {
  const ProductState({
    this.productsStatus = UsecaseStatus.idle,
    this.productsFailure,
    this.products = const [],
    this.addProductStatus = UsecaseStatus.idle,
    this.addProductFailure,
  });

  final UsecaseStatus productsStatus;
  final Failure? productsFailure;
  final List<Product> products;

  final UsecaseStatus addProductStatus;
  final Failure? addProductFailure;

  ProductState copyWith({
    UsecaseStatus? productsStatus,
    Failure? productsFailure,
    List<Product>? products,
    UsecaseStatus? addProductStatus,
    Failure? addProductFailure,
  }) {
    return ProductState(
      productsStatus: productsStatus ?? this.productsStatus,
      productsFailure: productsFailure ?? this.productsFailure,
      products: products ?? this.products,
      addProductStatus: addProductStatus ?? this.addProductStatus,
      addProductFailure: addProductFailure ?? this.addProductFailure,
    );
  }

  @override
  String toString() {
    return 'ProductState(productsStatus: $productsStatus, productsFailure: $productsFailure, products: $products, addProductStatus: $addProductStatus, addProductFailure: $addProductFailure)';
  }

  @override
  List<Object?> get props => [
        productsStatus,
        productsFailure,
        products,
        addProductStatus,
        addProductFailure,
      ];
}
