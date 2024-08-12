import '../../features/user/data/data_imports.dart';
import '../../features/user/domain/domain_imports.dart';
import '../helpers/cache_helper.dart';

class UserUtils {
  static Future<User?> getCachedUser() async {
    final cachedToken = await SecureStorage.read(CacheKeys.token);
    if (cachedToken != null && cachedToken.isNotEmpty) {
      final cachedUser = await CacheHelper.read(CacheKeys.user);
      if (cachedUser != null && cachedUser.isNotEmpty) {
        final user = UserModel.fromJson(cachedUser).copyWith(token: cachedToken);
        return user;
      }
    } else {
      await CacheHelper.delete(CacheKeys.user);
    }
    return null;
  }
}
