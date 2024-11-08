part of '../data_imports.dart';

abstract class BrandLocalDataSource {
  Future<List<BrandModel>> getCachedBrands();
  Future<void> cacheBrands(List<BrandModel> brands);
}

class BrandLocalDataSourceImpl implements BrandLocalDataSource {
  BrandLocalDataSourceImpl();

  @override
  Future<List<BrandModel>> getCachedBrands() async {
    final jsonString = await CacheHelper.read(CacheKeys.brands);
    final jsonList = json.decode(jsonString) as List;
    return List<BrandModel>.from(jsonList.map((json) => BrandModel.fromMap(json)));
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
