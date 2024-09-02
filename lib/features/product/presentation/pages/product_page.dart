part of '../presentation_imports.dart';

class ProductPage extends StatelessWidget {
  const ProductPage(this.product, {super.key, required this.cubit});

  final Product product;
  final ProductCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit
        ..getProductDetails(product.slug)
        ..getRelatedProducts(product.slug)
        ..getYouMayLikeProducts(product.slug),
      child: ProductPageBody(product),
    );
  }
}

class ProductPageBody extends StatelessWidget {
  const ProductPageBody(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text(product.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              final uri = Uri(
                scheme: 'http',
                host: ApiConstants.domain.split('//').last,
                pathSegments: ['products', Uri.encodeComponent(product.slug)],
              );
              await ShareHelper.shareLink(uri);
            },
          ),
        ],
      ),
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: BlocSelector<ProductCubit, ProductState, ({ProductDetails? details, UsecaseStatus status, Failure? failure})>(
          selector: (state) => (details: state.productDetails.data, status: state.productDetailsStatus, failure: state.productDetailsFailure),
          builder: (context, state) {
            if (state.status == UsecaseStatus.error) {
              return ErrorViewWidget(state.failure!, onRetry: () async {
                await Future.wait([
                  context.read<ProductCubit>().getProductDetails(product.slug),
                  context.read<ProductCubit>().getRelatedProducts(product.slug),
                  context.read<ProductCubit>().getYouMayLikeProducts(product.slug),
                ]);
              });
            }
            final productDetails = state.details ?? ProductDetails.fromProduct(product);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (productDetails.data.images.isNotEmpty) ...[
                    // Product Image
                    ImageWidget(
                      imageUrl: productDetails.data.images.first.image,
                      height: 300.h,
                      width: double.infinity,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    SizedBox(height: 16.h),
                  ],
                  // Product Name and Brand
                  Text(
                    productDetails.data.name,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${LocaleKeys.brand.tr()}: ${productDetails.data.brand.name}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Price and Discount
                  Row(
                    children: [
                      Text(
                        '\$${productDetails.data.priceAfterDiscount}',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      if (productDetails.data.priceAfterDiscount < productDetails.data.price) ...[
                        SizedBox(width: 8.w),
                        Text(
                          '\$${productDetails.data.price}',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                      if (productDetails.data.price - productDetails.data.priceAfterDiscount > 0) ...[
                        SizedBox(width: 8.w),
                        Text(
                          LocaleKeys.save_money.tr(namedArgs: {'amount': '${productDetails.data.price - productDetails.data.priceAfterDiscount}'}),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Option Selection
                  ...productDetails.optionCategories.map(
                    (category) => Column(
                      children: [
                        Row(
                          children: [
                            Text(category.name),
                            DropdownButton<Option>(
                              value: category.options.first,
                              items: category.options.map<DropdownMenuItem<Option>>((option) {
                                return DropdownMenuItem<Option>(
                                  value: option,
                                  child: Text(option.optionName.name),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                // Handle option selection change
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                  // Category and SKU
                  if (productDetails.data.categories.isNotEmpty) ...[
                    Wrap(
                      spacing: 8,
                      children: productDetails.data.categories.map((category) {
                        return Chip(
                          label: Text(category.name),
                        );
                      }).toList(),
                    ),
                  ],
                  SizedBox(height: 8.h),
                  Text(
                    'SKU: ${productDetails.data.sku}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  // Add to Cart and Buy Now Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle Add to Cart
                          },
                          child: Text(LocaleKeys.add_to_cart.tr()),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle Buy Now
                          },
                          child: Text(LocaleKeys.buy_now.tr()),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // RELATED PRODUCTS
                  const RelatedProductsSection(),
                  // YOU MAY LIKE PRODUCTS
                  const YouMayLikeProductsSection(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
