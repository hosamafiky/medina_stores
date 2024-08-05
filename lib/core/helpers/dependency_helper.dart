import 'package:get_it/get_it.dart';
import 'package:medina_stores/features/user/di/setup_user_dependencies.dart';

import '../../features/home/di/setup_home_dependencies.dart';

class DependencyHelper {
  DependencyHelper._();
  static final DependencyHelper instance = DependencyHelper._();
  factory DependencyHelper() => instance;

  final GetIt serviceLocator = GetIt.instance;

  void registerDependencies() {
    setUpUserDependencies();
    setUpHomeDependencies();
  }
}

extension DependencyHelperExt on DependencyHelper {
  T get<T extends Object>() => serviceLocator<T>();
}
