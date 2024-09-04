part of '../presentation_imports.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required this.getProductsUsecase,
    required this.getBrandProductsUsecase,
    required this.getProductDetailsUsecase,
    required this.getRelatedProductsUsecase,
    required this.getYouMayLikeProductsUsecase,
    required this.getFavouriteProductsUsecase,
    required this.toggleFavoriteUsecase,
    Brand? brand,
    SubCategory? subCategory,
  }) : super(ProductState(subCategory: subCategory, brand: brand));

  final GetCategoryProductsUsecase getProductsUsecase;
  final GetBrandProductsUsecase getBrandProductsUsecase;
  final GetProductDetailsUsecase getProductDetailsUsecase;
  final GetRelatedProductsUsecase getRelatedProductsUsecase;
  final GetYouMayLikeProductsUsecase getYouMayLikeProductsUsecase;
  final GetFavouriteProductsUsecase getFavouriteProductsUsecase;
  final ToggleFavoriteUsecase toggleFavoriteUsecase;

  Future<void> getProducts(Brand? brand, SubCategory subCategory) async {
    if (brand != null) {
      await getProductsByBrandId();
    } else {
      await getProductsByCategoryId();
    }
  }

  Future<void> getProductsByCategoryId() async {
    assert(state.subCategory?.id != null, 'SubCategory ID is required');
    if (state.categoryOrBrandProducts.data?.hasReachedEnd == true) return;
    if (state.categoryOrBrandProducts.data?.currentPage == 0) emit(state.copyWith(productsStatus: UsecaseStatus.running));
    final params = GetCategoryProductsParams(
      subCategoryId: state.subCategory!.id,
      page: (state.categoryOrBrandProducts.data!.currentPage) + 1,
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
        final oldProducts = List<ProductModel>.from(state.categoryOrBrandProducts.data!.data.map((e) => ProductModel.fromProduct(e)));
        if (newProducts.isEmpty) {
          final paginatedList = state.categoryOrBrandProducts.data?.map<ProductModel>((e) => ProductModel.fromProduct(e)).copyWith(
                data: oldProducts,
                hasReachedEnd: true,
              );
          emit(state.copyWith(
            productsStatus: UsecaseStatus.completed,
            categoryOrBrandProducts: products.copyWith(
              data: PaginatedListModel<ProductModel>.from(paginatedList!),
            ),
          ));
        } else {
          final oldChats = List<ProductModel>.from(state.categoryOrBrandProducts.data!.data.map((e) => ProductModel.fromProduct(e)));
          final paginatedList = PaginatedList<ProductModel>(
            data: [...oldChats, ...newProducts],
            currentPage: products.data!.currentPage,
            lastPage: products.data!.lastPage,
            itemsCount: products.data!.itemsCount,
            hasReachedEnd: products.data!.hasReachedEnd,
          );
          emit(state.copyWith(
            productsStatus: UsecaseStatus.completed,
            categoryOrBrandProducts: products.copyWith(
              data: PaginatedListModel<ProductModel>.from(paginatedList),
            ),
          ));
        }
      },
    );
  }

  Future<void> getProductsByBrandId() async {
    assert(state.brand?.id != null, 'Brand ID is required');
    if (state.categoryOrBrandProducts.data?.hasReachedEnd == true) return;
    if (state.categoryOrBrandProducts.data?.currentPage == 0) emit(state.copyWith(productsStatus: UsecaseStatus.running));
    final params = GetBrandProductsParams(
      brandId: state.brand!.id,
      page: (state.categoryOrBrandProducts.data!.currentPage) + 1,
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
        final oldProducts = List<ProductModel>.from(state.categoryOrBrandProducts.data!.data.map((e) => ProductModel.fromProduct(e)));
        if (newProducts.isEmpty) {
          final paginatedList = state.categoryOrBrandProducts.data?.map<ProductModel>((e) => ProductModel.fromProduct(e)).copyWith(
                data: oldProducts,
                hasReachedEnd: true,
              );
          emit(state.copyWith(
            productsStatus: UsecaseStatus.completed,
            categoryOrBrandProducts: products.copyWith(
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
            categoryOrBrandProducts: products.copyWith(
              data: PaginatedListModel<ProductModel>.from(paginatedList),
            ),
          ));
        }
      },
    );
  }

  Future<void> getProductDetails(String slug) async {
    emit(state.copyWith(
      productDetailsStatus: UsecaseStatus.running,
      productDetails: const ApiResponse(data: null),
    ));
    final result = await getProductDetailsUsecase(slug);
    result.fold(
      (failure) => emit(state.copyWith(
        productDetailsStatus: UsecaseStatus.error,
        productDetailsFailure: failure,
      )),
      (product) => emit(state.copyWith(
        productDetailsStatus: UsecaseStatus.completed,
        productDetails: product,
      )),
    );
  }

  Future<void> getRelatedProducts(String slug) async {
    final result = await getRelatedProductsUsecase(slug);
    result.fold(
      (failure) => emit(state.copyWith(
        productDetailsStatus: UsecaseStatus.error,
        productDetailsFailure: failure,
      )),
      (product) => emit(state.copyWith(
        productDetailsStatus: UsecaseStatus.completed,
        relatedProducts: product,
      )),
    );
  }

  Future<void> getYouMayLikeProducts(String slug) async {
    final result = await getYouMayLikeProductsUsecase(slug);
    result.fold(
      (failure) => emit(state.copyWith(
        productDetailsStatus: UsecaseStatus.error,
        productDetailsFailure: failure,
      )),
      (products) => emit(state.copyWith(
        productDetailsStatus: UsecaseStatus.completed,
        youMayLikeProducts: products,
      )),
    );
  }

  Future<void> toggleProductFavourite(int productId, bool value) async {
    setProductFavourite(productId: productId, value: value);
    final result = await toggleFavoriteUsecase(productId);
    result.fold(
      (failure) => setProductFavourite(productId: productId, value: !value),
      (products) => emit(state.copyWith(productDetailsStatus: UsecaseStatus.completed)),
    );
  }

  Future<void> setProductFavourite({required int productId, required bool value}) async {
    final categoryOrBrandProductIndex = state.categoryOrBrandProducts.data!.data.indexWhere((element) => element.id == productId);
    final relatedProductIndex = state.relatedProducts.data!.indexWhere((element) => element.id == productId);
    final youMayLikeProductIndex = state.youMayLikeProducts.data!.indexWhere((element) => element.id == productId);
    final favoriteIndex = state.favoriteProducts.data!.data.indexWhere((element) => element.id == productId);
    final product = categoryOrBrandProductIndex != -1
        ? state.categoryOrBrandProducts.data!.data[categoryOrBrandProductIndex]
        : relatedProductIndex != -1
            ? state.relatedProducts.data![relatedProductIndex]
            : youMayLikeProductIndex != -1
                ? state.youMayLikeProducts.data![youMayLikeProductIndex]
                : state.favoriteProducts.data!.data[favoriteIndex];

    if (categoryOrBrandProductIndex != -1) {
      emit(state.copyWith(
        categoryOrBrandProducts: state.categoryOrBrandProducts.copyWith(
          data: state.categoryOrBrandProducts.data!.copyWith(
              data: state.categoryOrBrandProducts.data!.data.updateProductAtIndex<ProductModel>(
            categoryOrBrandProductIndex,
            ProductModel.fromProduct(product.copyWith(isFavourite: value)),
          )),
        ),
      ));
    }

    if (relatedProductIndex != -1) {
      emit(state.copyWith(
        relatedProducts: state.relatedProducts.copyWith(
          data: state.relatedProducts.data!.updateProductAtIndex<ProductModel>(
            relatedProductIndex,
            ProductModel.fromProduct(product.copyWith(isFavourite: value)),
          ),
        ),
      ));
    }

    if (youMayLikeProductIndex != -1) {
      emit(state.copyWith(
        youMayLikeProducts: state.youMayLikeProducts.copyWith(
          data: state.youMayLikeProducts.data!.updateProductAtIndex<ProductModel>(
            youMayLikeProductIndex,
            ProductModel.fromProduct(product.copyWith(isFavourite: value)),
          ),
        ),
      ));
    }

    if (favoriteIndex != -1) {
      emit(state.copyWith(
        favoriteProducts: state.favoriteProducts.copyWith(
          data: state.favoriteProducts.data!.copyWith(
              data: state.favoriteProducts.data!.data.updateProductAtIndex<ProductModel>(
            favoriteIndex,
            ProductModel.fromProduct(product.copyWith(isFavourite: value)),
            isRemove: !value,
          )),
        ),
      ));
    }
  }

  Future<void> getFavouriteProducts() async {
    emit(state.copyWith(favoriteProductsStatus: UsecaseStatus.running));
    final result = await getFavouriteProductsUsecase();
    result.fold(
      (failure) => emit(state.copyWith(
        favoriteProductsStatus: UsecaseStatus.error,
        favoriteProductsFailure: failure,
      )),
      (products) => emit(state.copyWith(
        favoriteProductsStatus: UsecaseStatus.completed,
        favoriteProducts: products,
      )),
    );
  }
}
