part of '../presentation_imports.dart';

class AddToCartRoundWidget extends StatefulWidget {
  const AddToCartRoundWidget({super.key, required this.product});

  final Product product;

  @override
  State<AddToCartRoundWidget> createState() => _AddToCartRoundWidgetState();
}

class _AddToCartRoundWidgetState extends State<AddToCartRoundWidget> with SingleTickerProviderStateMixin {
  int quantityInCart = 0;

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.whiteColor,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(ColorPalette.whiteColor),
                foregroundColor: WidgetStateProperty.all(context.colorPalette.buttonText),
                padding: WidgetStateProperty.all(EdgeInsets.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              onPressed: () async {
                // Add to cart
                if (!isExpanded) {
                  isExpanded = true;
                  context.read<CartCubit>().addToCart(AddCartParams(product: widget.product, quantity: 1));
                  return;
                }
                setState(() => quantityInCart += 1);
                context.read<CartCubit>().addToCart(AddCartParams(product: widget.product, quantity: quantityInCart));
              },
              icon: Icon(
                Icons.add,
                size: 14.r,
                color: context.colorPalette.buttonBackground,
              ),
            ),
            if (isExpanded) ...[
              AnimatedOpacity(
                opacity: isExpanded ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Text(
                  '$quantityInCart',
                  style: TextStyle(
                    color: context.colorPalette.primaryText,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: isExpanded ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(context.colorPalette.error.withOpacity(0.1)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                  ),
                  onPressed: () {
                    if (quantityInCart > 0) setState(() => quantityInCart--);
                    if (quantityInCart == 0) setState(() => isExpanded = false);
                  },
                  icon: Icon(
                    quantityInCart > 1 ? Icons.remove : Icons.delete_forever,
                    size: 14.r,
                    color: quantityInCart > 1 ? context.colorPalette.primaryText : context.colorPalette.error,
                  ),
                ),
              ),
            ],
          ],
        ).withSpacing(spacing: 10.w),
      ),
    );
  }
}
