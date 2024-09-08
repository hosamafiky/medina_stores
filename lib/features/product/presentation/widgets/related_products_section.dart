part of '../presentation_imports.dart';

class RelatedProductsSection extends StatelessWidget {
  const RelatedProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Text(
                LocaleKeys.related_products.tr(),
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ).asSliver,
        BlocSelector<ProductCubit, ProductState, ({List<Product> relatedProducts, UsecaseStatus status, Failure? failure})>(
          selector: (state) => (
            relatedProducts: state.relatedProducts.data!,
            status: state.relatedProductsStatus,
            failure: state.relatedProductsFailure,
          ),
          builder: (context, state) {
            final isLoading = state.status == UsecaseStatus.running;
            if (state.status == UsecaseStatus.error) {
              return ErrorViewWidget(
                state.failure!,
                onRetry: () {
                  final productSlug = context.read<ProductCubit>().state.productDetails.data!.data.slug;
                  context.read<ProductCubit>().getRelatedProducts(productSlug);
                },
              ).asSliver;
            }
            return SliverDynamicHeightGridView(
              padding: REdgeInsets.symmetric(horizontal: 16),
              crossAxisCount: 3,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              itemCount: isLoading ? 6 : state.relatedProducts.length,
              builder: (context, index) {
                if (isLoading) return ProductWidget.skeleton();
                final product = state.relatedProducts[index];
                return ProductWidget(product);
              },
            );
          },
        ),
      ],
    );
  }
}
