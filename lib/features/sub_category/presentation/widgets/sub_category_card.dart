part of '../presentation_imports.dart';

class SubCategoryCard extends StatelessWidget {
  const SubCategoryCard(this.subCategory, {super.key}) : _isSkeleton = false;

  SubCategoryCard.skeleton({super.key})
      : subCategory = SubCategory(createdAt: DateTime.now()),
        _isSkeleton = true;

  final SubCategory subCategory;
  final bool _isSkeleton;

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget.fromChild(
      isLoading: _isSkeleton,
      child: InkWell(
        onTap: () {
          if (_isSkeleton) return;
          AppNavigator.to(ProductsPage.subCategory(subCategory));
        },
        child: Column(
          children: [
            if (_isSkeleton) ...[
              ShimmerWidget.circular(diameter: 70.r),
            ] else ...[
              ImageWidget(
                imageUrl: subCategory.image,
                height: 70.r,
                width: 70.r,
                shape: BoxShape.circle,
              ),
            ],
            Text(
              _isSkeleton ? LocaleKeys.sub_category.tr() : subCategory.name.capitalize,
              textAlign: TextAlign.center,
              style: context.appTextStyle.elevatedButtonTextStyle,
            ),
          ],
        ).withSpacing(spacing: 8.h),
      ),
    );
  }
}
