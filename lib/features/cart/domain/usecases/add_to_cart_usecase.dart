part of '../domain_imports.dart';

class AddToCartUsecase implements UseCase<ApiResponse<Cart>, AddCartParams> {
  final CartRepository repository;

  const AddToCartUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<Cart>>> call(AddCartParams params) async {
    return repository.addToCart(params);
  }
}

class AddCartParams {
  final Product product;
  final int quantity;

  AddCartParams({
    required this.product,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'product': ProductModel.fromProduct(product).toMap(),
      'quantity': quantity,
    };
  }
}
