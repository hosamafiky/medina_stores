part of '../presentation_imports.dart';

class RelatedProductsSection extends StatelessWidget {
  const RelatedProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductCubit, ProductState, List<Product>?>(
      selector: (state) => state.relatedProducts.data,
      builder: (context, relatedProducts) {
        if (relatedProducts!.isEmpty) return const SizedBox();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.related_products.tr(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            //TODO: NEEDS REFACTOR TO SLIVER
            DynamicHeightGridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.h,
              itemCount: relatedProducts.length,
              builder: (context, index) {
                final product = relatedProducts[index];
                return ProductWidget(product);
              },
            ),
          ],
        ).withSpacing(spacing: 8.h);
      },
    );
  }
}