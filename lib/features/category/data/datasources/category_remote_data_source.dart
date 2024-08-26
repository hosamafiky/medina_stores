part of '../data_imports.dart';

abstract class CategoryRemoteDataSource {
  Future<ApiResponse<List<CategoryModel>>> get getCategories;
  Future<ApiResponse<CategoryModel>> addCategory(AddCategoryParams params);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  @override
  Future<ApiResponse<List<CategoryModel>>> get getCategories async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.CATEGORIES,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<List<CategoryModel>>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => List<CategoryModel>.from(data['data'].map((x) => CategoryModel.fromMap(x))),
          ),
        );
  }

  @override
  Future<ApiResponse<CategoryModel>> addCategory(AddCategoryParams params) async {
    final request = ApiRequest(
      method: RequestMethod.post,
      path: "/dashboard/branches",
      body: params.toMap(),
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<CategoryModel>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => CategoryModel.fromMap(data),
          ),
        );
  }
}
