part of '../presentation_imports.dart';

class CategoriesHorizontalList extends StatelessWidget {
  const CategoriesHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text("Categories", style: context.appTextStyle.elevatedButtonTextStyle),
        ),
        BlocSelector<CategoryCubit, CategoryState, ({UsecaseStatus status, Failure? failure, List<Category> categories})>(
          selector: (state) => (status: state.categoriesStatus, failure: state.categoriesFailure, categories: state.categories),
          builder: (context, state) {
            return SizedBox(
              height: 150.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return CategoryCard(category);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
