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
    if (!refresh) emit(state.copyWith(cartDataStatus: UsecaseStatus.running));
    final result = await getCartItemsUsecase();
    result.fold(
      (failure) => emit(state.copyWith(
        cartDataStatus: UsecaseStatus.error,
        cartDataFailure: failure,
      )),
      (cartData) => emit(state.copyWith(
        cartDataStatus: UsecaseStatus.completed,
        cartData: cartData.data,
        showWidget: cartData.data!.items.isNotEmpty,
      )),
    );
  }

  Future<void> addToCart(AddCartParams params) async {
    final oldCartItems = List<Cart>.from(state.cartData.items);
    final cartItem = oldCartItems.firstWhere(
      (element) => element.product.id == params.product.id,
      orElse: () => Cart.empty.copyWith(product: params.product, quantity: 1),
    );

    if (cartItem.quantity + params.quantity == 0) {
      removeCart(cartItem);
      return;
    }

    final result = await addToCartUsecase(params);
    result.fold(
      (failure) => emit(state.copyWith(addToCartStatus: UsecaseStatus.error, addToCartFailure: failure)),
      (response) {
        emit(state.copyWith(addToCartStatus: UsecaseStatus.completed));
        getCartItems(true);
      },
    );
  }

  void updateQuantity(UpdateCartQuantityParams params) async {
    updateCart(params.cart.product, params.quantity);
    emit(state.copyWith(updateCartQuantityStatus: UsecaseStatus.running));
    final result = await updateCartQuantityUsecase(params);
    result.fold(
      (failure) {
        emit(state.copyWith(updateCartQuantityStatus: UsecaseStatus.error, updateCartQuantityFailure: failure));
        updateCart(params.cart.product, -params.quantity);
      },
      (response) {
        emit(state.copyWith(updateCartQuantityStatus: UsecaseStatus.completed));
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
      showWidget: newItems.isEmpty ? false : null,
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

  void updateCart(Product product, int quantity) {
    final oldCartItems = List<Cart>.from(state.cartData.items);
    final cartItem = state.cartData.items.firstWhere((element) => element.product.id == product.id);
    final cartItemIndex = oldCartItems.indexOf(cartItem);

    if (cartItem.quantity + quantity == 0) {
      removeCart(cartItem);
      return;
    }
    final updatedList = oldCartItems.updateProductAtIndex(
      cartItemIndex,
      cartItem.copyWith(
        quantity: cartItem.quantity + quantity,
        itemTotal: cartItem.product.priceAfterDiscount * (cartItem.quantity + quantity),
      ),
    );
    final total = updateTotalPrice(product, cartItem.quantity + quantity);
    final subTotal = updateSubtotalPrice(product, cartItem.quantity + quantity);
    final discount = updateDiscountAmount(product, cartItem.quantity + quantity);

    emit(state.copyWith(
      cartData: state.cartData.copyWith(
        items: updatedList,
        total: total,
        discount: discount,
        subTotal: subTotal,
      ),
    ));
  }

  num updateTotalPrice(Product product, int quantity) {
    final cartItem = state.cartData.items.firstWhere(
      (element) => element.product.id == product.id,
      orElse: () => Cart.empty.copyWith(product: product, quantity: quantity),
    );
    final oldCartItems = List<Cart>.from(state.cartData.items);
    final oldTotal = state.cartData.total;

    if (oldCartItems.contains(cartItem)) {
      final tempTotal = oldTotal - (cartItem.product.priceAfterDiscount * cartItem.quantity);
      final newTotal = tempTotal + (product.priceAfterDiscount * quantity);
      return newTotal;
    } else {
      final newTotal = oldTotal + (product.priceAfterDiscount * quantity);
      return newTotal;
    }
  }

  num updateSubtotalPrice(Product product, int quantity) {
    final cartItem = state.cartData.items.firstWhere(
      (element) => element.product.id == product.id,
      orElse: () => Cart.empty.copyWith(product: product, quantity: quantity),
    );
    final oldCartItems = List<Cart>.from(state.cartData.items);
    final oldSubtotal = state.cartData.subTotal;

    if (oldCartItems.contains(cartItem)) {
      final tempTotal = oldSubtotal - (cartItem.product.price * cartItem.quantity);
      final newTotal = tempTotal + (product.price * quantity);
      return newTotal;
    } else {
      final newTotal = oldSubtotal + (product.price * quantity);
      return newTotal;
    }
  }

  num updateDiscountAmount(Product product, int quantity) {
    final cartItem = state.cartData.items.firstWhere(
      (element) => element.product.id == product.id,
      orElse: () => Cart.empty.copyWith(product: product, quantity: quantity),
    );
    final oldCartItems = List<Cart>.from(state.cartData.items);
    final oldDiscount = state.cartData.discount;

    if (oldCartItems.contains(cartItem)) {
      final tempTotal = oldDiscount - ((cartItem.product.price - cartItem.product.priceAfterDiscount) * cartItem.quantity);
      final newTotal = tempTotal + ((product.price - product.priceAfterDiscount) * quantity);
      return newTotal;
    } else {
      final newTotal = oldDiscount + ((product.price - product.priceAfterDiscount) * quantity);
      return newTotal;
    }
  }

  void hideWidget() {
    emit(state.copyWith(showWidget: false));
  }
}
