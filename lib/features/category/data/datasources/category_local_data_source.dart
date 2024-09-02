part of '../data_imports.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCachedCategories();
  Future<void> cacheCategories(List<CategoryModel> categories);
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    try {
      final jsonList = categories.map((category) => category.toMap()).toList();
      return await CacheHelper.write(CacheKeys.categories, json.encode(jsonList));
    } catch (e) {
      throw CacheException(ApiResponse(message: e.toString()));
    }
  }

  @override
  Future<List<CategoryModel>> getCachedCategories() async {
    try {
      final jsonList = await CacheHelper.read(CacheKeys.categories, isDecoded: true);
      return List<CategoryModel>.from(jsonList.map((json) => CategoryModel.fromMap(json)));
    } catch (e) {
      throw CacheException(ApiResponse(message: e.toString()));
    }
  }
}
