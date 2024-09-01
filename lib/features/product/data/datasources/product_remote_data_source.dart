part of '../data_imports.dart';

abstract class ProductRemoteDataSource {
  Future<ApiResponseModel<PaginatedListModel<ProductModel>>> getSubCategoryProducts(GetCategoryProductsParams params);
  Future<ApiResponseModel<PaginatedListModel<ProductModel>>> getBrandProducts(GetBrandProductsParams params);
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
}
