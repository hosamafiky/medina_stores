import '../../../core/helpers/dependency_helper.dart';
import '../presentation/presentation_imports.dart';

void setUpLayoutDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerFactory(
    () => LayoutCubit(),
  );
}
