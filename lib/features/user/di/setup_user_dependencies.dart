import '../../../core/helpers/dependency_helper.dart';
import '../data/data_imports.dart';
import '../domain/domain_imports.dart';
import '../presentation/presentation_imports.dart';

void setUpUserDependencies() async {
  // CUBIT
  DependencyHelper.instance.serviceLocator.registerFactory(
    () => UserCubit(
      loginUsecase: DependencyHelper.instance.serviceLocator(),
      logoutUsecase: DependencyHelper.instance.serviceLocator(),
      registerUsecase: DependencyHelper.instance.serviceLocator(),
      sendOTPUseCase: DependencyHelper.instance.serviceLocator(),
    ),
  );

  // USECASES
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => LoginUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => LogoutUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => RegisterUsecase(repository: DependencyHelper.instance.serviceLocator()),
  );
  DependencyHelper.instance.serviceLocator.registerLazySingleton(
    () => SendOTPUseCase(repository: DependencyHelper.instance.serviceLocator()),
  );

  // REPOSITORIES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: DependencyHelper.instance.serviceLocator()),
  );

  // DATASOURCES
  DependencyHelper.instance.serviceLocator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );
}
