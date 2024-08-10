import 'package:get_it/get_it.dart';

import '../../features/home/di/setup_home_dependencies.dart';
import '../../features/user/di/setup_user_dependencies.dart';
import '../../features/product/di/setup_product_dependencies.dart';
import '../networking/api_service.dart';
import '../networking/dio_service.dart';

class DependencyHelper {
  DependencyHelper._();
  static final DependencyHelper instance = DependencyHelper._();
  factory DependencyHelper() => instance;

  final GetIt serviceLocator = GetIt.instance;

  void registerDependencies() {
    setUpGeneralDependencies();
    setUpUserDependencies();
    setUpProductDependencies();
    setUpHomeDependencies();
  }

  void setUpGeneralDependencies() {
    serviceLocator.registerLazySingleton<ApiService>(() => DioService());
  }
}

extension DependencyHelperExt on DependencyHelper {
  T get<T extends Object>() => serviceLocator<T>();
}
