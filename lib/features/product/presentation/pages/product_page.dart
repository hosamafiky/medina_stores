part of '../presentation_imports.dart';

class ProductPage extends StatelessWidget {
  const ProductPage(this.product, {super.key, required this.cubit});

  final Product product;
  final ProductCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: ProductPageBody(product),
    );
  }
}

class ProductPageBody extends StatefulWidget {
  const ProductPageBody(this.product, {super.key});

  final Product product;

  @override
  State<ProductPageBody> createState() => _ProductPageBodyState();
}

class _ProductPageBodyState extends State<ProductPageBody> {
  @override
  void initState() {
    Future.wait([
      context.read<ProductCubit>().getProductDetails(widget.product.slug),
      context.read<ProductCubit>().getRelatedProducts(widget.product.slug),
      context.read<ProductCubit>().getYouMayLikeProducts(widget.product.slug),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text(widget.product.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              final uri = Uri(
                scheme: 'http',
                host: ApiConstants.domain.split('//').last,
                pathSegments: ['products', Uri.encodeComponent(widget.product.slug)],
              );
              await ShareHelper.shareLink(uri);
            },
          ),
        ],
      ),
      body: BlocSelector<ProductCubit, ProductState, ({ProductDetails? details, UsecaseStatus status, Failure? failure})>(
        selector: (state) => (details: state.productDetails.data, status: state.productDetailsStatus, failure: state.productDetailsFailure),
        builder: (context, state) {
          if (state.status == UsecaseStatus.error) {
            return ErrorViewWidget(state.failure!, onRetry: () async {
              await Future.wait([
                context.read<ProductCubit>().getProductDetails(widget.product.slug),
                context.read<ProductCubit>().getRelatedProducts(widget.product.slug),
                context.read<ProductCubit>().getYouMayLikeProducts(widget.product.slug),
              ]);
            });
          }
          final productDetails = state.details ?? ProductDetails.fromProduct(widget.product);
          return CustomScrollView(
            slivers: [
              // PRODUCT DETAILS
              SliverList.list(
                children: [
                  if (productDetails.data.images.isNotEmpty) ...[
                    // Product Image
                    SizedBox(height: 16.h),
                    SizedBox(
                      height: 200.h,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 0.85),
                        itemCount: productDetails.data.images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: REdgeInsets.symmetric(horizontal: 10),
                            child: ImageWidget(
                              borderRadius: BorderRadius.circular(8.r),
                              imageUrl: productDetails.data.images[index].image,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(category.name),
                                  SizedBox(
                                    width: 150.w,
                                    child: AppDropdown<Option>(
                                      label: null,
                                      hint: LocaleKeys.select_hint.tr(),
                                      items: category.options,
                                      itemMapper: (option) => DropdownMenuItem<Option>(
                                        value: option,
                                        child: Text(option.optionName.name),
                                      ),
                                      onChanged: (newValue) {
                                        // Handle option selection change
                                      },
                                    ),
                                  ),
                                ],
                              ).withSpacing(spacing: 8),
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
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),

              // RELATED PRODUCTS
              if (context.read<ProductCubit>().state.relatedProducts.data!.isNotEmpty) ...[
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
                const RelatedProductsSection(),
              ],

              // YOU MAY LIKE PRODUCTS
              if (context.read<ProductCubit>().state.youMayLikeProducts.data!.isNotEmpty) ...[
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      Text(
                        LocaleKeys.you_may_also_like.tr(),
                        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ).asSliver,
                const YouMayLikeProductsSection(),
              ],
            ],
          );
        },
      ),
    );
  }
}
