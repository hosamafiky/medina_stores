part of '../data_imports.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheLatestProducts(List<ProductModel> products);
  Future<List<ProductModel>> getCachedLatestProducts();
  Future<void> cacheFavouriteProducts(List<ProductModel> products);
  Future<List<ProductModel>> getCachedFavouriteProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  @override
  Future<void> cacheLatestProducts(List<ProductModel> products) async {
    final jsonList = products.map((product) => product.toMap()).toList();
    return await CacheHelper.write(CacheKeys.latestProducts, json.encode(jsonList));
  }

  @override
  Future<List<ProductModel>> getCachedLatestProducts() async {
    try {
      final jsonString = await CacheHelper.read(CacheKeys.latestProducts);
      final jsonList = json.decode(jsonString) as List;
      return List<ProductModel>.from(jsonList.map((json) => ProductModel.fromMap(json)));
    } catch (e) {
      throw CacheException(ApiResponse(message: e.toString()));
    }
  }

  @override
  Future<void> cacheFavouriteProducts(List<ProductModel> products) async {
    final jsonList = products.map((product) => product.toMap()).toList();
    return await CacheHelper.write(CacheKeys.favoriteProducts, json.encode(jsonList));
  }

  @override
  Future<List<ProductModel>> getCachedFavouriteProducts() async {
    try {
      final jsonString = await CacheHelper.read(CacheKeys.favoriteProducts);
      final jsonList = json.decode(jsonString) as List;
      return List<ProductModel>.from(jsonList.map((json) => ProductModel.fromMap(json)));
    } catch (e) {
      throw CacheException(ApiResponse(message: e.toString()));
    }
  }
}
