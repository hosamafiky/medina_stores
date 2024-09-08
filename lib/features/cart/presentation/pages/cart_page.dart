part of '../presentation_imports.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.serviceLocator<ProductCubit>()..getSuggestedCartProducts(),
      child: const CartsPageBody(),
    );
  }
}

class CartsPageBody extends StatefulWidget {
  const CartsPageBody({super.key});

  @override
  State<CartsPageBody> createState() => _CartsPageBodyState();
}

class _CartsPageBodyState extends State<CartsPageBody> {
  @override
  void initState() {
    context.read<CartCubit>().getCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text(LocaleKeys.cart.tr()),
      ),
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state.updateCartQuantityStatus == UsecaseStatus.running) {
            LoadingManager.show();
          }

          if (state.updateCartQuantityStatus == UsecaseStatus.error) {
            LoadingManager.hide();
            MessageHelper.showErrorSnackBar(state.updateCartQuantityFailure!.response.message);
          }
          if (state.updateCartQuantityStatus == UsecaseStatus.completed) {
            LoadingManager.hide();
            MessageHelper.showSuccessSnackBar(state.updateCartQuantityResponse.message);
          }
        },
        child: BlocSelector<CartCubit, CartState, ({UsecaseStatus status, Failure? failure, CartData cart})>(
          selector: (state) => (status: state.cartDataStatus, failure: state.cartDataFailure, cart: state.cartData),
          builder: (context, state) {
            return state.status.when(
              context,
              running: (context) => const CartDetails.skeleton(),
              error: (context) => ErrorViewWidget(
                state.failure!,
                onRetry: () => context.read<CartCubit>().getCartItems(),
              ),
              completed: (context) {
                final cart = state.cart;
                return CartDetails(cart: cart);
              },
            );
          },
        ),
      ),
    );
  }
}
