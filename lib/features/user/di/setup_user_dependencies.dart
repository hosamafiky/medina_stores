import 'package:medina_stores/core/helpers/dependency_helper.dart';
import 'package:medina_stores/features/user/presentation/cubit/user_cubit.dart';

void setUpUserDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerFactory(() => UserCubit());
}
