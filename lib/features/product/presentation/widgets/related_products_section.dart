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
          crossAxisCount: 2,
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 20.h,
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
