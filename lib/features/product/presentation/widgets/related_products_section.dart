part of '../presentation_imports.dart';

class RelatedProductsSection extends StatelessWidget {
  const RelatedProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductCubit, ProductState, List<Product>>(
      selector: (state) => state.relatedProducts.data!,
      builder: (context, relatedProducts) {
        return SliverDynamicHeightGridView(
          padding: REdgeInsets.symmetric(horizontal: 16),
          crossAxisCount: 3,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          itemCount: relatedProducts.length,
          builder: (context, index) {
            final product = relatedProducts[index];
            return ProductWidget(product);
          },
        );
      },
    );
  }
}
