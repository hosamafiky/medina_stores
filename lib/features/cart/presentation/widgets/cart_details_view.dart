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
    if (cart.items.isEmpty && !_isSkeleton) {
      return Padding(
        padding: REdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_checkout,
              size: 40.sp,
              color: context.colorPalette.primary,
            ),
            Text(
              LocaleKeys.empty_cart.tr(),
              style: TextStyle(
                fontSize: 16.sp,
                color: context.colorPalette.secondaryText,
              ),
            ),
            Text(
              LocaleKeys.empty_cart_description.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: context.colorPalette.secondaryText,
              ),
            ),
            SizedBox(height: 3.h),
            ElevatedButton(
              onPressed: () => AppNavigator.pop('browse'),
              child: Text(LocaleKeys.browse.tr()),
            ),
          ],
        ).withSpacing(spacing: 8.h),
      );
    }
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList.separated(
            itemBuilder: (context, index) {
              if (_isSkeleton) return CartItemWidget.skeleton();
              final item = cart.items[index];
              return CartItemWidget(item);
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: _isSkeleton ? 2 : cart.items.length,
          ),
        ),
        if (!_isSkeleton)
          // Summary Section
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Card(
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
            ),
          ).asSliver,
        if (!_isSkeleton) ...[
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
        ],

        // Checkout Button
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            onPressed: cart.canCheckout
                ? () {
                    // Checkout
                  }
                : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(LocaleKeys.checkout.tr()),
          ),
        ).asSliver,
      ],
    );
  }
}
