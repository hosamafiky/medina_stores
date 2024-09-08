part of '../presentation_imports.dart';

class SuggestedProductsSection extends StatelessWidget {
  const SuggestedProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductCubit, ProductState, ({UsecaseStatus status, Failure? failure, List<Product> products})>(
      selector: (state) {
        return (
          status: state.suggestedCartProductsStatus,
          failure: state.suggestedCartProductsFailure,
          products: state.suggestedCartProducts,
        );
      },
      builder: (context, state) {
        final isLoading = state.status == UsecaseStatus.running;
        if (state.status == UsecaseStatus.error) {
          return ErrorViewWidget(
            state.failure!,
            onRetry: () => context.read<ProductCubit>().getSuggestedCartProducts(),
          ).asSliver;
        }

        if (state.products.isEmpty && !isLoading) {
          return Center(child: Text(LocaleKeys.empty_products.tr())).asSliver;
        }

        return SliverDynamicHeightGridView(
          padding: REdgeInsets.symmetric(horizontal: 16),
          itemCount: isLoading ? 6 : state.products.length,
          crossAxisCount: 3,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          builder: (context, index) {
            if (isLoading) return ProductWidget.skeleton();
            final product = state.products[index];
            return ProductWidget(product);
          },
        );
      },
    );
  }
}
