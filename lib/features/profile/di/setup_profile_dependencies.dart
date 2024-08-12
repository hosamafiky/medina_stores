import '../../../core/helpers/dependency_helper.dart';
import '../data/data_imports.dart';
import '../domain/domain_imports.dart';
import '../presentation/presentation_imports.dart';

void setUpProfileDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerFactory(
    () => ProfileCubit(
      getProfilesUsecase: DependencyHelper.instance.serviceLocator(),
      addProfileUsecase: DependencyHelper.instance.serviceLocator(),
    ),
  );

  // USECASES
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => GetProfilesUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => AddProfileUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );

  // REPOSITORIES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: DependencyHelper.instance.serviceLocator()),
  );

  // DATASOURCES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(),
  );
}