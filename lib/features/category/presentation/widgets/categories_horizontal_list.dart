part of '../presentation_imports.dart';

class CategoriesHorizontalList extends StatelessWidget {
  const CategoriesHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state.categoriesStatus == UsecaseStatus.error) {
          MessageHelper.showErrorSnackBar("Failed to load categories ${state.categoriesFailure!.response.message}");
        }
        if (state.categoriesStatus == UsecaseStatus.completed) {
          for (final category in state.categories) {
            context.read<SubCategoryCubit>().getSubCategories(category.id);
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(LocaleKeys.categories.tr(), style: context.appTextStyle.elevatedButtonTextStyle),
          ),
          BlocSelector<CategoryCubit, CategoryState, ({UsecaseStatus status, Failure? failure, List<Category> categories})>(
            selector: (state) => (status: state.categoriesStatus, failure: state.categoriesFailure, categories: state.categories),
            builder: (context, state) {
              final isLoading = state.status == UsecaseStatus.running;
              if (isLoading) return const _CategoriesList.skeleton();
              if (state.failure != null) {
                return Center(child: Text("Failed to load categories ${state.failure!.response.message}"));
              }
              if (state.categories.isEmpty) {
                return Center(child: Text(LocaleKeys.empty_categories.tr()));
              }
              return _CategoriesList(state.categories);
            },
          ),
        ],
      ),
    );
  }
}

class _CategoriesList extends StatelessWidget {
  const _CategoriesList(this.categories) : _isSkeleton = false;

  const _CategoriesList.skeleton()
      : _isSkeleton = true,
        categories = const [];

  final List<Category> categories;
  final bool _isSkeleton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        scrollDirection: Axis.horizontal,
        itemCount: _isSkeleton ? 5 : categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 16.w),
        itemBuilder: (context, index) {
          if (_isSkeleton) return CategoryCard.skeleton();
          final category = categories[index];
          return CategoryCard(category);
        },
      ),
    );
  }
}
