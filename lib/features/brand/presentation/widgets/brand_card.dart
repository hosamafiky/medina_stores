part of '../presentation_imports.dart';

class BrandCard extends StatelessWidget {
  const BrandCard(this.brand, {super.key}) : _isSkeleton = false;

  BrandCard.skeleton({super.key})
      : brand = Brand.empty,
        _isSkeleton = true;

  final Brand brand;
  final bool _isSkeleton;

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget.fromChild(
      isLoading: _isSkeleton,
      child: InkWell(
        onTap: () {
          if (_isSkeleton) return;
        },
        child: Column(
          children: [
            ImageWidget(
              imageUrl: brand.media,
              height: 70.r,
              width: 70.r,
              shape: BoxShape.circle,
            ),
            Text(
              _isSkeleton ? LocaleKeys.brand.tr() : brand.name.capitalize,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.appTextStyle.elevatedButtonTextStyle,
            ),
          ],
        ).withSpacing(spacing: 8.h),
      ),
    );
  }
}
