part of '../presentation_imports.dart';

class CategoriesLisViewWidget extends StatelessWidget {
  const CategoriesLisViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CategoryCubit, CategoryState, ({UsecaseStatus status, Failure? failure, List<Category> categories})>(
      selector: (state) => (status: state.categoriesStatus, failure: state.categoriesFailure, categories: state.categories),
      builder: (context, cState) {
        final isLoading = cState.status == UsecaseStatus.running;
        if (cState.failure != null) {
          return Center(child: Text(cState.failure!.response.message));
        }
        if (cState.categories.isEmpty && !isLoading) {
          return Center(child: Text(LocaleKeys.empty_sub_categories.tr()));
        }

        return SliverList.separated(
          itemBuilder: (context, index) {
            if (isLoading) return CategoryWithSubsCard.skeleton();
            final category = cState.categories[index];
            return CategoryWithSubsCard(category);
          },
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemCount: isLoading ? 2 : cState.categories.length,
        );
      },
    );
  }
}
