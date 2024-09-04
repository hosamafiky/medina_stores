part of '../presentation_imports.dart';

class FavoriteProducts extends StatelessWidget {
  const FavoriteProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.get<ProductCubit>()..getFavouriteProducts(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Products'),
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
        return CustomScrollView(
          slivers: [
            SliverDynamicHeightGridView(
              padding: REdgeInsets.all(16.0),
              builder: (context, index) {
                final product = state.data[index];
                return ProductWidget(product);
              },
              itemCount: state.data.length,
              crossAxisCount: 3,
            ),
          ],
        );
      },
    );
  }
}
