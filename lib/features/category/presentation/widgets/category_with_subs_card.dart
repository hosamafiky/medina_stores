part of '../presentation_imports.dart';

class CategoryWithSubsCard extends StatelessWidget {
  const CategoryWithSubsCard(this.category, {super.key}) : _isSkeleton = false;

  CategoryWithSubsCard.skeleton({super.key})
      : category = Category.empty(),
        _isSkeleton = true;

  final Category category;

  final bool _isSkeleton;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerWidget.fromChild(
          isLoading: _isSkeleton,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Text(
              _isSkeleton ? LocaleKeys.category.tr() : category.name.capitalize,
              style: context.appTextStyle.elevatedButtonTextStyle,
            ),
          ),
        ),
        if (category.children.isEmpty && !_isSkeleton)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(LocaleKeys.empty_sub_categories.tr()),
          ),
        DynamicHeightGridView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          crossAxisCount: 4,
          itemCount: _isSkeleton ? 4 : category.children.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          builder: (context, index) {
            if (_isSkeleton) return SubCategoryCard.skeleton();
            final subCategory = category.children[index];
            return SubCategoryCard(subCategory);
          },
        ),
      ],
    );
  }
}
