part of '../data_imports.dart';

abstract class BrandLocalDataSource {
  Future<List<BrandModel>> getCachedBrands();
  Future<void> cacheBrands(List<BrandModel> brands);
}

class BrandLocalDataSourceImpl implements BrandLocalDataSource {
  BrandLocalDataSourceImpl();

  @override
  Future<List<BrandModel>> getCachedBrands() async {
    try {
      final jsonList = await CacheHelper.read(CacheKeys.brands, isDecoded: true);
      return List<BrandModel>.from(jsonList.map((json) => BrandModel.fromMap(json)));
    } catch (e) {
      throw CacheException(ApiResponse(message: e.toString()));
    }
  }

  @override
  Future<void> cacheBrands(List<BrandModel> brands) async {
    try {
      final jsonList = brands.map((brand) => brand.toMap()).toList();
      return await CacheHelper.write(CacheKeys.brands, json.encode(jsonList));
    } catch (e) {
      throw CacheException(ApiResponse(message: e.toString()));
    }
  }
}
