part of '../data_imports.dart';

abstract class StaticPageLocalDataSource {
  Future<ApiResponseModel<String>> getStaticPageData(String path);
  Future<void> cacheStaticPageData(String path, String data);
}

class StaticPageLocalDataSourceImpl implements StaticPageLocalDataSource {
  @override
  Future<void> cacheStaticPageData(String path, String data) async {
    try {
      final cachedJson = await CacheHelper.read(CacheKeys.staticPages);
      if (cachedJson == null) {
        return await CacheHelper.write(CacheKeys.staticPages, json.encode({path: data}));
      }
      final dataAsMap = Map<String, dynamic>.from(jsonDecode(cachedJson));
      if (dataAsMap.containsKey(path)) {
        dataAsMap[path] = data;
      } else {
        dataAsMap.addAll({path: data});
      }
      return await CacheHelper.write(CacheKeys.staticPages, json.encode(dataAsMap));
    } catch (e) {
      throw CacheException(ApiResponse(message: e.toString()));
    }
  }

  @override
  Future<ApiResponseModel<String>> getStaticPageData(String path) async {
    final cachedJson = await CacheHelper.read(CacheKeys.staticPages);
    final dataAsMap = Map<String, dynamic>.from(jsonDecode(cachedJson));
    if (dataAsMap.containsKey(path)) {
      return ApiResponseModel(data: dataAsMap[path]);
    } else {
      throw const CacheException(ApiResponse(message: 'No cached data found'));
    }
  }
}
