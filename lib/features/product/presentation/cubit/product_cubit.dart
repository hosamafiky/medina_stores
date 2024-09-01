part of '../presentation_imports.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required this.getProductsUsecase,
    required this.getBrandProductsUsecase,
    Brand? brand,
    required SubCategory subCategory,
  }) : super(ProductState(subCategory: subCategory, brand: brand));

  final GetCategoryProductsUsecase getProductsUsecase;
  final GetBrandProductsUsecase getBrandProductsUsecase;

  Future<void> getProducts(Brand? brand, SubCategory subCategory) async {
    if (brand != null) {
      await getProductsByBrandId();
    } else {
      await getProductsByCategoryId();
    }
  }

  Future<void> getProductsByCategoryId() async {
    if (state.products.data?.hasReachedEnd == true) return;
    if (state.products.data?.currentPage == 0) emit(state.copyWith(productsStatus: UsecaseStatus.running));
    final params = GetCategoryProductsParams(
      subCategoryId: state.subCategory.id,
      page: (state.products.data!.currentPage) + 1,
      perPage: 5,
    );
    final result = await getProductsUsecase(params);
    result.fold(
      (failure) => emit(state.copyWith(
        productsStatus: UsecaseStatus.error,
        productsFailure: failure,
      )),
      (products) {
        final newProducts = List<ProductModel>.from(products.data!.data.map((e) => ProductModel.fromProduct(e)));
        final oldProducts = List<ProductModel>.from(state.products.data!.data.map((e) => ProductModel.fromProduct(e)));
        if (newProducts.isEmpty) {
          final paginatedList = state.products.data?.map<ProductModel>((e) => ProductModel.fromProduct(e)).copyWith(
                data: oldProducts,
                hasReachedEnd: true,
              );
          emit(state.copyWith(
            productsStatus: UsecaseStatus.completed,
            products: products.copyWith(
              data: PaginatedListModel<ProductModel>.from(paginatedList!),
            ),
          ));
        } else {
          final oldChats = List<ProductModel>.from(state.products.data!.data.map((e) => ProductModel.fromProduct(e)));
          final paginatedList = PaginatedList<ProductModel>(
            data: [...oldChats, ...newProducts],
            currentPage: products.data!.currentPage,
            lastPage: products.data!.lastPage,
            itemsCount: products.data!.itemsCount,
            hasReachedEnd: products.data!.hasReachedEnd,
          );
          emit(state.copyWith(
            productsStatus: UsecaseStatus.completed,
            products: products.copyWith(
              data: PaginatedListModel<ProductModel>.from(paginatedList),
            ),
          ));
        }
      },
    );
  }

  Future<void> getProductsByBrandId() async {
    if (state.products.data?.hasReachedEnd == true) return;
    if (state.products.data?.currentPage == 0) emit(state.copyWith(productsStatus: UsecaseStatus.running));
    final params = GetBrandProductsParams(
      brandId: state.brand!.id,
      page: (state.products.data!.currentPage) + 1,
      perPage: 5,
    );
    final result = await getBrandProductsUsecase(params);
    result.fold(
      (failure) => emit(state.copyWith(
        productsStatus: UsecaseStatus.error,
        productsFailure: failure,
      )),
      (products) {
        final newProducts = List<ProductModel>.from(products.data!.data.map((e) => ProductModel.fromProduct(e)));
        final oldProducts = List<ProductModel>.from(state.products.data!.data.map((e) => ProductModel.fromProduct(e)));
        if (newProducts.isEmpty) {
          final paginatedList = state.products.data?.map<ProductModel>((e) => ProductModel.fromProduct(e)).copyWith(
                data: oldProducts,
                hasReachedEnd: true,
              );
          emit(state.copyWith(
            productsStatus: UsecaseStatus.completed,
            products: products.copyWith(
              data: PaginatedListModel<ProductModel>.from(paginatedList!),
            ),
          ));
        } else {
          final paginatedList = PaginatedList<ProductModel>(
            data: [...oldProducts, ...newProducts],
            currentPage: products.data!.currentPage,
            lastPage: products.data!.lastPage,
            itemsCount: products.data!.itemsCount,
            hasReachedEnd: products.data!.hasReachedEnd,
          );
          emit(state.copyWith(
            productsStatus: UsecaseStatus.completed,
            products: products.copyWith(
              data: PaginatedListModel<ProductModel>.from(paginatedList),
            ),
          ));
        }
      },
    );
  }
}
