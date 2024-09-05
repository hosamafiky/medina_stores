part of '../data_imports.dart';

abstract class CartLocalDataSource {
  Future<CartDataModel> fetchCachedCartData();
  Future<void> storeCartData(CartDataModel ads);
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
}
