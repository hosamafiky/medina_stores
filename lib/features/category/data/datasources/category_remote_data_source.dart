part of '../data_imports.dart';

abstract class CategoryRemoteDataSource {
  Future<ApiResponseModel<List<CategoryModel>>> get getCategories;
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  @override
  Future<ApiResponseModel<List<CategoryModel>>> get getCategories async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.CATEGORIES,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<List<CategoryModel>>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => List<CategoryModel>.from(data['data'].map((x) => CategoryModel.fromMap(x))),
          ),
        );
  }
}
