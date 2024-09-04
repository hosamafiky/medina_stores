part of '../presentation_imports.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CartsPageBody();
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
      body: BlocSelector<CartCubit, CartState, ({UsecaseStatus status, Failure? failure, CartData cart})>(
        selector: (state) => (status: state.cartDataStatus, failure: state.cartDataFailure, cart: state.cartData),
        builder: (context, state) {
          return state.status.when(
            context,
            idle: (context) => const SizedBox.shrink(),
            running: (context) => const Center(child: CircularProgressIndicator.adaptive()),
            error: (context) => ErrorViewWidget(
              state.failure!,
              onRetry: () => context.read<CartCubit>().getCartItems(),
            ),
            completed: (context) {
              final cart = state.cart;
              return Padding(
                padding: REdgeInsets.all(16),
                child: CustomScrollView(
                  slivers: [
                    if (cart.items.isEmpty) ...[
                      SizedBox(
                        height: 70.h,
                        child: Center(
                          child: Text(LocaleKeys.empty_cart.tr()),
                        ),
                      ).asSliver,
                    ] else ...[
                      SliverList.separated(
                        itemBuilder: (context, index) {
                          final item = cart.items[index];
                          return Container(
                            padding: REdgeInsets.all(16.h),
                            child: Row(
                              children: [
                                ImageWidget(
                                  imageUrl: item.product.image,
                                  borderRadius: BorderRadius.circular(8),
                                  width: 70,
                                  height: 70,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.product.name),
                                      Text(item.itemTotal.toString()),
                                    ],
                                  ),
                                ),
                                AddToCartRoundWidget(
                                  product: item.product,
                                  backgroundColor: context.colorPalette.shimmerHighlightColor,
                                ),
                              ],
                            ).withSpacing(spacing: 16.w),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: cart.items.length,
                      ),
                    ],
                    // Summary Section
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Subtotal: ${cart.subTotal}'),
                            Text('Discount: ${cart.discount}'),
                            const Divider(),
                            Text(
                              'Total: ${cart.total}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ).asSliver,
                    // Checkout Button
                    ElevatedButton(
                      onPressed: cart.canCheckout
                          ? () {
                              // Checkout
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Checkout'),
                    ).asSliver,
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
