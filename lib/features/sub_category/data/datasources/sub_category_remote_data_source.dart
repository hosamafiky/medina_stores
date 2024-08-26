part of '../data_imports.dart';

abstract class SubCategoryRemoteDataSource {
  Future<ApiResponse<List<SubCategoryModel>>> getSubCategories(int categoryId);
  Future<ApiResponse<SubCategoryModel>> addSubCategory(AddSubCategoryParams params);
}

class SubCategoryRemoteDataSourceImpl implements SubCategoryRemoteDataSource {
  @override
  Future<ApiResponse<List<SubCategoryModel>>> getSubCategories(int categoryId) async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: '${ApiConstants.endPoints.CATEGORIES}/$categoryId/${ApiConstants.endPoints.SUB_CATEGORIES}',
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<List<SubCategoryModel>>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => List<SubCategoryModel>.from(data['data'].map((x) => SubCategoryModel.fromMap(x))),
          ),
        );
  }

  @override
  Future<ApiResponse<SubCategoryModel>> addSubCategory(AddSubCategoryParams params) async {
    final request = ApiRequest(
      method: RequestMethod.post,
      path: "/dashboard/branches",
      body: params.toMap(),
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<SubCategoryModel>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => SubCategoryModel.fromMap(data),
          ),
        );
  }
}
