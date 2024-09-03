part of '../presentation_imports.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required this.getCartItemsUsecase,
    required this.addToCartUsecase,
  }) : super(const CartState());

  final GetCartItemsUsecase getCartItemsUsecase;
  final AddToCartUsecase addToCartUsecase;

  Future<void> getCartItems() async {
    emit(state.copyWith(cartItemsStatus: UsecaseStatus.running));
    final result = await getCartItemsUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(cartItemsStatus: UsecaseStatus.error, cartItemsFailure: failure));
      },
      (cartItems) {
        emit(state.copyWith(cartItemsStatus: UsecaseStatus.completed, cartItems: cartItems.data));
      },
    );
  }

  Future<void> addToCart(AddCartParams params) async {
    if (state.cartItems.map((e) => e.product).contains(params.product)) {
      updateCart(state.cartItems.firstWhere((e) => e.product == params.product), params.quantity);
    } else {
      emit(state.copyWith(
        addToCartStatus: UsecaseStatus.completed,
        showWidget: true,
        cartItems: List<Cart>.from(state.cartItems)..add(Cart(product: params.product, quantity: params.quantity)),
      ));
    }

    // emit(state.copyWith(addToCartStatus: UsecaseStatus.running));
    // final result = await addToCartUsecase(params);
    // result.fold(
    //   (failure) {
    //     emit(state.copyWith(addToCartStatus: UsecaseStatus.error, addToCartFailure: failure));
    //   },
    //   (response) {
    //     final oldCarts = List<Cart>.from(state.cartItems);
    //     emit(state.copyWith(addToCartStatus: UsecaseStatus.completed, cartItems: oldCarts..add(response.data!)));
    //   },
    // );
  }

  void removeCart(Cart cart) {
    emit(state.copyWith(
      cartItems: List<Cart>.from(state.cartItems)..remove(cart),
    ));
  }

  void updateCart(Cart cart, int quantity) {
    emit(state.copyWith(
      cartItems: List<Cart>.from(state.cartItems)..map((e) => e.product.id == cart.product.id ? e.copyWith(quantity: quantity) : e).toList(),
    ));
  }
}
