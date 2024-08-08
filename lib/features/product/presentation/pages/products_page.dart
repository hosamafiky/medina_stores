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
      body: BlocSelector<ProductCubit, ProductState, ({UsecaseStatus status, Failure? failure, List<Product> products})>(
        selector: (state) => (status: state.productsStatus, failure: state.productsFailure, products: state.products),
        builder: (context, state) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 16.h).copyWith(
              top: context.statusBarHeight + 16.h,
              bottom: context.bottomBarHeight + 16.h,
            ),
            itemCount: state.products.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ListTile(
                leading: Text(product.id.toString()),
                title: Text(product.name),
                subtitle: Text(
                  product.address,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(DateFormat.jm().format(product.createdAt)),
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
