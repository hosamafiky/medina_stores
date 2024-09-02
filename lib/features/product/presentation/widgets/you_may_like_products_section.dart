part of '../presentation_imports.dart';

class YouMayLikeProductsSection extends StatelessWidget {
  const YouMayLikeProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductCubit, ProductState, List<Product>?>(
      selector: (state) => state.youMayLikeProducts.data,
      builder: (context, youMayLikeProducts) {
        if (youMayLikeProducts!.isEmpty) return const SizedBox();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Products you may like',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            //TODO: NEEDS REFACTOR TO SLIVER
            DynamicHeightGridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.h,
              itemCount: youMayLikeProducts.length,
              builder: (context, index) {
                final product = youMayLikeProducts[index];
                return ProductWidget(product);
              },
            ),
          ],
        );
      },
    );
  }
}
