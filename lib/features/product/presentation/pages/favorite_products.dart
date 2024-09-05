part of '../presentation_imports.dart';

class FavoriteProducts extends StatelessWidget {
  const FavoriteProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.get<ProductCubit>()..getFavouriteProducts(),
      child: Scaffold(
        appBar: MainAppBar(
          title: Text(LocaleKeys.favorite_products.tr()),
        ),
        body: const _FavoriteProductsBody(),
      ),
    );
  }
}

class _FavoriteProductsBody extends StatelessWidget {
  const _FavoriteProductsBody();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductCubit, ProductState, ({UsecaseStatus status, Failure? failure, List<Product> data})>(
      selector: (state) => (
        status: state.favoriteProductsStatus,
        failure: state.favoriteProductsFailure,
        data: state.favoriteProducts.data!.data,
      ),
      builder: (context, state) {
        return state.status.when(
          context,
          running: (context) => const _FavoriteProductsList.skeleton(),
          error: (context) => ErrorViewWidget(
            state.failure!,
            onRetry: () => context.read<ProductCubit>().getFavouriteProducts(),
          ),
          completed: (context) {
            final products = state.data;
            return _FavoriteProductsList(products);
          },
        );
      },
    );
  }
}

class _FavoriteProductsList extends StatelessWidget {
  const _FavoriteProductsList(this.products) : _isSkeleton = false;

  const _FavoriteProductsList.skeleton()
      : products = const [],
        _isSkeleton = true;

  final bool _isSkeleton;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<ProductCubit>().getFavouriteProducts();
      },
      child: CustomScrollView(
        slivers: [
          SliverDynamicHeightGridView(
            padding: REdgeInsets.all(16.0),
            crossAxisCount: 3,
            builder: (context, index) {
              if (_isSkeleton) return ProductWidget.skeleton();
              final product = products[index];
              return ProductWidget(product);
            },
            itemCount: _isSkeleton ? 6 : products.length,
          ),
        ],
      ),
    );
  }
}
