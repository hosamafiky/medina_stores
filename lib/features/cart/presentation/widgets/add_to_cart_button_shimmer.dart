part of '../presentation_imports.dart';

class AddToCartButtonShimmer extends StatelessWidget {
  const AddToCartButtonShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ShimmerWidget.circular(diameter: 30),
          ShimmerWidget.fromChild(
            child: Text(
              '${1}',
              style: TextStyle(
                color: context.colorPalette.primaryText,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const ShimmerWidget.circular(diameter: 30),
        ],
      ).withSpacing(spacing: 10.w),
    );
  }
}
