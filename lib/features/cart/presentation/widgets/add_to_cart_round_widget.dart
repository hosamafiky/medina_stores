part of '../presentation_imports.dart';

class AddToCartRoundWidget extends StatefulWidget {
  const AddToCartRoundWidget({
    super.key,
    required this.product,
    this.backgroundColor,
  });

  final Product product;
  final Color? backgroundColor;

  @override
  State<AddToCartRoundWidget> createState() => _AddToCartRoundWidgetState();
}

class _AddToCartRoundWidgetState extends State<AddToCartRoundWidget> {
  late final _debouncer = PublishSubject<int>()
    ..stream.debounceTime(const Duration(milliseconds: 300)).listen((quantity) {
      context.read<CartCubit>().addToCart(AddCartParams(product: widget.product, quantity: quantity));
    });

  @override
  void dispose() {
    _debouncer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCubit, CartState, Cart>(
      selector: (state) {
        return state.cartData.items.firstWhere(
          (element) => element.product.id == widget.product.id,
          orElse: () => Cart.empty.copyWith(product: widget.product),
        );
      },
      builder: (context, state) {
        bool isExpanded = state.quantity > 0;
        return Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? ColorPalette.whiteColor,
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
                    backgroundColor: WidgetStateProperty.all(state.quantity > 1 ? context.colorPalette.primary : ColorPalette.whiteColor),
                    foregroundColor: WidgetStateProperty.all(context.colorPalette.buttonText),
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () => _debouncer.add(1),
                  icon: Icon(
                    Icons.add,
                    size: 14.r,
                    color: state.quantity > 1 ? ColorPalette.whiteColor : context.colorPalette.buttonBackground,
                  ),
                ),
                if (isExpanded) ...[
                  AnimatedOpacity(
                    opacity: isExpanded ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      '${state.quantity}',
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
                      onPressed: () => _debouncer.add(-1),
                      icon: Icon(
                        state.quantity > 1 ? Icons.remove : Icons.delete_forever,
                        size: 14.r,
                        color: state.quantity > 1 ? context.colorPalette.primaryText : context.colorPalette.error,
                      ),
                    ),
                  ),
                ],
              ],
            ).withSpacing(spacing: 10.w),
          ),
        );
      },
    );
  }
}
