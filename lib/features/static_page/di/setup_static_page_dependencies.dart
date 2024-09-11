import '../../../core/helpers/dependency_helper.dart';
import '../data/data_imports.dart';
import '../domain/domain_imports.dart';
import '../presentation/presentation_imports.dart';

void setUpStaticPageDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerFactory(
    () => StaticPageCubit(
      getStaticPageUsecase: DependencyHelper.instance.serviceLocator(),
    ),
  );

  // USECASES
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetStaticPagesUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  // REPOSITORIES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<StaticPageRepository>(
    () => StaticPageRepositoryImpl(
      connectionChecker: DependencyHelper.instance.serviceLocator(),
      remoteDataSource: DependencyHelper.instance.serviceLocator(),
      localDataSource: DependencyHelper.instance.serviceLocator(),
    ),
  );

  // DATASOURCES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<StaticPageRemoteDataSource>(
    () => StaticPageRemoteDataSourceImpl(),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton<StaticPageLocalDataSource>(
    () => StaticPageLocalDataSourceImpl(),
  );
}
