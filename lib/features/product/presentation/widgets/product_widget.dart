part of '../presentation_imports.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final cubit = context.read<ProductCubit>();
        AppNavigator.to(ProductPage(product, cubit: cubit));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ImageWidget(
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
                    context.read<ProductCubit>().toggleProductFavourite(product.id, !product.isFavourite);
                  },
                  child: Icon(
                    CupertinoIcons.heart_fill,
                    color: product.isFavourite ? Colors.red : Colors.grey,
                  ),
                ),
              ),
              PositionedDirectional(
                bottom: 4,
                start: 4,
                child: AddToCartRoundWidget(product: product),
              ),
            ],
          ),
          Padding(
            padding: REdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product.priceAfterDiscount} SAR',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: product.priceAfterDiscount < product.price ? context.colorPalette.error : context.colorPalette.primaryText,
                  ),
                ),
                if (product.priceAfterDiscount < product.price) ...[
                  SizedBox(height: 4.h),
                  Text(
                    '${product.price} SAR',
                    style: context.appTextStyle.fieldStyle.copyWith(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
                SizedBox(height: 4.h),
                Text(
                  product.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.appTextStyle.fieldStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
