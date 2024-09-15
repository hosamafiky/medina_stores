part of '../presentation_imports.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required this.getCartItemsUsecase,
    required this.addToCartUsecase,
    required this.removeFromCartUsecase,
    required this.updateCartQuantityUsecase,
    required this.getCheckoutDataUsecase,
    required this.getPaymentGatesUsecase,
  }) : super(const CartState());

  final GetCartItemsUsecase getCartItemsUsecase;
  final AddToCartUsecase addToCartUsecase;
  final RemoveFromCartUsecase removeFromCartUsecase;
  final UpdateCartQuantityUsecase updateCartQuantityUsecase;
  final GetCheckoutDataUsecase getCheckoutDataUsecase;
  final GetPaymentGatesUsecase getPaymentGatesUsecase;

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
        cartData: cartData,
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
        if (params.fromCheckout) getCheckoutData(true);
        getCartItems(true);
      },
      (response) {
        emit(state.copyWith(updateCartQuantityStatus: UsecaseStatus.completed, updateCartQuantityResponse: response));
        if (params.fromCheckout) getCheckoutData(true);
        getCartItems(true);
      },
    );
  }

  void removeCart(Cart cart) async {
    final newItems = List<Cart>.from(state.cartData.data!.items)..remove(cart);

    emit(state.copyWith(
      cartData: state.cartData.copyWith(
        data: state.cartData.data!.copyWith(
          items: newItems,
          total: state.cartData.data!.total - (cart.product.priceAfterDiscount * cart.quantity),
        ),
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

  void getCheckoutData([bool refresh = false]) async {
    if (!refresh) emit(state.copyWith(checkoutStatus: UsecaseStatus.running, addToCartStatus: UsecaseStatus.idle));
    final result = await getCheckoutDataUsecase();
    result.fold(
      (failure) => emit(state.copyWith(
        checkoutStatus: UsecaseStatus.error,
        checkoutFailure: failure,
      )),
      (checkout) => emit(state.copyWith(
        checkoutStatus: UsecaseStatus.completed,
        checkoutResponse: checkout,
      )),
    );
  }

  void getPaymentGates() async {
    emit(state.copyWith(paymentGatesStatus: UsecaseStatus.running));
    final result = await getPaymentGatesUsecase();
    result.fold(
      (failure) => emit(state.copyWith(paymentGatesStatus: UsecaseStatus.error, paymentGatesFailure: failure)),
      (gates) => emit(state.copyWith(paymentGatesStatus: UsecaseStatus.completed, paymentGates: gates)),
    );
  }
}
