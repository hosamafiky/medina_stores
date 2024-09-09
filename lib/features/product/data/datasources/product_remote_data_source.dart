part of '../data_imports.dart';

abstract class ProductRemoteDataSource {
  Future<ApiResponseModel<PaginatedListModel<ProductModel>>> getSubCategoryProducts(GetCategoryProductsParams params);
  Future<ApiResponseModel<PaginatedListModel<ProductModel>>> getBrandProducts(GetBrandProductsParams params);
  Future<ApiResponseModel<ProductDetailsModel>> getProductDetails(String slug);
  Future<ApiResponseModel<List<ProductModel>>> getRelatedProducts(String slug);
  Future<ApiResponseModel<List<ProductModel>>> getYouMayLikeProducts(String slug);
  Future<ApiResponseModel<PaginatedListModel<ProductModel>>> getFavouriteProducts(GetPaginatedListParams params);
  Future<ApiResponseModel<List<ProductModel>>> getSuggestedCartProducts();
  Future<ApiResponseModel<PaginatedListModel<ProductModel>>> getLatestProducts(GetPaginatedListParams params);
  Future<ApiResponseModel<List<DropdownItemModel>>> getProductNameSuggestions(String query);
  Future<ApiResponseModel<PaginatedListModel<ProductModel>>> getSearchProducts(String query);
  Future<ApiResponseModel<bool>> toggleFavorite(int productId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<ApiResponseModel<PaginatedListModel<ProductModel>>> getSubCategoryProducts(GetCategoryProductsParams params) async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.PRODUCTS,
      queryParameters: params.toMap(),
      headers: AppNavigator.rootContext!.currentAddress?.asHeader,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<PaginatedListModel<ProductModel>>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => PaginatedListModel<ProductModel>.fromMap(
              data['data'],
              mapper: (x) => ProductModel.fromMap(x),
            ),
          ),
        );
  }

  @override
  Future<ApiResponseModel<PaginatedListModel<ProductModel>>> getBrandProducts(GetBrandProductsParams params) async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.PRODUCTS,
      queryParameters: params.toMap(),
      headers: AppNavigator.rootContext!.currentAddress?.asHeader,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<PaginatedListModel<ProductModel>>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => PaginatedListModel<ProductModel>.fromMap(
              data['data'],
              mapper: (x) => ProductModel.fromMap(x),
            ),
          ),
        );
  }

  @override
  Future<ApiResponseModel<ProductDetailsModel>> getProductDetails(String slug) async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: '${ApiConstants.endPoints.PRODUCTS}/$slug',
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<ProductDetailsModel>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => ProductDetailsModel.fromMap(data['data']),
          ),
        );
  }

  @override
  Future<ApiResponseModel<List<ProductModel>>> getRelatedProducts(String slug) async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: '${ApiConstants.endPoints.PRODUCT}/$slug/related',
      headers: AppNavigator.rootContext!.currentAddress?.asHeader,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<List<ProductModel>>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => List<ProductModel>.from(data['data'].map((e) => ProductModel.fromMap(e))),
          ),
        );
  }

  @override
  Future<ApiResponseModel<List<ProductModel>>> getYouMayLikeProducts(String slug) async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: '${ApiConstants.endPoints.PRODUCT}/$slug/you-may-like',
      headers: AppNavigator.rootContext!.currentAddress?.asHeader,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<List<ProductModel>>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => List<ProductModel>.from(data['data'].map((e) => ProductModel.fromMap(e))),
          ),
        );
  }

  @override
  Future<ApiResponseModel<bool>> toggleFavorite(int productId) async {
    final request = ApiRequest(
      method: RequestMethod.post,
      path: '${ApiConstants.endPoints.PRODUCT}/$productId/toggle-favorite',
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<bool>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => data['data']['is_favourite'],
          ),
        );
  }

  @override
  Future<ApiResponseModel<PaginatedListModel<ProductModel>>> getFavouriteProducts(GetPaginatedListParams params) async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.FAV_PRODUCTS,
      queryParameters: params.toMap(),
      headers: AppNavigator.rootContext!.currentAddress?.asHeader,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<PaginatedListModel<ProductModel>>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => PaginatedListModel<ProductModel>.fromMap(
              data['data'],
              mapper: (x) => ProductModel.fromMap(x),
            ),
          ),
        );
  }

  @override
  Future<ApiResponseModel<List<ProductModel>>> getSuggestedCartProducts() async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: '/cart/suggested-products',
      headers: AppNavigator.rootContext!.currentAddress?.asHeader,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<List<ProductModel>>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => List<ProductModel>.from(data['data'].map((x) => ProductModel.fromMap(x))),
          ),
        );
  }

  @override
  Future<ApiResponseModel<PaginatedListModel<ProductModel>>> getLatestProducts(GetPaginatedListParams params) async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: '${ApiConstants.endPoints.PRODUCTS}/latest',
      queryParameters: params.toMap(),
      headers: AppNavigator.rootContext!.currentAddress?.asHeader,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<PaginatedListModel<ProductModel>>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => PaginatedListModel<ProductModel>.fromMap(
              data['data'],
              mapper: (x) => ProductModel.fromMap(x),
            ),
          ),
        );
  }

  @override
  Future<ApiResponseModel<PaginatedListModel<ProductModel>>> getSearchProducts(String query) async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.PRODUCTS,
      queryParameters: {'search': query},
      headers: AppNavigator.rootContext!.currentAddress?.asHeader,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<PaginatedListModel<ProductModel>>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => PaginatedListModel<ProductModel>.fromMap(
              data['data'],
              mapper: (x) => ProductModel.fromMap(x),
            ),
          ),
        );
  }

  @override
  Future<ApiResponseModel<List<DropdownItemModel>>> getProductNameSuggestions(String query) async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: '${ApiConstants.endPoints.PRODUCTS}/auto-complete',
      queryParameters: {'search': query},
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<List<DropdownItemModel>>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => List<DropdownItemModel>.from(
              data['data'].map((x) => DropdownItemModel.fromMap(x)),
            ),
          ),
        );
  }
}
