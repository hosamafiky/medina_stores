part of '../presentation_imports.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.get<ProductCubit>()..getProducts(),
      child: const ProductsPageBody(),
    );
  }
}

class ProductsPageBody extends StatelessWidget {
  const ProductsPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: BlocSelector<ProductCubit, ProductState, ({UsecaseStatus status, Failure? failure, List<Product> products})>(
        selector: (state) => (status: state.productsStatus, failure: state.productsFailure, products: state.products),
        builder: (context, state) {
          return ListView.separated(
            itemCount: state.products.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ListTile(
                leading: Text(product.id.toString()),
                title: Text(product.title),
                subtitle: Text(
                  product.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cubit = context.read<ProductCubit>();
          await context.showSheet<Product>(child: AddProductSheet(productCubit: cubit));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
