part of '../presentation_imports.dart';

class SubCategoriesHorizontalList extends StatelessWidget {
  const SubCategoriesHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SubCategoryCubit, SubCategoryState, ({UsecaseStatus status, Failure? failure, List<SubCategory> subCategories})>(
      selector: (state) => (status: state.subCategoriesStatus, failure: state.subCategoriesFailure, subCategories: state.subCategories),
      builder: (context, state) {
        return SizedBox(
          height: 150.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            itemCount: state.subCategories.length,
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              final subCategory = state.subCategories[index];
              return SubCategoryCard(subCategory);
            },
          ),
        );
      },
    );
  }
}
