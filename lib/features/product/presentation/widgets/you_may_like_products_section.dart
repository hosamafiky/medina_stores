part of '../presentation_imports.dart';

class YouMayLikeProductsSection extends StatelessWidget {
  const YouMayLikeProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductCubit, ProductState, List<Product>>(
      selector: (state) => state.youMayLikeProducts.data!,
      builder: (context, youMayLikeProducts) {
        return SliverDynamicHeightGridView(
          padding: REdgeInsets.symmetric(horizontal: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 20.h,
          itemCount: youMayLikeProducts.length,
          builder: (context, index) {
            final product = youMayLikeProducts[index];
            return ProductWidget(product);
          },
        );
      },
    );
  }
}
