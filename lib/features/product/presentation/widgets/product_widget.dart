part of '../presentation_imports.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget(this.product, {super.key, this.width = double.infinity}) : _isSkeleton = false;

  ProductWidget.skeleton({super.key, this.width = double.infinity})
      : product = Product.empty(),
        _isSkeleton = true;

  final Product product;
  final bool _isSkeleton;

  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final cubit = context.read<ProductCubit>();
        AppNavigator.to(ProductPage(product, cubit: cubit));
      },
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: _isSkeleton
                      ? ShimmerWidget.horizontal(
                          borderRadius: BorderRadius.circular(15.r),
                          height: 120.h,
                          width: double.infinity,
                        )
                      : ImageWidget(
                          borderRadius: BorderRadius.circular(15.r),
                          imageUrl: product.image,
                          height: 120.h,
                          width: double.infinity,
                        ),
                ),
                PositionedDirectional(
                  top: 8.h,
                  end: 8.w,
                  child: InkWell(
                    onTap: () {
                      if (_isSkeleton) return;
                      context.read<ProductCubit>().toggleProductFavourite(product.id, !product.isFavourite);
                    },
                    child: ShimmerWidget.fromChild(
                      isLoading: _isSkeleton,
                      child: Icon(
                        CupertinoIcons.heart_fill,
                        color: product.isFavourite ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ),
                // PositionedDirectional(
                //   bottom: 4,
                //   start: 4,
                //   child: AddToCartRoundWidget(
                //     product: product,
                //     addToCartCallback: (quantity) {
                //       context.read<CartCubit>().addToCart(
                //             AddCartParams(product: product, quantity: quantity),
                //           );
                //     },
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: REdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget.fromChild(
                    isLoading: _isSkeleton,
                    child: Text(
                      '${product.priceAfterDiscount} ${LocaleKeys.shorten_currency.tr()}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: product.priceAfterDiscount < product.price ? context.colorPalette.error : context.colorPalette.primaryText,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  ShimmerWidget.fromChild(
                    isLoading: _isSkeleton,
                    child: Text(
                      '${product.price} ${LocaleKeys.shorten_currency.tr()}',
                      style: context.appTextStyle.fieldStyle.copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  ShimmerWidget.fromChild(
                    isLoading: _isSkeleton,
                    child: Text(
                      _isSkeleton ? LocaleKeys.product.tr() : product.name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: context.appTextStyle.fieldStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
