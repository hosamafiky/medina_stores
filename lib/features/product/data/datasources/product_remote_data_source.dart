part of '../data_imports.dart';

abstract class ProductRemoteDataSource {
  Future<ApiResponseModel<PaginatedListModel<ProductModel>>> getSubCategoryProducts(GetCategoryProductsParams params);
  Future<ApiResponseModel<PaginatedListModel<ProductModel>>> getBrandProducts(GetBrandProductsParams params);
  Future<ApiResponseModel<ProductDetailsModel>> getProductDetails(String slug);
  Future<ApiResponseModel<List<ProductModel>>> getRelatedProducts(String slug);
  Future<ApiResponseModel<List<ProductModel>>> getYouMayLikeProducts(String slug);
  Future<ApiResponseModel<bool>> toggleFavorite(int productId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<ApiResponseModel<PaginatedListModel<ProductModel>>> getSubCategoryProducts(GetCategoryProductsParams params) async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.PRODUCTS,
      queryParameters: params.toMap(),
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
}
