part of '../presentation_imports.dart';

class LatestProductsSection extends StatelessWidget {
  const LatestProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductCubit, ProductState, ({UsecaseStatus status, Failure? failure, PaginatedList<Product> products})>(
      selector: (state) {
        return (
          status: state.latestProductsStatus,
          failure: state.latestProductsFailure,
          products: state.latestProducts.data!,
        );
      },
      builder: (context, state) {
        return state.status.when(
          context,
          idle: (_) => const SizedBox().asSliver,
          running: (_) => const _LatestProductsList.skeleton(),
          completed: (_) => _LatestProductsList(state.products),
          error: (_) => ErrorViewWidget(
            state.failure!,
            onRetry: () => context.read<ProductCubit>().getLatestProducts(1),
          ).asSliver,
        );
      },
    );
  }
}

class _LatestProductsList extends StatefulWidget {
  const _LatestProductsList(this.products) : _isSkeleton = false;

  const _LatestProductsList.skeleton()
      : products = const PaginatedList(data: []),
        _isSkeleton = true;

  final bool _isSkeleton;
  final PaginatedList<Product> products;

  @override
  State<_LatestProductsList> createState() => _LatestProductsListState();
}

class _LatestProductsListState extends State<_LatestProductsList> {
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
    return SliverMainAxisGroup(
      slivers: [
        SliverDynamicHeightGridView(
          controller: _scrollController,
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
          crossAxisCount: 3,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          itemCount: widget._isSkeleton ? 6 : widget.products.data.length,
          builder: (context, index) {
            if (widget._isSkeleton) return ProductWidget.skeleton();
            final product = widget.products.data[index];
            return ProductWidget(product);
          },
        ),
        if (!widget.products.hasReachedEnd && !widget._isSkeleton) ...[
          const Center(child: CircularProgressIndicator.adaptive()).asSliver,
        ],
      ],
    );
  }
}
