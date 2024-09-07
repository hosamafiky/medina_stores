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
    return BlocSelector<ProductCubit, ProductState, ({UsecaseStatus status, Failure? failure, PaginatedList<Product> data})>(
      selector: (state) => (
        status: state.favoriteProductsStatus,
        failure: state.favoriteProductsFailure,
        data: state.favoriteProducts.data!,
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

class _FavoriteProductsList extends StatefulWidget {
  const _FavoriteProductsList(this.products) : _isSkeleton = false;

  const _FavoriteProductsList.skeleton()
      : products = const PaginatedList(data: []),
        _isSkeleton = true;

  final bool _isSkeleton;
  final PaginatedList<Product> products;

  @override
  State<_FavoriteProductsList> createState() => _FavoriteProductsListState();
}

class _FavoriteProductsListState extends State<_FavoriteProductsList> {
  final _scrollController = ScrollController();

  void _onScroll() {
    final currentScroll = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;

    if (currentScroll == maxScroll) {
      context.read<ProductCubit>().getFavouriteProducts();
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
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<ProductCubit>().getFavouriteProducts(1);
      },
      child: CustomScrollView(
        slivers: [
          SliverDynamicHeightGridView(
            controller: _scrollController,
            padding: REdgeInsets.all(16.0),
            crossAxisCount: 3,
            builder: (context, index) {
              if (widget._isSkeleton) return ProductWidget.skeleton();

              final product = widget.products.data[index];
              return ProductWidget(product);
            },
            itemCount: widget._isSkeleton ? 6 : widget.products.data.length,
          ),
          if (!widget.products.hasReachedEnd && !widget._isSkeleton) ...[
            const Center(child: CircularProgressIndicator.adaptive()).asSliver,
          ],
        ],
      ),
    );
  }
}
