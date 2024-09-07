import '../../../core/helpers/dependency_helper.dart';
import '../presentation/presentation_imports.dart';

void setUpNewTabDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerFactory(
    () => NewTabCubit(),
  );

  // USECASES

  // REPOSITORIES

  // DATASOURCES
}
