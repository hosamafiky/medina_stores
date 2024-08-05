import 'package:medina_stores/core/helpers/dependency_helper.dart';

import '../presentation/cubit/home_cubit.dart';

void setUpHomeDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerFactory(() => HomeCubit());
}
