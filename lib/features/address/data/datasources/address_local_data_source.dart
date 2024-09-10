part of '../data_imports.dart';

abstract class AddressLocalDataSource {
  Future<List<AddressModel>> getCachedAddresss();
  Future<void> cacheAddresses(List<AddressModel> addresses);
}

class AddressLocalDataSourceImpl implements AddressLocalDataSource {
  AddressLocalDataSourceImpl();

  @override
  Future<List<AddressModel>> getCachedAddresss() async {
    try {
      final jsonString = await CacheHelper.read(CacheKeys.userAddresses);
      final jsonList = json.decode(jsonString) as List;
      return List<AddressModel>.from(jsonList.map((json) => AddressModel.fromMap(json)));
    } catch (e) {
      throw CacheException(ApiResponse(message: e.toString()));
    }
  }

  @override
  Future<void> cacheAddresses(List<AddressModel> addresses) async {
    final jsonList = addresses.map((address) => address.toMap()).toList();
    return await CacheHelper.write(CacheKeys.userAddresses, json.encode(jsonList));
  }
}
