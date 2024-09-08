part of '../presentation_imports.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required this.getCartItemsUsecase,
    required this.addToCartUsecase,
    required this.removeFromCartUsecase,
    required this.updateCartQuantityUsecase,
  }) : super(const CartState());

  final GetCartItemsUsecase getCartItemsUsecase;
  final AddToCartUsecase addToCartUsecase;
  final RemoveFromCartUsecase removeFromCartUsecase;
  final UpdateCartQuantityUsecase updateCartQuantityUsecase;

  Future<void> getCartItems([bool refresh = false]) async {
    if (!refresh) emit(state.copyWith(cartDataStatus: UsecaseStatus.running, addToCartStatus: UsecaseStatus.idle));
    final result = await getCartItemsUsecase();
    result.fold(
      (failure) => emit(state.copyWith(
        cartDataStatus: UsecaseStatus.error,
        cartDataFailure: failure,
      )),
      (cartData) => emit(state.copyWith(
        cartDataStatus: UsecaseStatus.completed,
        cartData: cartData.data,
      )),
    );
  }

  Future<void> addToCart(AddCartParams params) async {
    // final oldCartItems = List<Cart>.from(state.cartData.items);
    // final cartItem = oldCartItems.firstWhere(
    //   (element) => element.product.id == params.product.id,
    //   orElse: () => Cart.empty.copyWith(product: params.product, quantity: 1),
    // );

    // if (cartItem.quantity + params.quantity == 0) {
    //   removeCart(cartItem);
    //   return;
    // }

    emit(state.copyWith(addToCartStatus: UsecaseStatus.running));
    final result = await addToCartUsecase(params);
    result.fold(
      (failure) {
        emit(state.copyWith(addToCartStatus: UsecaseStatus.error, addToCartFailure: failure));
        getCartItems(true);
      },
      (response) {
        emit(state.copyWith(addToCartStatus: UsecaseStatus.completed, addToCartResponse: response));
        getCartItems(true);
      },
    );
  }

  void updateQuantity(UpdateCartQuantityParams params) async {
    if (params.cart.quantity + params.quantity == 0) {
      removeCart(params.cart);
      return;
    }

    emit(state.copyWith(updateCartQuantityStatus: UsecaseStatus.running));
    final result = await updateCartQuantityUsecase(params);
    result.fold(
      (failure) {
        emit(state.copyWith(updateCartQuantityStatus: UsecaseStatus.error, updateCartQuantityFailure: failure));
        getCartItems(true);
      },
      (response) {
        emit(state.copyWith(updateCartQuantityStatus: UsecaseStatus.completed, updateCartQuantityResponse: response));
        getCartItems(true);
      },
    );
  }

  void removeCart(Cart cart) async {
    final newItems = List<Cart>.from(state.cartData.items)..remove(cart);

    emit(state.copyWith(
      cartData: state.cartData.copyWith(
        items: newItems,
        total: state.cartData.total - (cart.product.priceAfterDiscount * cart.quantity),
      ),
    ));

    emit(state.copyWith(removeFromCartStatus: UsecaseStatus.running));
    final result = await removeFromCartUsecase(cart.id);
    result.fold(
      (failure) => emit(state.copyWith(removeFromCartStatus: UsecaseStatus.error, removeFromCartFailure: failure)),
      (response) {
        emit(state.copyWith(removeFromCartStatus: UsecaseStatus.completed));
        getCartItems(true);
      },
    );
  }
}
