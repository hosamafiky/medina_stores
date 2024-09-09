part of '../presentation_imports.dart';

class AddToCartRoundWidget extends StatefulWidget {
  const AddToCartRoundWidget({
    super.key,
    required this.item,
    this.backgroundColor,
    required this.addToCartCallback,
  });

  final Cart item;
  final Color? backgroundColor;
  final Function(int) addToCartCallback;

  @override
  State<AddToCartRoundWidget> createState() => _AddToCartRoundWidgetState();
}

class _AddToCartRoundWidgetState extends State<AddToCartRoundWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        bool isExpanded = widget.item.quantity > 0;
        bool isPerforming = state.addToCartStatus == UsecaseStatus.running || state.updateCartQuantityStatus == UsecaseStatus.running;
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
                    backgroundColor: WidgetStateProperty.all(widget.item.quantity > 1 ? context.colorPalette.primary : ColorPalette.whiteColor),
                    foregroundColor: WidgetStateProperty.all(context.colorPalette.buttonText),
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () => isPerforming ? {} : widget.addToCartCallback(1),
                  icon: Icon(
                    Icons.add,
                    size: 14.r,
                    color: widget.item.quantity > 1 ? ColorPalette.whiteColor : context.colorPalette.buttonBackground,
                  ),
                ),
                if (isExpanded) ...[
                  AnimatedOpacity(
                    opacity: isExpanded ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      '${widget.item.quantity}',
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
                      onPressed: () => isPerforming ? {} : widget.addToCartCallback(-1),
                      icon: Icon(
                        widget.item.quantity > 1 ? Icons.remove : Icons.delete_forever,
                        size: 14.r,
                        color: widget.item.quantity > 1 ? context.colorPalette.primaryText : context.colorPalette.error,
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
