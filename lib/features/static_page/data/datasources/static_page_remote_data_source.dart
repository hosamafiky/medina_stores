part of '../data_imports.dart';

abstract class StaticPageRemoteDataSource {
  Future<ApiResponseModel<String>> getStaticPageData(String path);
}

class StaticPageRemoteDataSourceImpl implements StaticPageRemoteDataSource {
  @override
  Future<ApiResponseModel<String>> getStaticPageData(String path) async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: path,
    );
    return await DependencyHelper.instance.get<ApiService>().callApi<String>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(json),
        );
  }
}
