part of '../domain_imports.dart';

class AddToCartUsecase implements UseCase<ApiResponse<void>, AddCartParams> {
  final CartRepository repository;

  const AddToCartUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<void>>> call(AddCartParams params) async {
    return repository.addToCart(params);
  }
}

class AddCartParams extends Equatable {
  final Product product;
  final int quantity;
  final List<Option> options;

  const AddCartParams({
    required this.product,
    required this.quantity,
    this.options = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      "product_id": product.id,
      "quantity": quantity,
      "options": options.map((e) => e.id).toList(),
    };
  }

  @override
  List<Object> get props => [product, quantity, options];
}
