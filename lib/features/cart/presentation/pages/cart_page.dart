part of '../presentation_imports.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.get<CartCubit>(),
      child: const CartsPageBody(),
    );
  }
}

class CartsPageBody extends StatelessWidget {
  const CartsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: BlocSelector<CartCubit, CartState, ({UsecaseStatus status, Failure? failure, List<Cart> carts})>(
        selector: (state) => (status: state.cartItemsStatus, failure: state.cartItemsFailure, carts: state.cartItems),
        builder: (context, state) {
          return const SizedBox.shrink();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cubit = context.read<CartCubit>();
          await context.showSheet<Cart>(child: AddToCartSheet(cartCubit: cubit));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
