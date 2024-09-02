import '../../../core/helpers/dependency_helper.dart';
import '../data/data_imports.dart';
import '../domain/domain_imports.dart';
import '../presentation/presentation_imports.dart';

void setUpBrandDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerFactory(
    () => BrandCubit(
      getBrandsUsecase: DependencyHelper.instance.serviceLocator(),
    ),
  );

  // USECASES
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetBrandsUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  // REPOSITORIES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<BrandRepository>(
    () => BrandRepositoryImpl(
      checker: DependencyHelper.instance.serviceLocator(),
      remoteDataSource: DependencyHelper.instance.serviceLocator(),
      localDataSource: DependencyHelper.instance.serviceLocator(),
    ),
  );

  // DATASOURCES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<BrandRemoteDataSource>(
    () => BrandRemoteDataSourceImpl(),
  );
  DependencyHelper.instance.serviceLocator.registerLazySingleton<BrandLocalDataSource>(
    () => BrandLocalDataSourceImpl(),
  );
}
