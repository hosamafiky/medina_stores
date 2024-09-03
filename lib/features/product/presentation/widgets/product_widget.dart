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
              ImageWidget(
                borderRadius: BorderRadius.circular(8.r),
                imageUrl: product.image,
                height: 120.h,
                width: double.infinity,
              ),
              PositionedDirectional(
                top: 8,
                end: 8,
                child: InkWell(
                  onTap: () {
                    context.read<ProductCubit>().toggleProductFavourite(product.id, !product.isFavourite);
                  },
                  child: Icon(
                    Icons.favorite,
                    color: product.isFavourite ? Colors.red : Colors.grey,
                  ),
                ),
              ),
              PositionedDirectional(
                bottom: 8,
                start: 8,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(ColorPalette.whiteColor),
                    foregroundColor: WidgetStateProperty.all(context.colorPalette.buttonText),
                  ),
                  onPressed: () {
                    context.read<ProductCubit>().toggleProductFavourite(product.id, !product.isFavourite);
                  },
                  icon: Icon(
                    Icons.add,
                    color: context.colorPalette.buttonBackground,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product.priceAfterDiscount} SAR',
                  style: TextStyle(
                    fontSize: 16.sp,
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
