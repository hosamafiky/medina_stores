part of '../presentation_imports.dart';

class SubCategoriesHorizontalList extends StatelessWidget {
  const SubCategoriesHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: BlocSelector<SubCategoryCubit, SubCategoryState, ({UsecaseStatus status, Failure? failure, List<SubCategory> subCategories})>(
        selector: (state) => (status: state.subCategoriesStatus, failure: state.subCategoriesFailure, subCategories: state.subCategories),
        builder: (context, state) {
          final isLoading = state.status == UsecaseStatus.running;
          if (isLoading) {
            return const _SubCategoriesList.skeleton();
          }
          if (state.failure != null) {
            return Center(child: Text("Failed to load sub categories ${state.failure!.response.message}"));
          }
          if (state.subCategories.isEmpty) {
            return const Center(child: Text("No sub categories found"));
          }

          return _SubCategoriesList(state.subCategories);
        },
      ),
    );
  }
}

class _SubCategoriesList extends StatelessWidget {
  const _SubCategoriesList(this.subCategories) : _isSkeleton = false;

  const _SubCategoriesList.skeleton()
      : _isSkeleton = true,
        subCategories = const [];

  final List<SubCategory> subCategories;
  final bool _isSkeleton;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: _isSkeleton ? 5 : subCategories.length,
      separatorBuilder: (context, index) => SizedBox(width: 16.w),
      itemBuilder: (context, index) {
        if (_isSkeleton) return SubCategoryCard.skeleton();
        final subCategory = subCategories[index];
        return SubCategoryCard(subCategory);
      },
    );
  }
}
