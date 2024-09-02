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
              return Center(
                child: Text(state.failure!.response.message),
              );
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
                      height: 300,
                      width: double.infinity,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    const SizedBox(height: 16),
                  ],
                  // Product Name and Brand
                  Text(
                    productDetails.data.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${LocaleKeys.brand.tr()}: ${productDetails.data.brand.name}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Price and Discount
                  Row(
                    children: [
                      Text(
                        '\$${productDetails.data.priceAfterDiscount}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      if (productDetails.data.priceAfterDiscount < productDetails.data.price) ...[
                        const SizedBox(width: 8),
                        Text(
                          '\$${productDetails.data.price}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                      if (productDetails.data.price - productDetails.data.priceAfterDiscount > 0) ...[
                        const SizedBox(width: 8),
                        Text(
                          'Save \$${product.price - product.priceAfterDiscount}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
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
                        const SizedBox(height: 16),
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
                  const SizedBox(height: 8),
                  Text(
                    'SKU: ${productDetails.data.sku}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Add to Cart and Buy Now Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle Add to Cart
                          },
                          child: const Text('Add to Cart'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle Buy Now
                          },
                          child: const Text('Buy Now'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
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
