part of '../domain_imports.dart';

class UpdateCartQuantityUsecase implements UseCase<ApiResponse<void>, UpdateCartQuantityParams> {
  final CartRepository repository;

  const UpdateCartQuantityUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<void>>> call(UpdateCartQuantityParams params) async {
    return repository.updateCartQuantity(params);
  }
}

class UpdateCartQuantityParams extends Equatable {
  final Cart cart;
  final int quantity;
  final bool fromCheckout;

  const UpdateCartQuantityParams({
    required this.cart,
    required this.quantity,
    this.fromCheckout = false,
  });

  Map<String, dynamic> toMap() {
    return {
      "quantity": quantity,
    };
  }

  @override
  List<Object> get props => [cart, quantity];
}
