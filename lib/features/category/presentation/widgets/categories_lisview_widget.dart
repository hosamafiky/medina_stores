part of '../presentation_imports.dart';

class CategoriesListViewWidget extends StatelessWidget {
  const CategoriesListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CategoryCubit, CategoryState, ({UsecaseStatus status, Failure? failure, List<Category> categories})>(
      selector: (state) => (status: state.categoriesStatus, failure: state.categoriesFailure, categories: state.categories),
      builder: (context, state) {
        final isLoading = state.status == UsecaseStatus.running;
        final isFailed = state.status == UsecaseStatus.error;
        final isCompleted = state.status == UsecaseStatus.completed;

        if (isFailed) {
          return ErrorViewWidget(
            state.failure!,
            onRetry: () => context.read<CategoryCubit>().getCategories(),
          ).asSliver;
        }
        if (state.categories.isEmpty && isCompleted) {
          return Center(child: Text(LocaleKeys.empty_sub_categories.tr())).asSliver;
        }

        return SliverList.separated(
          itemBuilder: (context, index) {
            if (isLoading) return CategoryWithSubsCard.skeleton();
            final category = state.categories[index];
            return CategoryWithSubsCard(category);
          },
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemCount: isLoading ? 2 : state.categories.length,
        );
      },
    );
  }
}
