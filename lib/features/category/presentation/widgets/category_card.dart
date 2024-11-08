part of '../presentation_imports.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(this.category, {super.key}) : _isSkeleton = false;

  CategoryCard.skeleton({super.key})
      : category = Category.empty(),
        _isSkeleton = true;

  final Category category;
  final bool _isSkeleton;

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget.fromChild(
      isLoading: _isSkeleton,
      child: InkWell(
        onTap: () {
          if (_isSkeleton) return;
          AppNavigator.to(SubCategoriesPage(categoryId: category.id));
        },
        child: Column(
          children: [
            if (_isSkeleton) ...[
              ShimmerWidget.circular(diameter: 70.r),
            ] else ...[
              ImageWidget(
                imageUrl: category.image,
                height: 70.r,
                width: 70.r,
                shape: BoxShape.circle,
              ),
            ],
            Text(
              _isSkeleton ? LocaleKeys.category.tr() : category.name,
              style: context.appTextStyle.elevatedButtonTextStyle,
            ),
          ],
        ).withSpacing(spacing: 8.h),
      ),
    );
  }
}
