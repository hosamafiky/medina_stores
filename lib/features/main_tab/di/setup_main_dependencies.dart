import '../../../core/helpers/dependency_helper.dart';
import '../presentation/presentation_imports.dart';

void setUpMainDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerFactory(
    () => MainCubit(),
  );
}
