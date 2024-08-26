part of '../presentation_imports.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(this.category, {super.key});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppNavigator.to(SubCategoriesPage(categoryId: category.id));
      },
      child: Column(
        children: [
          ImageWidget(
            imageUrl: category.image,
            height: 70.r,
            width: 70.r,
            shape: BoxShape.circle,
          ),
          Text(category.name, style: context.appTextStyle.elevatedButtonTextStyle),
        ],
      ).withSpacing(spacing: 8.h),
    );
  }
}
