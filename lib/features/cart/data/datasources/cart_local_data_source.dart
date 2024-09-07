part of '../data_imports.dart';

abstract class CartLocalDataSource {
  Future<CartDataModel> fetchCachedCartData();
  Future<void> storeCartData(CartDataModel ads);
  Future<List<ProductModel>> fetchCachedSuggestedProducts();
  Future<void> storeSuggestedCartProducts(List<ProductModel> products);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  CartLocalDataSourceImpl();

  @override
  Future<CartDataModel> fetchCachedCartData() async {
    try {
      final jsonString = await CacheHelper.read(CacheKeys.cart);
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return CartDataModel.fromMap(jsonMap);
    } catch (e) {
      throw CacheException(ApiResponse(message: e.toString()));
    }
  }

  @override
  Future<void> storeCartData(CartDataModel cart) async {
    return await CacheHelper.write(CacheKeys.cart, json.encode(cart.toMap()));
  }

  @override
  Future<List<ProductModel>> fetchCachedSuggestedProducts() async {
    try {
      final jsonString = await CacheHelper.read(CacheKeys.suggestedCartProducts);
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return List<ProductModel>.from(jsonMap['data'].map((x) => ProductModel.fromMap(x)));
    } catch (e) {
      throw CacheException(ApiResponse(message: e.toString()));
    }
  }

  @override
  Future<void> storeSuggestedCartProducts(List<ProductModel> products) async {
    return await CacheHelper.write(CacheKeys.suggestedCartProducts, json.encode(products.map((x) => x.toMap()).toList()));
  }
}
