part of '../presentation_imports.dart';

class SubCategoryCard extends StatelessWidget {
  const SubCategoryCard(this.subCategory, {super.key});

  final SubCategory subCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageWidget(
          imageUrl: subCategory.image,
          height: 70.r,
          width: 70.r,
          shape: BoxShape.circle,
        ),
        Text(subCategory.name, style: context.appTextStyle.elevatedButtonTextStyle),
      ],
    ).withSpacing(spacing: 8.h);
  }
}
