part of '../data_imports.dart';

abstract class AdLocalDataSource {
  Future<List<AdModel>> getCachedAds();
  Future<void> cacheAds(List<AdModel> ads);
}

class AdLocalDataSourceImpl implements AdLocalDataSource {
  AdLocalDataSourceImpl();

  @override
  Future<List<AdModel>> getCachedAds() async {
    try {
      final jsonString = await CacheHelper.read(CacheKeys.ads);
      final jsonList = json.decode(jsonString) as List;
      return List<AdModel>.from(jsonList.map((json) => AdModel.fromMap(json)));
    } catch (e) {
      throw CacheException(ApiResponse(message: e.toString()));
    }
  }

  @override
  Future<void> cacheAds(List<AdModel> ads) async {
    final jsonList = ads.map((ad) => ad.toMap()).toList();
    return await CacheHelper.write(CacheKeys.ads, json.encode(jsonList));
  }
}
