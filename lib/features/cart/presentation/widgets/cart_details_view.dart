part of '../presentation_imports.dart';

class CartDetails extends StatelessWidget {
  const CartDetails({
    super.key,
    required this.cart,
  }) : _isSkeleton = false;

  const CartDetails.skeleton({super.key})
      : cart = const CartData(),
        _isSkeleton = true;

  final CartData cart;
  final bool _isSkeleton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(16),
      child: CustomScrollView(
        slivers: [
          if (_isSkeleton) ...[
            SliverList.separated(
              itemBuilder: (context, index) {
                return CartItemWidget.skeleton();
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 2,
            ),
          ] else ...[
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
                  return CartItemWidget(item);
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: cart.items.length,
              ),
            ],
          ],
          // Summary Section
          Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('${LocaleKeys.sub_total.tr()}: ${cart.subTotal} ${LocaleKeys.shorten_currency.tr()}'),
                  Text('${LocaleKeys.discount.tr()}: ${cart.discount} ${LocaleKeys.shorten_currency.tr()}'),
                  const Divider(),
                  Text(
                    '${LocaleKeys.total.tr()}: ${cart.total} ${LocaleKeys.shorten_currency.tr()}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ).asSliver,
          // Suggested Products Section
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Text(
                  LocaleKeys.suggested_products.tr(),
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ).asSliver,
          const SuggestedProductsSection(),
          SizedBox(height: 12.h).asSliver,
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
            child: Text(LocaleKeys.checkout.tr()),
          ).asSliver,
        ],
      ),
    );
  }
}
