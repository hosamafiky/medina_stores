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

        return SizedBox(
          height: 190.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: REdgeInsets.symmetric(horizontal: 16),
            itemCount: isLoading ? 6 : state.products.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final width = (1.sw - (58.w)) / 3;
              if (isLoading) return ProductWidget.skeleton(width: width);
              final product = state.products[index];
              return ProductWidget(product, width: width);
            },
          ),
        ).asSliver;
      },
    );
  }
}
