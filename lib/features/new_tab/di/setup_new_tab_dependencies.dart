import '../../../core/helpers/dependency_helper.dart';
import '../data/data_imports.dart';
import '../domain/domain_imports.dart';
import '../presentation/presentation_imports.dart';

void setUpNewTabDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerFactory(
    () => NewTabCubit(),
  );

  // USECASES

  // REPOSITORIES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<NewTabRepository>(
    () => NewTabRepositoryImpl(remoteDataSource: DependencyHelper.instance.serviceLocator()),
  );

  // DATASOURCES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<NewTabRemoteDataSource>(
    () => NewTabRemoteDataSourceImpl(),
  );
}
