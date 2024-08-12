import 'package:get_it/get_it.dart';

import '../../features/layout/di/setup_layout_dependencies.dart';
import '../../features/main/di/setup_main_dependencies.dart';
import '../../features/order/di/setup_order_dependencies.dart';
import '../../features/profile/di/setup_profile_dependencies.dart';
import '../../features/user/di/setup_user_dependencies.dart';
import '../networking/api_service.dart';
import '../networking/dio_service.dart';

class DependencyHelper {
  DependencyHelper._();
  static final DependencyHelper instance = DependencyHelper._();
  factory DependencyHelper() => instance;

  final GetIt serviceLocator = GetIt.instance;

  void registerDependencies() {
    setUpGeneralDependencies();
    setUpProfileDependencies();
    setUpOrderDependencies();
    setUpMainDependencies();
    setUpLayoutDependencies();
    setUpUserDependencies();
  }

  void setUpGeneralDependencies() {
    serviceLocator.registerLazySingleton<ApiService>(() => DioService());
  }
}

extension DependencyHelperExt on DependencyHelper {
  T get<T extends Object>() => serviceLocator<T>();
}
