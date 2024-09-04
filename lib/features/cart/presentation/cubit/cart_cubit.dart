part of '../presentation_imports.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required this.getCartItemsUsecase,
    required this.addToCartUsecase,
    required this.removeFromCartUsecase,
  }) : super(const CartState());

  final GetCartItemsUsecase getCartItemsUsecase;
  final AddToCartUsecase addToCartUsecase;
  final RemoveFromCartUsecase removeFromCartUsecase;

  Future<void> getCartItems([bool refresh = false]) async {
    if (!refresh) emit(state.copyWith(cartDataStatus: UsecaseStatus.running));
    final result = await getCartItemsUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(cartDataStatus: UsecaseStatus.error, cartDataFailure: failure));
      },
      (cartData) {
        emit(
          state.copyWith(
            cartDataStatus: UsecaseStatus.completed,
            cartData: cartData.data,
            showWidget: cartData.data!.items.isNotEmpty,
          ),
        );
      },
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

    // if (oldCartItems.contains(cartItem)) {
    //   updateCart(params.product, (cartItem.quantity + params.quantity));
    // } else {
    //   final newCartItems = oldCartItems..add(cartItem.copyWith(itemTotal: cartItem.product.priceAfterDiscount * (cartItem.quantity + params.quantity)));
    //   final total = updateTotalPrice(cartItem.product, cartItem.quantity);
    //   final subTotal = total + state.cartData.discount;

    //   emit(state.copyWith(
    //     addToCartStatus: UsecaseStatus.completed,
    //     showWidget: newCartItems.isNotEmpty,
    //     cartData: state.cartData.copyWith(
    //       items: newCartItems,
    //       total: total,
    //       subTotal: subTotal,
    //     ),
    //   ));
    // }

    final result = await addToCartUsecase(params);
    result.fold(
      (failure) => emit(state.copyWith(addToCartStatus: UsecaseStatus.error, addToCartFailure: failure)),
      (response) {
        emit(state.copyWith(addToCartStatus: UsecaseStatus.completed));
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

    if (quantity == 0) {
      removeCart(cartItem);
      return;
    }
    final updatedList = oldCartItems.updateProductAtIndex(
      cartItemIndex,
      cartItem.copyWith(
        quantity: quantity,
        itemTotal: cartItem.product.priceAfterDiscount * quantity,
      ),
    );
    final total = updateTotalPrice(product, quantity);
    final subTotal = total + state.cartData.discount;
    emit(state.copyWith(
      cartData: state.cartData.copyWith(
        items: updatedList,
        total: total,
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

  void hideWidget() {
    emit(state.copyWith(showWidget: false));
  }
}
