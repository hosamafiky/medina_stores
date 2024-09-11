part of '../presentation_imports.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required this.getProductsUsecase,
    required this.getBrandProductsUsecase,
    required this.getProductDetailsUsecase,
    required this.getRelatedProductsUsecase,
    required this.getYouMayLikeProductsUsecase,
    required this.getFavouriteProductsUsecase,
    required this.getSuggestedCartProductsUsecase,
    required this.getLatestProductsUsecase,
    required this.getProductNameSuggestionsUsecase,
    required this.getSearchProductsUsecase,
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
  final GetSuggestedCartProductsUsecase getSuggestedCartProductsUsecase;
  final GetLatestProductsUsecase getLatestProductsUsecase;
  final GetProductNameSuggestionsUsecase getProductNameSuggestionsUsecase;
  final GetSearchProductsUsecase getSearchProductsUsecase;
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
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        productsStatus: UsecaseStatus.error,
        productsFailure: failure,
      )),
      (products) {
        final newProducts = List<ProductModel>.from(products.data!.list.map((e) => ProductModel.fromProduct(e)));
        final oldProducts = List<ProductModel>.from(state.categoryOrBrandProducts.data!.list.map((e) => ProductModel.fromProduct(e)));
        if (newProducts.isEmpty) {
          final paginatedList = state.categoryOrBrandProducts.data?.map<ProductModel>((e) => ProductModel.fromProduct(e)).copyWith(
                list: oldProducts,
                hasReachedEnd: true,
              );
          emit(
            state.copyWith(
              productsStatus: UsecaseStatus.completed,
              categoryOrBrandProducts: products.copyWith(
                data: PaginatedListModel<ProductModel>.from(paginatedList!),
              ),
            ),
          );
        } else {
          final oldChats = List<ProductModel>.from(state.categoryOrBrandProducts.data!.list.map((e) => ProductModel.fromProduct(e)));
          final paginatedList = PaginatedList<ProductModel>(
            list: [...oldChats, ...newProducts],
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
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        productsStatus: UsecaseStatus.error,
        productsFailure: failure,
      )),
      (products) {
        final newProducts = List<ProductModel>.from(products.data!.list.map((e) => ProductModel.fromProduct(e)));
        final oldProducts = List<ProductModel>.from(state.categoryOrBrandProducts.data!.list.map((e) => ProductModel.fromProduct(e)));
        if (newProducts.isEmpty) {
          final paginatedList = state.categoryOrBrandProducts.data?.map<ProductModel>((e) => ProductModel.fromProduct(e)).copyWith(
                list: oldProducts,
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
            list: [...oldProducts, ...newProducts],
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

  Future<void> getProductNameSuggestions(String? query) async {
    final result = await getProductNameSuggestionsUsecase(query ?? '');
    if (isClosed) return;
    return result.fold(
      (error) => [],
      (suggestions) => emit(state.copyWith(
        productNameSuggestions: suggestions,
      )),
    );
  }

  void clearNameSuggestions() {
    emit(state.copyWith(productNameSuggestions: const ApiResponse(data: [])));
  }

  Future<void> search(String query) async {
    emit(state.copyWith(searchStatus: UsecaseStatus.running));
    final result = await getSearchProductsUsecase(query);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        searchStatus: UsecaseStatus.error,
        searchFailure: failure,
      )),
      (products) {
        final newProducts = List<ProductModel>.from(products.data!.list.map((e) => ProductModel.fromProduct(e)));
        // final oldProducts = List<ProductModel>.from(state.searchResults.data!.data.map((e) => ProductModel.fromProduct(e)));
        // if (newProducts.isEmpty) {
        //   final paginatedList = state.searchResults.data?.map<ProductModel>((e) => ProductModel.fromProduct(e)).copyWith(
        //         data: oldProducts,
        //         hasReachedEnd: true,
        //       );
        //   emit(state.copyWith(
        //     searchStatus: UsecaseStatus.completed,
        //     searchResults: products.copyWith(
        //       data: PaginatedListModel<ProductModel>.from(paginatedList!),
        //     ),
        //   ));
        // } else {
        final paginatedList = PaginatedList<ProductModel>(
          list: newProducts, //[...oldProducts, ...newProducts],
          currentPage: products.data!.currentPage,
          lastPage: products.data!.lastPage,
          itemsCount: products.data!.itemsCount,
          hasReachedEnd: products.data!.hasReachedEnd,
        );
        emit(state.copyWith(
          searchStatus: UsecaseStatus.completed,
          searchResults: products.copyWith(
            data: PaginatedListModel<ProductModel>.from(paginatedList),
          ),
        ));
        // }
      },
    );
  }

  Future<void> getProductDetails(String slug) async {
    emit(state.copyWith(
      productDetailsStatus: UsecaseStatus.running,
      productDetails: const ApiResponse(data: null),
    ));
    final result = await getProductDetailsUsecase(slug);
    if (isClosed) return;
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
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        relatedProductsStatus: UsecaseStatus.error,
        relatedProductsFailure: failure,
      )),
      (products) => emit(state.copyWith(
        relatedProductsStatus: UsecaseStatus.completed,
        relatedProducts: products,
      )),
    );
  }

  Future<void> getYouMayLikeProducts(String slug) async {
    final result = await getYouMayLikeProductsUsecase(slug);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        youMayLikeProductsStatus: UsecaseStatus.error,
        youMayLikeProductsFailure: failure,
      )),
      (products) => emit(state.copyWith(
        youMayLikeProductsStatus: UsecaseStatus.completed,
        youMayLikeProducts: products,
      )),
    );
  }

  Future<void> toggleProductFavourite(int productId, bool value) async {
    setProductFavourite(productId: productId, value: value);
    final result = await toggleFavoriteUsecase(productId);
    if (isClosed) return;
    result.fold(
      (failure) => setProductFavourite(productId: productId, value: !value),
      (products) => emit(state.copyWith(productDetailsStatus: UsecaseStatus.completed)),
    );
  }

  Future<void> getSuggestedCartProducts() async {
    emit(state.copyWith(suggestedCartProductsStatus: UsecaseStatus.running));
    final result = await getSuggestedCartProductsUsecase();
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        suggestedCartProductsStatus: UsecaseStatus.error,
        suggestedCartProductsFailure: failure,
      )),
      (products) => emit(state.copyWith(
        suggestedCartProductsStatus: UsecaseStatus.completed,
        suggestedCartProducts: products.data,
      )),
    );
  }

  Product _getProduct(int productId) {
    final categoryOrBrandProductIndex = state.categoryOrBrandProducts.data!.list.indexWhere((element) => element.id == productId);
    final relatedProductIndex = state.relatedProducts.data!.indexWhere((element) => element.id == productId);
    final youMayLikeProductIndex = state.youMayLikeProducts.data!.indexWhere((element) => element.id == productId);
    final favoriteIndex = state.favoriteProducts.data!.list.indexWhere((element) => element.id == productId);
    final suggestedCartProductsIndex = state.suggestedCartProducts.indexWhere((element) => element.id == productId);
    final latestProductsIndex = state.latestProducts.data!.list.indexWhere((element) => element.id == productId);
    final searchProductIndex = state.searchResults.data!.list.indexWhere((element) => element.id == productId);

    if (categoryOrBrandProductIndex != -1) {
      return state.categoryOrBrandProducts.data!.list[categoryOrBrandProductIndex];
    } else if (relatedProductIndex != -1) {
      return state.relatedProducts.data![relatedProductIndex];
    } else if (youMayLikeProductIndex != -1) {
      return state.youMayLikeProducts.data![youMayLikeProductIndex];
    } else if (favoriteIndex != -1) {
      return state.favoriteProducts.data!.list[favoriteIndex];
    } else if (suggestedCartProductsIndex != -1) {
      return state.suggestedCartProducts[suggestedCartProductsIndex];
    } else if (latestProductsIndex != -1) {
      return state.latestProducts.data!.list[latestProductsIndex];
    } else {
      return state.searchResults.data!.list[searchProductIndex];
    }
  }

  Future<void> setProductFavourite({required int productId, required bool value}) async {
    final categoryOrBrandProductIndex = state.categoryOrBrandProducts.data!.list.indexWhere((element) => element.id == productId);
    final relatedProductIndex = state.relatedProducts.data!.indexWhere((element) => element.id == productId);
    final youMayLikeProductIndex = state.youMayLikeProducts.data!.indexWhere((element) => element.id == productId);
    final favoriteIndex = state.favoriteProducts.data!.list.indexWhere((element) => element.id == productId);
    final suggestedCartProductsIndex = state.suggestedCartProducts.indexWhere((element) => element.id == productId);
    final latestProductsIndex = state.latestProducts.data!.list.indexWhere((element) => element.id == productId);
    final searchProductIndex = state.searchResults.data!.list.indexWhere((element) => element.id == productId);

    final product = _getProduct(productId);
    if (categoryOrBrandProductIndex != -1) {
      emit(state.copyWith(
        categoryOrBrandProducts: state.categoryOrBrandProducts.copyWith(
          data: state.categoryOrBrandProducts.data!.copyWith(
              list: state.categoryOrBrandProducts.data!.list.updateItemAtIndex<ProductModel>(
            categoryOrBrandProductIndex,
            ProductModel.fromProduct(product.copyWith(isFavourite: value)),
          )),
        ),
      ));
    }

    if (relatedProductIndex != -1) {
      emit(state.copyWith(
        relatedProducts: state.relatedProducts.copyWith(
          data: state.relatedProducts.data!.updateItemAtIndex<ProductModel>(
            relatedProductIndex,
            ProductModel.fromProduct(product.copyWith(isFavourite: value)),
          ),
        ),
      ));
    }

    if (youMayLikeProductIndex != -1) {
      emit(state.copyWith(
        youMayLikeProducts: state.youMayLikeProducts.copyWith(
          data: state.youMayLikeProducts.data!.updateItemAtIndex<ProductModel>(
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
            list: state.favoriteProducts.data!.list.updateItemAtIndex<ProductModel>(
              favoriteIndex,
              ProductModel.fromProduct(product.copyWith(isFavourite: value)),
              isRemove: !value,
            ),
          ),
        ),
      ));
    }

    if (suggestedCartProductsIndex != -1) {
      emit(state.copyWith(
        suggestedCartProducts: state.suggestedCartProducts.updateItemAtIndex<ProductModel>(
          suggestedCartProductsIndex,
          ProductModel.fromProduct(product.copyWith(isFavourite: value)),
        ),
      ));
    }

    if (latestProductsIndex != -1) {
      emit(state.copyWith(
        latestProducts: state.latestProducts.copyWith(
          data: state.latestProducts.data!.copyWith(
            list: state.latestProducts.data!.list.updateItemAtIndex<ProductModel>(
              latestProductsIndex,
              ProductModel.fromProduct(product.copyWith(isFavourite: value)),
            ),
          ),
        ),
      ));
    }

    if (searchProductIndex != -1) {
      emit(state.copyWith(
        searchResults: state.searchResults.copyWith(
          data: state.searchResults.data!.copyWith(
            list: state.searchResults.data!.list.updateItemAtIndex<ProductModel>(
              searchProductIndex,
              ProductModel.fromProduct(product.copyWith(isFavourite: value)),
            ),
          ),
        ),
      ));
    }
  }

  Future<void> getFavouriteProducts([int? page]) async {
    if (state.favoriteProducts.data?.hasReachedEnd == true) return;
    if (state.favoriteProducts.data?.currentPage == 0) emit(state.copyWith(favoriteProductsStatus: UsecaseStatus.running));
    if (page != null) emit(state.copyWith(favoriteProducts: const ApiResponse(data: PaginatedList<ProductModel>(list: []))));

    final params = GetPaginatedListParams(page: page ?? (state.favoriteProducts.data!.currentPage) + 1, perPage: 5);
    final result = await getFavouriteProductsUsecase(params);
    result.fold(
      (failure) => emit(state.copyWith(
        favoriteProductsStatus: UsecaseStatus.error,
        favoriteProductsFailure: failure,
      )),
      (favoriteProducts) {
        final newProducts = List<ProductModel>.from(favoriteProducts.data!.list.map((e) => ProductModel.fromProduct(e)));
        if (newProducts.isEmpty) {
          final paginatedList = state.favoriteProducts.data
              ?.copyWith(
                list: state.favoriteProducts.data!.list.map<ProductModel>((e) => ProductModel.fromProduct(e)).toList(),
                hasReachedEnd: true,
              )
              .map<ProductModel>((e) => ProductModel.fromProduct(e));

          emit(state.copyWith(
            favoriteProductsStatus: UsecaseStatus.completed,
            favoriteProducts: favoriteProducts.copyWith(data: paginatedList),
          ));
        } else {
          final oldProducts = List<ProductModel>.from(state.favoriteProducts.data!.list.map((e) => ProductModel.fromProduct(e)));
          final paginatedList = PaginatedList<ProductModel>(
            list: [...oldProducts, ...newProducts],
            currentPage: favoriteProducts.data!.currentPage,
            lastPage: favoriteProducts.data!.lastPage,
            itemsCount: favoriteProducts.data!.itemsCount,
            hasReachedEnd: favoriteProducts.data!.hasReachedEnd,
          );
          emit(state.copyWith(
            favoriteProductsStatus: UsecaseStatus.completed,
            favoriteProducts: favoriteProducts.copyWith(
              data: PaginatedListModel.from(paginatedList),
            ),
          ));
        }
      },
    );
  }

  Future<void> getLatestProducts([int? page]) async {
    if (state.latestProducts.data?.hasReachedEnd == true) return;
    if (state.latestProducts.data?.currentPage == 0) emit(state.copyWith(latestProductsStatus: UsecaseStatus.running));
    if (page != null) emit(state.copyWith(latestProducts: const ApiResponse(data: PaginatedList<ProductModel>(list: []))));

    final params = GetPaginatedListParams(page: page ?? (state.latestProducts.data!.currentPage) + 1, perPage: 5);
    final result = await getFavouriteProductsUsecase(params);
    result.fold(
      (failure) => emit(state.copyWith(
        latestProductsStatus: UsecaseStatus.error,
        latestProductsFailure: failure,
      )),
      (latestProducts) {
        final newProducts = List<ProductModel>.from(latestProducts.data!.list.map((e) => ProductModel.fromProduct(e)));
        if (newProducts.isEmpty) {
          final paginatedList = state.latestProducts.data
              ?.copyWith(
                list: state.latestProducts.data!.list.map<ProductModel>((e) => ProductModel.fromProduct(e)).toList(),
                hasReachedEnd: true,
              )
              .map<ProductModel>((e) => ProductModel.fromProduct(e));

          emit(state.copyWith(
            latestProductsStatus: UsecaseStatus.completed,
            latestProducts: latestProducts.copyWith(data: paginatedList),
          ));
        } else {
          final oldProducts = List<ProductModel>.from(state.latestProducts.data!.list.map((e) => ProductModel.fromProduct(e)));
          final paginatedList = PaginatedList<ProductModel>(
            list: [...oldProducts, ...newProducts],
            currentPage: latestProducts.data!.currentPage,
            lastPage: latestProducts.data!.lastPage,
            itemsCount: latestProducts.data!.itemsCount,
            hasReachedEnd: latestProducts.data!.hasReachedEnd,
          );
          emit(state.copyWith(
            latestProductsStatus: UsecaseStatus.completed,
            latestProducts: latestProducts.copyWith(
              data: PaginatedListModel.from(paginatedList),
            ),
          ));
        }
      },
    );
  }
}
