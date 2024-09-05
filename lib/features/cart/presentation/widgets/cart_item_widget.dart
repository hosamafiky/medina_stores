part of '../presentation_imports.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget(this.item, {super.key}) : _isSkeleton = false;

  CartItemWidget.skeleton({super.key})
      : item = Cart.empty,
        _isSkeleton = true;

  final Cart item;
  final bool _isSkeleton;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16.h),
      child: Row(
        children: [
          if (_isSkeleton) ...[
            ShimmerWidget.horizontal(
              width: 70,
              height: 70,
              borderRadius: BorderRadius.circular(8),
            ),
          ] else ...[
            ImageWidget(
              imageUrl: item.product.image,
              borderRadius: BorderRadius.circular(8),
              width: 70,
              height: 70,
            ),
          ],
          Expanded(
            child: ShimmerWidget.fromChild(
              isLoading: _isSkeleton,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isSkeleton ? LocaleKeys.product.tr() : item.product.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      decoration: item.isValidQuantity ? TextDecoration.none : TextDecoration.lineThrough,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    !item.isValidQuantity ? LocaleKeys.not_available_now.tr() : "${item.itemTotal} ${LocaleKeys.shorten_currency.tr()}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: !item.isValidQuantity ? context.colorPalette.error : context.colorPalette.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isSkeleton) ...[
            const AddToCartButtonShimmer(),
          ] else ...[
            AddToCartRoundWidget(
              product: item.product,
              backgroundColor: context.colorPalette.shimmerHighlightColor,
              addToCartCallback: (quantity) {
                context.read<CartCubit>().updateQuantity(
                      UpdateCartQuantityParams(cart: item, quantity: quantity),
                    );
              },
            ),
          ],
        ],
      ).withSpacing(spacing: 16.w),
    );
  }
}
