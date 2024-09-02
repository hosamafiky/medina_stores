import '../../../core/helpers/dependency_helper.dart';
import '../data/data_imports.dart';
import '../domain/domain_imports.dart';
import '../presentation/presentation_imports.dart';

void setUpCategoryDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerFactory(
    () => CategoryCubit(
      getCategoriesUsecase: DependencyHelper.instance.serviceLocator(),
    ),
  );

  // USECASES
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetCategoriesUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  // REPOSITORIES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      checker: DependencyHelper.instance.serviceLocator(),
      remoteDataSource: DependencyHelper.instance.serviceLocator(),
      localDataSource: DependencyHelper.instance.serviceLocator(),
    ),
  );

  // DATASOURCES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(),
  );
  DependencyHelper.instance.serviceLocator.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSourceImpl(),
  );
}
