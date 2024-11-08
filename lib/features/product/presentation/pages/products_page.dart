part of '../presentation_imports.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage.subCategory(this.subCategory, {super.key}) : brand = null;

  ProductsPage.brand(this.brand, {super.key}) : subCategory = SubCategory.empty();

  final SubCategory subCategory;
  final Brand? brand;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.serviceLocator<ProductCubit>(param1: subCategory, param2: brand)..getProducts(brand, subCategory),
      child: const ProductsPageBody(),
    );
  }
}

class ProductsPageBody extends StatefulWidget {
  const ProductsPageBody({super.key});

  @override
  State<ProductsPageBody> createState() => _ProductsPageBodyState();
}

class _ProductsPageBodyState extends State<ProductsPageBody> {
  final _scrollController = ScrollController();

  void _onScroll() {
    final currentScroll = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;

    if (currentScroll == maxScroll) {
      context.read<ProductCubit>().getProductsByCategoryId();
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subCategory = context.watch<ProductCubit>().state.subCategory;
    final brand = context.watch<ProductCubit>().state.brand;
    return Scaffold(
      appBar: MainAppBar(centerTitle: true, title: Text(brand?.name ?? subCategory!.name)),
      body: BlocSelector<ProductCubit, ProductState, ({UsecaseStatus status, Failure? failure, PaginatedList<Product> products})>(
        selector: (state) => (status: state.productsStatus, failure: state.productsFailure, products: state.categoryOrBrandProducts.data!),
        builder: (context, state) {
          return state.status.when(
            context,
            running: (context) => CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: REdgeInsets.all(16.0),
                  sliver: SliverDynamicHeightGridView(
                    controller: _scrollController,
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    itemCount: 6,
                    builder: (context, index) => ProductWidget.skeleton(),
                  ),
                ),
              ],
            ),
            completed: (context) {
              if (state.products.list.isEmpty) {
                return Center(child: Text(LocaleKeys.empty_products.tr()));
              }
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: REdgeInsets.symmetric(horizontal: 20, vertical: 20).copyWith(
                      bottom: context.bottomBarHeight + 20.h,
                    ),
                    sliver: SliverDynamicHeightGridView(
                      controller: _scrollController,
                      crossAxisCount: 3,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      itemCount: state.products.list.length,
                      builder: (context, index) {
                        final product = state.products.list[index];
                        return ProductWidget(product);
                      },
                    ),
                  ),
                  if (!state.products.hasReachedEnd) const Center(child: CircularProgressIndicator.adaptive()).asSliver,
                ],
              );
            },
            error: (context) => Padding(
              padding: REdgeInsets.all(16.0),
              child: Center(child: Text(state.failure!.response.message)),
            ),
          );
        },
      ),
    );
  }
}
